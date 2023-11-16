output "resource_group_vnet1_name" {
  value       = azurerm_resource_group.rg1.name
  description = "Name of the resource group for VNet 1"
}

output "resource_group_vnet2_name" {
  value       = azurerm_resource_group.rg2.name
  description = "Name of the resource group for VNet 2"
}

output "virtual_network_vnet1_id" {
  value       = azurerm_virtual_network.vnet1.id
  description = "ID of Virtual Network 1"
}

output "virtual_network_vnet2_id" {
  value       = azurerm_virtual_network.vnet2.id
  description = "ID of Virtual Network 2"
}
