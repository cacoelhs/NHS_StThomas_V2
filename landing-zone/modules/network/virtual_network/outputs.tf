# ============================================
# Virtual Network Outputs
# ============================================

output "o_virtual_networks" {
  description = "Map of Virtual Network IDs and details"
  value = {
    for key, vnet in azurerm_virtual_network.vnet :
    key => {
      id              = vnet.id
      name            = vnet.name
      address_space   = vnet.address_space
      location        = vnet.location
      resource_group  = vnet.resource_group_name
    }
  }
}

output "vnet_ids" {
  description = "Map of Virtual Network IDs (for backward compatibility)"
  value = {
    for key, vnet in azurerm_virtual_network.vnet :
    key => vnet.id
  }
}

output "vnet_names" {
  description = "Map of Virtual Network names"
  value = {
    for key, vnet in azurerm_virtual_network.vnet :
    key => vnet.name
  }
}

# ============================================
# Subnet Outputs
# ============================================

output "o_subnets" {
  description = "Map of Subnet IDs and details"
  value = {
    for key, subnet in azurerm_subnet.subnet :
    key => {
      id               = subnet.id
      name             = subnet.name
      address_prefixes = subnet.address_prefixes
      resource_group   = subnet.resource_group_name
      vnet_name        = subnet.virtual_network_name
    }
  }
}

output "subnet_ids" {
  description = "Map of Subnet IDs (for backward compatibility)"
  value = {
    for key, subnet in azurerm_subnet.subnet :
    key => subnet.id
  }
}

output "subnet_names" {
  description = "Map of Subnet names"
  value = {
    for key, subnet in azurerm_subnet.subnet :
    key => subnet.name
  }
}

output "subnet_address_prefixes" {
  description = "Map of Subnet address prefixes"
  value = {
    for key, subnet in azurerm_subnet.subnet :
    key => subnet.address_prefixes
  }
}
