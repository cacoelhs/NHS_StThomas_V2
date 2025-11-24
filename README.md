# NHS St Thomas SDE Network Infrastructure - Terraform

This repository contains the Terraform Infrastructure as Code (IaC) for deploying the NHS St Thomas Secure Data Environment (SDE) network infrastructure across multiple Azure subscriptions.

## 📋 Overview

The infrastructure is deployed across three Azure subscriptions:
- **SDE Connectivity Subscription**: Hub network with Azure Firewall, VPN Gateway, and DNS resolvers
- **SDE Data Landing Zone**: Data platform networks with Snowflake and Azure Data Factory integration
- **SDE Management Subscription**: Management services including Bastion, Jump Servers, and Container Instances

## 🏗️ Architecture

### Network Design
- **Hub VNet**: `172.31.16.0/22` (SDE Connectivity)
- **Data Landing Zone VNet**: `172.31.20.0/25` (SDE Data LZ)
- **Management VNet**: `172.31.20.128/25` (SDE Management)

### Key Components
- Azure Firewall for centralized network security
- VPN Gateway for secure connectivity
- DNS Private Resolver for hybrid DNS resolution
- Azure Bastion for secure VM access
- Dedicated subnets for Snowflake, Azure Data Factory, and Container Instances

## 📁 Project Structure

```
NHS_StThomas_V2/
├── environments/
│   └── prod/
│       ├── main.tf              # Main resource definitions
│       ├── providers.tf         # Azure provider configurations
│       ├── variables.tf         # Variable declarations
│       ├── locals.tf            # Local value transformations
│       ├── outputs.tf           # Output definitions
│       ├── vnets.tfvars        # Virtual network configurations
│       └── subnets.tfvars      # Subnet configurations
├── modules/
│   └── network/
│       └── virtual_network/
│           ├── main.tf          # VNet and subnet resources
│           ├── variables.tf     # Module variables
│           └── outputs.tf       # Module outputs
├── azure-pipelines.yml          # Azure DevOps CI/CD pipeline
├── .gitignore
└── README.md
```

## 🚀 Getting Started

### Prerequisites

1. **Terraform**: Version 1.5.0 or higher
   ```powershell
   winget install Hashicorp.Terraform
   ```

2. **Azure CLI**: For authentication
   ```powershell
   winget install Microsoft.AzureCLI
   ```

3. **Azure Subscriptions**: Access to three Azure subscriptions with appropriate permissions

4. **Azure DevOps**: Project with service connections configured

### Configuration

1. **Update Subscription IDs**: Edit `environments/prod/vnets.tfvars` and replace placeholder subscription IDs:
   ```hcl
   connectivity_subscription_id = "your-connectivity-sub-id"
   data_lz_subscription_id      = "your-data-lz-sub-id"
   management_subscription_id   = "your-management-sub-id"
   ```

2. **Configure Backend State**: Update `environments/prod/providers.tf` with your state storage details:
   ```hcl
   backend "azurerm" {
     resource_group_name  = "your-terraform-state-rg"
     storage_account_name = "yourterraformstate"
     container_name       = "tfstate"
     key                  = "sde-network.terraform.tfstate"
   }
   ```

### Local Deployment

1. **Initialize Terraform**:
   ```powershell
   cd environments/prod
   terraform init
   ```

2. **Validate Configuration**:
   ```powershell
   terraform validate
   ```

3. **Plan Deployment**:
   ```powershell
   terraform plan `
     -var-file="vnets.tfvars" `
     -var-file="subnets.tfvars" `
     -out=tfplan
   ```

4. **Apply Changes**:
   ```powershell
   terraform apply tfplan
   ```

## 🔄 Azure DevOps Pipeline

The project includes a complete CI/CD pipeline (`azure-pipelines.yml`) with three stages:

### 1. Validate Stage
- Installs Terraform
- Initializes backend
- Validates configuration
- Checks code formatting

### 2. Plan Stage
- Generates execution plan
- Publishes plan as artifact for review

### 3. Apply Stage
- Requires approval via Azure DevOps Environment
- Applies infrastructure changes
- Publishes outputs

### Pipeline Setup

1. **Create Service Connections** in Azure DevOps for each subscription:
   - `SDE-Connectivity-ServiceConnection`
   - `SDE-DataLZ-ServiceConnection`
   - `SDE-Management-ServiceConnection`

2. **Create Variable Groups**:
   - `terraform-state-vars`: Backend configuration
     - `TF_STATE_RG`
     - `TF_STATE_STORAGE`
     - `TF_STATE_CONTAINER`
     - `TF_STATE_KEY`
   - `sde-subscription-ids`: Subscription IDs (mark as secret)
     - `CONNECTIVITY_SUB_ID`
     - `DATA_LZ_SUB_ID`
     - `MANAGEMENT_SUB_ID`

3. **Create Environment**: 
   - Name: `Production`
   - Add approval gates for Apply stage

4. **Run Pipeline**: Commit changes to `main` branch to trigger

## 🔐 Security Considerations

- All subscription IDs are managed as pipeline variables/secrets
- Terraform state is stored in Azure Storage with encryption
- Service connections use managed identities where possible
- Network Security Groups should be applied post-deployment
- Azure Firewall rules need to be configured separately

## 📊 Outputs

After successful deployment, Terraform outputs include:
- VNet IDs for all three subscriptions
- Subnet IDs for all created subnets
- Resource Group IDs

View outputs:
```powershell
terraform output
```

## 🛠️ Troubleshooting

### Common Issues

1. **Backend initialization fails**: Verify storage account exists and you have access
2. **Provider authentication errors**: Check service connection or Azure CLI login
3. **Subnet conflicts**: Ensure address spaces don't overlap with existing networks
4. **Module not found**: Run `terraform init` to download modules

### Terraform Commands

```powershell
# Format code
terraform fmt -recursive

# Show current state
terraform show

# List resources
terraform state list

# Destroy infrastructure (use with caution)
terraform destroy -var-file="vnets.tfvars" -var-file="subnets.tfvars"
```

## 📝 Maintenance

### Adding New Subnets

1. Edit `environments/prod/subnets.tfvars`
2. Add new subnet configuration
3. Run plan and apply

### Modifying VNets

1. Edit `environments/prod/vnets.tfvars`
2. Be cautious with address space changes (may require recreation)
3. Review plan carefully before applying

## 📄 License

Internal NHS St Thomas project. Not for public distribution.

## 👥 Support

For issues or questions:
- SDE Team: sde-team@gstt.nhs.uk
- Azure Platform Team: azure-platform@gstt.nhs.uk

---

**Last Updated**: November 2025  
**Terraform Version**: 1.5.0  
**AzureRM Provider**: ~> 3.0
