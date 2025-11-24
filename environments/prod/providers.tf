# ============================================
# Terraform and Provider Configuration
# ============================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # Backend configuration for state management
  # Update with your Azure DevOps state storage details
  backend "azurerm" {
    resource_group_name  = "gstt-sde-terraform-state-rg"
    storage_account_name = "gsttsdeterraformstate"
    container_name       = "tfstate"
    key                  = "sde-network.terraform.tfstate"
  }
}

# ============================================
# Provider Aliases for Multi-Subscription Deployment
# ============================================

# SDE Connectivity Subscription Provider
provider "azurerm" {
  alias           = "connectivity-sub"
  subscription_id = var.connectivity_subscription_id
  
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

# SDE Data Landing Zone Subscription Provider
provider "azurerm" {
  alias           = "data-lz-sub"
  subscription_id = var.data_lz_subscription_id
  
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

# SDE Management Subscription Provider
provider "azurerm" {
  alias           = "management-sub"
  subscription_id = var.management_subscription_id
  
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}
