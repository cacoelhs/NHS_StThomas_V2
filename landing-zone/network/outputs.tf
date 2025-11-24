# ============================================
# Virtual Network Outputs
# ============================================

output "o_vnet" {
  value = {
    connectivity = try(module.network_connectivity.o_virtual_networks, {})
    data_lz      = try(module.network_data_lz.o_virtual_networks, {})
    management   = try(module.network_management.o_virtual_networks, {})
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
    connectivity = try(module.network_connectivity.o_subnets, {})
    data_lz      = try(module.network_data_lz.o_subnets, {})
    management   = try(module.network_management.o_subnets, {})
  }
  description = <<EOD
The "o_snet" output represents a set of subnets. It combines information from different modules, including network_connectivity, network_data_lz, and network_management, to provide a comprehensive overview of the subnets and their properties.
EOD
}
