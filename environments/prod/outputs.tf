# ============================================
# Virtual Network Outputs
# ============================================

output "o_vnet" {
  value = {
    connectivity = module.network_connectivity.vnet_ids
    data_lz      = module.network_data_lz.vnet_ids
    management   = module.network_management.vnet_ids
  }
  description = <<EOD
The "o_vnet" output represents a set of virtual networks. It combines information from different modules, including network_connectivity, network_data_lz, and network_management, to provide a comprehensive overview of the vnets and their properties.
EOD
}

# ============================================
# Subnet Outputs
# ============================================

output "o_snet" {
  value = {
    connectivity = module.network_connectivity.subnet_ids
    data_lz      = module.network_data_lz.subnet_ids
    management   = module.network_management.subnet_ids
  }
  description = <<EOD
The "o_snet" output represents a set of subnets. It combines information from different modules, including network_connectivity, network_data_lz, and network_management, to provide a comprehensive overview of the subnets and their properties.
EOD
}

# ============================================
# Resource Group Outputs
# ============================================

output "resource_group_ids" {
  description = "Resource Group IDs across all subscriptions"
  value = {
    connectivity = azurerm_resource_group.connectivity.id
    data_lz      = azurerm_resource_group.data_lz.id
    management   = azurerm_resource_group.management.id
  }
}

# ============================================
# Individual VNet Outputs (for backward compatibility)
# ============================================

output "connectivity_vnet_id" {
  description = "ID of the Connectivity Hub VNet"
  value       = module.network_connectivity.vnet_ids
}

output "data_lz_vnet_id" {
  description = "ID of the Data Landing Zone VNet"
  value       = module.network_data_lz.vnet_ids
}

output "management_vnet_id" {
  description = "ID of the Management VNet"
  value       = module.network_management.vnet_ids
}

output "connectivity_subnet_ids" {
  description = "IDs of subnets in Connectivity subscription"
  value       = module.network_connectivity.subnet_ids
}

output "data_lz_subnet_ids" {
  description = "IDs of subnets in Data Landing Zone"
  value       = module.network_data_lz.subnet_ids
}

output "management_subnet_ids" {
  description = "IDs of subnets in Management subscription"
  value       = module.network_management.subnet_ids
}
