# ============================================
# Virtual Network Outputs
# ============================================

output "o_vnet" {
  value = {
    connectivity = try(module.network_connectivity.vnet_ids, {})
    data_lz      = try(module.network_data_lz.vnet_ids, {})
    management   = try(module.network_management.vnet_ids, {})
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
    connectivity = try(module.network_connectivity.subnet_ids, {})
    data_lz      = try(module.network_data_lz.subnet_ids, {})
    management   = try(module.network_management.subnet_ids, {})
  }
  description = <<EOD
The "o_snet" output represents a set of subnets. It combines information from different modules, including network_connectivity, network_data_lz, and network_management, to provide a comprehensive overview of the subnets and their properties.
EOD
}
