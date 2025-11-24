# ============================================
# Terraform and Provider Configuration
# ============================================

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.4.0"
    }
  }
  backend "azurerm" {
  }
}

# ============================================
# Provider Aliases for Multi-Subscription Deployment
# ============================================

# SDE Connectivity Subscription Provider
provider "azurerm" {
  features {
  }
  alias                      = "connectivity-sub"
  subscription_id            = var.azure_subscription_ids["connectivity-sub"]
  skip_provider_registration = true
  use_oidc                   = true
  tenant_id                  = var.azure_tenant_id
  client_id                  = var.azure_client_id
}

# SDE Data Landing Zone Subscription Provider
provider "azurerm" {
  features {
  }
  alias                      = "data-lz-sub"
  subscription_id            = var.azure_subscription_ids["development-sub"]
  skip_provider_registration = true
  use_oidc                   = true
  tenant_id                  = var.azure_tenant_id
  client_id                  = var.azure_client_id
}

# SDE Management Subscription Provider
provider "azurerm" {
  features {
  }
  alias                      = "management-sub"
  subscription_id            = var.azure_subscription_ids["management-sub"]
  skip_provider_registration = true
  use_oidc                   = true
  tenant_id                  = var.azure_tenant_id
  client_id                  = var.azure_client_id
}
