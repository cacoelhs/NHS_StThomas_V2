# NHS St Thomas SDE Network Deployment Guide

This guide provides step-by-step instructions for deploying the SDE network infrastructure using Azure DevOps.

## Prerequisites Checklist

- [ ] Access to all three Azure subscriptions
- [ ] Azure DevOps project created
- [ ] Terraform state storage account created
- [ ] Service Principal or Managed Identity configured
- [ ] Appropriate RBAC permissions assigned

## Azure DevOps Setup

### Step 1: Create Service Connections

1. Navigate to Project Settings > Service connections
2. Create three Azure Resource Manager service connections:
   - **Name**: `SDE-Connectivity-ServiceConnection`
     - **Scope**: Subscription
     - **Subscription**: SDE Connectivity Subscription
   - **Name**: `SDE-DataLZ-ServiceConnection`
     - **Scope**: Subscription
     - **Subscription**: SDE Data Landing Zone
   - **Name**: `SDE-Management-ServiceConnection`
     - **Scope**: Subscription
     - **Subscription**: SDE Management

### Step 2: Create Variable Groups

#### Variable Group: terraform-state-vars
- `TF_STATE_RG`: Resource group name for Terraform state
- `TF_STATE_STORAGE`: Storage account name for Terraform state
- `TF_STATE_CONTAINER`: Container name (default: `tfstate`)
- `TF_STATE_KEY`: State file name (default: `sde-network.terraform.tfstate`)

#### Variable Group: sde-subscription-ids
- `CONNECTIVITY_SUB_ID`: Connectivity subscription ID (mark as secret)
- `DATA_LZ_SUB_ID`: Data LZ subscription ID (mark as secret)
- `MANAGEMENT_SUB_ID`: Management subscription ID (mark as secret)

### Step 3: Create Production Environment

1. Navigate to Pipelines > Environments
2. Create new environment: **Production**
3. Add approvals and checks:
   - Required approvers: Network team, Security team
   - Timeout: 30 days

### Step 4: Create Pipeline

1. Navigate to Pipelines > Create Pipeline
2. Select Azure Repos Git
3. Choose the repository
4. Select existing Azure Pipelines YAML file
5. Path: `/azure-pipelines.yml`

## Local Testing

Before running the pipeline, test locally:

```powershell
# Navigate to environment
cd environments/prod

# Login to Azure
az login

# Set subscriptions
az account set --subscription "connectivity-sub-id"

# Initialize
terraform init

# Validate
terraform validate

# Plan
terraform plan -var-file="vnets.tfvars" -var-file="subnets.tfvars"
```

## Deployment Workflow

### First-Time Deployment

1. **Commit Code**: Push Terraform code to `main` branch
2. **Validate Stage**: Pipeline runs automatically
3. **Plan Stage**: Review the plan output
4. **Apply Stage**: Approve in Azure DevOps Environment
5. **Verify**: Check Azure Portal for created resources

### Updates

1. **Create Feature Branch**: `git checkout -b feature/add-subnet`
2. **Make Changes**: Update tfvars files
3. **Test Locally**: Run `terraform plan`
4. **Create PR**: Submit for review
5. **Merge to Main**: Triggers pipeline
6. **Approve Deployment**: Review and approve in Environment

## Troubleshooting

### Pipeline Fails at Init

**Cause**: Backend storage not accessible

**Solution**:
```powershell
# Verify storage account exists
az storage account show --name <storage-account-name>

# Check container
az storage container show --name tfstate --account-name <storage-account-name>
```

### Authentication Errors

**Cause**: Service connection permissions

**Solution**: Verify service principal has:
- Contributor role on subscription
- Storage Blob Data Contributor on state storage

### Plan Shows Unexpected Changes

**Cause**: Manual changes in Azure Portal

**Solution**:
```powershell
# Import existing resources
terraform import azurerm_virtual_network.example /subscriptions/.../resourceGroups/.../providers/Microsoft.Network/virtualNetworks/...
```

## Post-Deployment Tasks

After successful deployment:

1. **Document Outputs**: Save VNet and subnet IDs
2. **Configure NSGs**: Apply network security groups
3. **Setup Firewall Rules**: Configure Azure Firewall
4. **VNet Peering**: Establish hub-spoke connectivity
5. **Test Connectivity**: Verify network connectivity

## Rollback Procedure

If deployment fails:

1. **Review Error Logs**: Check pipeline output
2. **Fix Code**: Update Terraform files
3. **Rerun Pipeline**: Commit and push
4. **Manual Rollback** (if needed):
   ```powershell
   terraform state list
   terraform destroy -target=<resource>
   ```

## Security Best Practices

- Store all secrets in Azure Key Vault
- Use managed identities for service connections
- Enable state file encryption
- Implement branch protection policies
- Require PR approvals for main branch
- Regular security scanning of Terraform code

## Monitoring

Monitor deployments:
- Azure DevOps pipeline history
- Terraform state file changes
- Azure Activity Log
- Resource health checks

## Support Contacts

- **Terraform Issues**: Platform Team
- **Network Issues**: Network Team
- **Security Review**: Security Team
- **Azure DevOps**: DevOps Team
