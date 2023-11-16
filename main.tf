provider "azurerm" {
  features {}
}

# Resource Group for VNet 1
resource "azurerm_resource_group" "rg1" {
  name     = "vnet1-${var.project_name}-${var.environment}-${var.location}"
  location = var.location
  tags     = var.common_tags
}

# Resource Group for VNet 2
resource "azurerm_resource_group" "rg2" {
  name     = "vnet2-${var.project_name}-${var.environment}-${var.location}"
  location = var.location
  tags     = var.common_tags
}

# Virtual Network 1
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1-${var.project_name}-${var.environment}-${var.location}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  tags                = var.common_tags
}

# Virtual Network 2
resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2-${var.project_name}-${var.environment}-${var.location}"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.rg2.location
  resource_group_name = azurerm_resource_group.rg2.name
  tags                = var.common_tags
}

# VNet Peering from VNet1 to VNet2
resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
  name                      = "peer-vnet1-to-vnet2"
  resource_group_name       = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
}

# VNet Peering from VNet2 to VNet1
resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
  name                      = "peer-vnet2-to-vnet1"
  resource_group_name       = azurerm_virtual_network.vnet2.resource_group_name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.vnet1.id
}
