# ============================================
# Subscription IDs
# IMPORTANT: Update these with your actual subscription IDs
# OR set via environment variables or Azure DevOps pipeline variables
# ============================================

connectivity_subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"  # Replace with SDE Connectivity Subscription ID
data_lz_subscription_id      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"  # Replace with SDE Data Landing Zone Subscription ID
management_subscription_id   = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"  # Replace with SDE Management Subscription ID

# ============================================
# Virtual Networks Configuration
# ============================================

virtual_networks = {
  # SDE Connectivity Subscription Hub VNet (172.31.16.0/22)
  "gstt-sde-uks-prod-conn-vnet01" = {
    provider_alias      = "connectivity-sub"
    is_applicable       = true
    region              = "uksouth"
    resource_group_name = "gstt-sde-uks-prod-conn-rg01"
    address_space = [
      "172.31.16.0/22"
    ]
    tags = {
      purpose        = "sde-connectivity-hub"
      name           = "gstt-sde-uks-prod-conn-vnet01"
      resource-owner = "SDE Team"
      change-window  = "TBD"
      role           = "Hub Virtual Network"
      environment    = "production"
    }
  }

  # SDE Data Landing Zone VNet (172.31.20.0/25)
  "gst-uks-sde-data-vnet01" = {
    provider_alias      = "data-lz-sub"
    is_applicable       = true
    region              = "uksouth"
    resource_group_name = "gstt-sde-uks-data-rg01"
    address_space = [
      "172.31.20.0/25"
    ]
    tags = {
      purpose        = "sde-data-landing-zone"
      name           = "gstt-sde-uks-data-vnet01"
      resource-owner = "SDE Team"
      change-window  = "TBD"
      role           = "Data Landing Zone Virtual Network"
      environment    = "production"
    }
  }

  # SDE Management Subscription VNet (172.31.20.128/25)
  "gst-uks-sde-mng-vnet01" = {
    provider_alias      = "management-sub"
    is_applicable       = true
    region              = "uksouth"
    resource_group_name = "gstt-sde-uks-prod-mng-rg01"
    address_space = [
      "172.31.20.128/25"
    ]
    tags = {
      purpose        = "sde-management"
      name           = "gstt-sde-uks-mng-vnet01"
      resource-owner = "SDE Team"
      change-window  = "TBD"
      role           = "Management Virtual Network"
      environment    = "production"
    }
  }
}
