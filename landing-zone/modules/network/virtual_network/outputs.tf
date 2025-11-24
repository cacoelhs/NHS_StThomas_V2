# ============================================
# Virtual Network Outputs
# ============================================

output "vnet_ids" {
  description = "Map of Virtual Network IDs"
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

output "subnet_ids" {
  description = "Map of Subnet IDs"
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
