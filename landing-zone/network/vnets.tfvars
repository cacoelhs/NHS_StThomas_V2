# ============================================
# Azure Authentication and Subscription IDs
# These values are set via TF_VAR environment variables in the pipeline
# from the PipelineVars-DEV variable group
# ============================================

# NOTE: These are passed as environment variables:
# TF_VAR_azure_tenant_id
# TF_VAR_azure_client_id
# TF_VAR_azure_subscription_ids (as JSON string or separate variables)

# Subscription IDs map - you can either set this directly or via environment
# If using separate env vars, create the map in locals.tf
azure_subscription_ids = {
  "connectivity-sub" = "TBD"  # Set via TF_VAR_connectivity_subscription_id
  "development-sub"  = "TBD"  # Set via TF_VAR_data_lz_subscription_id  
  "management-sub"   = "TBD"  # Set via TF_VAR_management_subscription_id
}

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
