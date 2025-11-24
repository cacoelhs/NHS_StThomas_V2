# ============================================
# Connectivity Subscription Outputs
# ============================================

output "connectivity_vnet_id" {
  description = "ID of the Connectivity Hub VNet"
  value       = module.network_connectivity.vnet_ids
}

output "connectivity_subnet_ids" {
  description = "IDs of subnets in Connectivity subscription"
  value       = module.network_connectivity.subnet_ids
}

# ============================================
# Data Landing Zone Outputs
# ============================================

output "data_lz_vnet_id" {
  description = "ID of the Data Landing Zone VNet"
  value       = module.network_data_lz.vnet_ids
}

output "data_lz_subnet_ids" {
  description = "IDs of subnets in Data Landing Zone"
  value       = module.network_data_lz.subnet_ids
}

# ============================================
# Management Subscription Outputs
# ============================================

output "management_vnet_id" {
  description = "ID of the Management VNet"
  value       = module.network_management.vnet_ids
}

output "management_subnet_ids" {
  description = "IDs of subnets in Management subscription"
  value       = module.network_management.subnet_ids
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
