# ============================================
# Resource Groups
# These must exist before VNets can be created
# ============================================

# Connectivity Subscription Resource Group
resource "azurerm_resource_group" "connectivity" {
  provider = azurerm.connectivity-sub
  name     = "gstt-sde-uks-prod-conn-rg01"
  location = "uksouth"

  tags = {
    purpose        = "sde-connectivity"
    resource-owner = "SDE Team"
    change-window  = "TBD"
    environment    = "production"
  }
}

# Data Landing Zone Resource Group
resource "azurerm_resource_group" "data_lz" {
  provider = azurerm.data-lz-sub
  name     = "gstt-sde-uks-data-rg01"
  location = "uksouth"

  tags = {
    purpose        = "sde-data-landing-zone"
    resource-owner = "SDE Team"
    change-window  = "TBD"
    environment    = "production"
  }
}

# Management Subscription Resource Group
resource "azurerm_resource_group" "management" {
  provider = azurerm.management-sub
  name     = "gstt-sde-uks-prod-mng-rg01"
  location = "uksouth"

  tags = {
    purpose        = "sde-management"
    resource-owner = "SDE Team"
    change-window  = "TBD"
    environment    = "production"
  }
}

# ============================================
# VNet Module Calls
# These modules create the Virtual Networks and Subnets in each subscription
# ============================================

# SDE Connectivity Subscription Hub Network
module "network_connectivity" {
  source        = "../modules/network/virtual_network"
  vnet_config   = local.vnet_by_provider["connectivity-sub"]
  subnet_config = local.subnet_config_by_provider["connectivity-sub"]

  providers = {
    azurerm = azurerm.connectivity-sub
  }

  depends_on = [azurerm_resource_group.connectivity]
}

# SDE Data Landing Zone Network
module "network_data_lz" {
  source        = "../modules/network/virtual_network"
  vnet_config   = local.vnet_by_provider["data-lz-sub"]
  subnet_config = local.subnet_config_by_provider["data-lz-sub"]

  providers = {
    azurerm = azurerm.data-lz-sub
  }

  depends_on = [azurerm_resource_group.data_lz]
}

# SDE Management Subscription Network
module "network_management" {
  source        = "../modules/network/virtual_network"
  vnet_config   = local.vnet_by_provider["management-sub"]
  subnet_config = local.subnet_config_by_provider["management-sub"]

  providers = {
    azurerm = azurerm.management-sub
  }

  depends_on = [azurerm_resource_group.management]
}
