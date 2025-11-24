# Quick Start Guide

## Prerequisites Checklist
- [ ] Azure subscription
- [ ] Azure DevOps account
- [ ] Azure CLI installed (for local development)
- [ ] Terraform >= 1.5.0 installed

## Initial Setup (First Time Only)

### 1. Create Terraform State Storage in Azure
```bash
# Login to Azure
az login

# Create resource group for Terraform state
az group create --name rg-terraform-state --location "UK South"

# Create storage account (replace <uniqueid> with a unique value, e.g., your initials + date)
az storage account create \
  --name sttfstate<uniqueid> \
  --resource-group rg-terraform-state \
  --location "UK South" \
  --sku Standard_LRS \
  --encryption-services blob

# Create blob container
az storage container create \
  --name tfstate \
  --account-name sttfstate<uniqueid>
```

### 2. Configure Azure DevOps

1. **Create Service Connection**:
   - Navigate to: Project Settings > Service connections > New service connection
   - Select: Azure Resource Manager
   - Authentication: Service principal (automatic)
   - Scope: Subscription
   - Name: `Azure-Service-Connection`

2. **Update Pipeline Variables**:
   - Edit `azure-pipelines.yml`
   - Update `backendStorageAccount` variable with your storage account name

3. **Create Pipeline**:
   - Pipelines > New Pipeline
   - Select your repository
   - Existing Azure Pipelines YAML file
   - Select `azure-pipelines.yml`

4. **Create Production Environment**:
   - Environments > New environment
   - Name: `Production`
   - Add approvers for deployment protection

### 3. Configure Local Development

```bash
# Clone repository
git clone https://github.com/cacoelhs/NHS_StThomas_V2.git
cd NHS_StThomas_V2/terraform

# Copy and configure backend
cp backend.hcl.example backend.hcl
# Edit backend.hcl and update storage account name

# Copy and configure variables
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values

# Initialize Terraform
terraform init -backend-config="backend.hcl"
```

## Common Commands

### Local Development
```bash
# Format code
terraform fmt -recursive

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes
terraform apply

# Destroy resources (use with caution!)
terraform destroy
```

### Pipeline Workflow
1. Create feature branch
2. Make changes to Terraform files
3. Push to repository
4. Pipeline automatically runs Validate and Plan stages
5. Merge to main branch
6. Approve deployment in Azure DevOps
7. Pipeline runs Apply stage

## Troubleshooting

### Common Issues

**Issue**: `Error acquiring state lock`
- **Solution**: Check if another operation is running. If stuck, unlock manually:
  ```bash
  terraform force-unlock <lock-id>
  ```

**Issue**: `Storage account name invalid`
- **Solution**: Ensure name is 3-24 characters, lowercase, alphanumeric only

**Issue**: `Authentication failed`
- **Solution**: Run `az login` and ensure correct subscription is selected

**Issue**: Pipeline fails at Init stage
- **Solution**: Verify service connection has contributor access to subscription

## Best Practices

1. **Always review plan output** before applying
2. **Use feature branches** for changes
3. **Test locally** before pushing
4. **Keep state file secure** in Azure Storage
5. **Use meaningful commit messages**
6. **Don't commit .tfvars files** (they're in .gitignore)
7. **Document infrastructure changes** in pull requests

## Support

For issues or questions:
1. Check this guide and README.md
2. Review Azure DevOps pipeline logs
3. Check Terraform state in Azure Storage
4. Contact project maintainers
