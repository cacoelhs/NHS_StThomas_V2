# NHS St Thomas V2 - Infrastructure as Code

This project uses Terraform to manage Azure infrastructure for NHS St Thomas V2 application using Infrastructure as Code (IaC) principles.

## Overview

This repository contains Terraform configurations for deploying and managing Azure resources through Azure DevOps pipelines.

## Prerequisites

- Azure subscription
- Azure DevOps account with a configured service connection to Azure
- Terraform >= 1.5.0
- Azure CLI (for local development)

## Project Structure

```
├── terraform/
│   ├── main.tf              # Main infrastructure resources
│   ├── variables.tf         # Variable definitions
│   ├── outputs.tf           # Output values
│   ├── versions.tf          # Terraform and provider version constraints
│   ├── backend.hcl.example  # Example backend configuration
│   └── terraform.tfvars.example  # Example variable values
├── azure-pipelines.yml      # Azure DevOps pipeline configuration
├── .gitignore              # Git ignore rules for Terraform
└── README.md               # This file
```

## Infrastructure Resources

The Terraform configuration creates the following Azure resources:

- **Resource Group**: Container for all Azure resources
- **Storage Account**: Azure Storage for application data
- **Storage Container**: Blob container for data storage

## Getting Started

### Local Development

1. **Clone the repository**:
   ```bash
   git clone https://github.com/cacoelhs/NHS_StThomas_V2.git
   cd NHS_StThomas_V2
   ```

2. **Configure Azure authentication**:
   ```bash
   az login
   az account set --subscription <subscription-id>
   ```

3. **Set up backend configuration**:
   ```bash
   cd terraform
   cp backend.hcl.example backend.hcl
   # Edit backend.hcl with your Azure Storage account details
   ```

4. **Set up variables**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your desired values
   ```

5. **Initialize Terraform**:
   ```bash
   terraform init -backend-config="backend.hcl"
   ```

6. **Plan infrastructure changes**:
   ```bash
   terraform plan
   ```

7. **Apply infrastructure changes**:
   ```bash
   terraform apply
   ```

### Azure DevOps Setup

1. **Create a service connection** in Azure DevOps:
   - Go to Project Settings > Service connections
   - Create a new Azure Resource Manager service connection
   - Name it `Azure-Service-Connection`

2. **Create backend storage** (one-time setup):
   ```bash
   # Create resource group for Terraform state
   az group create --name rg-terraform-state --location "UK South"
   
   # Create storage account for Terraform state
   az storage account create \
     --name sttfstate<uniqueid> \
     --resource-group rg-terraform-state \
     --location "UK South" \
     --sku Standard_LRS
   
   # Create blob container
   az storage container create \
     --name tfstate \
     --account-name sttfstate<uniqueid>
   ```

3. **Update pipeline configuration**:
   - Update `azure-pipelines.yml` with your storage account name
   - Update service connection name if different

4. **Create pipeline** in Azure DevOps:
   - Go to Pipelines > New Pipeline
   - Select your repository
   - Use the existing `azure-pipelines.yml` file

## Pipeline Workflow

The Azure DevOps pipeline consists of three stages:

1. **Validate**: 
   - Installs Terraform
   - Validates Terraform configuration
   - Checks code formatting

2. **Plan**:
   - Creates an execution plan
   - Publishes the plan as a pipeline artifact

3. **Apply** (only on main branch):
   - Downloads the plan artifact
   - Applies the infrastructure changes
   - Requires approval through the Production environment

## Variables

Key variables that can be customized (see `terraform/variables.tf`):

- `environment`: Environment name (dev, test, prod)
- `location`: Azure region for resources
- `project_name`: Project name used for resource naming
- `resource_group_name`: Custom resource group name (optional)
- `tags`: Tags to apply to all resources

## Security Considerations

- Terraform state files contain sensitive information and should be stored securely in Azure Storage with encryption
- `.tfvars` files are excluded from version control to prevent accidental exposure of sensitive data
- Use Azure DevOps variable groups or Key Vault for sensitive values
- Service principals should follow the principle of least privilege

## Contributing

1. Create a feature branch
2. Make your changes
3. Test locally with `terraform plan`
4. Submit a pull request
5. Pipeline will automatically validate and plan changes
6. Merge to main will trigger deployment (after approval)

## Support

For issues or questions, please contact the project maintainers.
