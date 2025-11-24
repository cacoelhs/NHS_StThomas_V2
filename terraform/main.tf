# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name != "" ? var.resource_group_name : "rg-${var.project_name}-${var.environment}"
  location = var.location
  tags     = local.all_tags
}

# Storage Account for application data
resource "azurerm_storage_account" "main" {
  name                     = lower(substr(replace("st${var.project_name}${var.environment}", "-", ""), 0, 24))
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.all_tags
}

# Storage Container
resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}
