# ============================================
# Virtual Network Module
# ============================================

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# ============================================
# Virtual Networks
# ============================================

resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnet_config

  name                = each.key
  location            = each.value.region
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space

  tags = each.value.tags
}

# ============================================
# Subnets
# ============================================

resource "azurerm_subnet" "subnet" {
  for_each = {
    for idx, subnet in var.subnet_config :
    subnet.name => subnet
  }

  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  virtual_network_name            = lookup(azurerm_virtual_network.vnet, each.value.virtual_network_name, azurerm_virtual_network.vnet[keys(azurerm_virtual_network.vnet)[0]]).name
  address_prefixes                = each.value.address_prefixes
  default_outbound_access_enabled = each.value.default_outbound_access_enabled
  service_endpoints               = each.value.service_endpoints

  # Configure delegations if specified
  dynamic "delegation" {
    for_each = each.value.delegation

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }

  depends_on = [azurerm_virtual_network.vnet]
}
