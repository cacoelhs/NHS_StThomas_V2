# ============================================
# Locals for Organizing VNets and Subnets by Provider
# ============================================

locals {
  # Build subscription IDs map from individual variables if needed
  # This allows the pipeline to pass individual subscription IDs
  subscription_ids = var.azure_subscription_ids

  # Filter VNets by provider alias and is_applicable flag
  vnet_by_provider = {
    for provider in ["connectivity-sub", "data-lz-sub", "management-sub"] :
    provider => {
      for vnet_key, vnet in var.virtual_networks :
      vnet_key => vnet
      if vnet.provider_alias == provider && vnet.is_applicable
    }
  }

  # Filter subnets by provider alias and is_applicable flag
  subnet_config_by_provider = {
    for provider in ["connectivity-sub", "data-lz-sub", "management-sub"] :
    provider => [
      for subnet in var.subnet_config :
      subnet
      if subnet.provider_alias == provider && subnet.is_applicable
    ]
  }
}
