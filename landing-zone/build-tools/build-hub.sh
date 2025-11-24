#!/bin/bash
set -e

# Terraform deployment script for GSTT SDE Infrastructure
# This script handles terraform operations across different project areas

# Variables from pipeline
OPERATION=${1:-plan}
TF_CONFIGURATION=${DEPLOYMENT_AREA:-gstt-lz}
PROJECT=${PROJECT_NAME:-network}
ENVIRONMENT=${ENVIRONMENT:-DEV}

echo "============================================"
echo "GSTT SDE Terraform Deployment"
echo "============================================"
echo "Operation: $OPERATION"
echo "Project: $PROJECT"
echo "Environment: $ENVIRONMENT"
echo "Configuration: $TF_CONFIGURATION"
echo "============================================"

# Set working directory based on project
WORKING_DIR="landing-zone/${PROJECT}"

if [ ! -d "$WORKING_DIR" ]; then
  echo "❌ Error: Directory $WORKING_DIR does not exist"
  exit 1
fi

cd "$WORKING_DIR"
echo "📁 Working directory: $(pwd)"

# Initialize Terraform
echo "🔧 Initializing Terraform..."
terraform init \
  -backend-config="resource_group_name=${TF_VAR_state_storage_rg}" \
  -backend-config="storage_account_name=${TF_VAR_state_storage_acct_name}" \
  -backend-config="container_name=${TF_VAR_state_storage_container_name}" \
  -backend-config="key=${PROJECT}-${ENVIRONMENT}.terraform.tfstate"

# Validate Terraform configuration
echo "✅ Validating Terraform configuration..."
terraform validate

# Execute the requested operation
case "$OPERATION" in
  plan)
    echo "📋 Running Terraform Plan..."
    terraform plan \
      -var-file="vnets.tfvars" \
      -var-file="subnets.tfvars" \
      -out=tfplan
    ;;
  
  plan-jsonop)
    echo "📋 Running Terraform Plan (JSON output)..."
    terraform plan \
      -var-file="vnets.tfvars" \
      -var-file="subnets.tfvars" \
      -out=tfplan
    terraform show -json tfplan > tfplan.json
    ;;
  
  apply)
    echo "🚀 Running Terraform Apply..."
    if [ -f "tfplan" ]; then
      terraform apply ${AUTO_APPROVE_OPERATION} tfplan
    else
      terraform apply ${AUTO_APPROVE_OPERATION} \
        -var-file="vnets.tfvars" \
        -var-file="subnets.tfvars"
    fi
    ;;
  
  destroy)
    echo "💥 Running Terraform Destroy..."
    terraform destroy ${AUTO_APPROVE_OPERATION} \
      -var-file="vnets.tfvars" \
      -var-file="subnets.tfvars"
    ;;
  
  test)
    echo "🧪 Running Terraform Test..."
    terraform fmt -check -recursive
    terraform validate
    ;;
  
  *)
    echo "❌ Unknown operation: $OPERATION"
    echo "Valid operations: plan, plan-jsonop, apply, destroy, test"
    exit 1
    ;;
esac

echo "✅ Operation completed successfully!"
