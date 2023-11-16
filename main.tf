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

# Virtual Machine in VNet 1
resource "azurerm_virtual_machine" "vm1" {
  name                  = "vm-${var.project_name}-${var.environment}-${var.location}"
  location              = azurerm_resource_group.rg1.location
  resource_group_name   = azurerm_resource_group.rg1.name
  network_interface_ids = [azurerm_network_interface.vm1_nic.id]
  vm_size               = "Standard_F4s"

  # Uncomment and modify the below block to specify the OS disk and image used for the VM
   
storage_os_disk {
     name              = "osdisk"
     caching           = "ReadWrite"
     create_option     = "FromImage"
     managed_disk_type = "Standard_LRS"
     disk_size_gb      = 30
   }

   storage_image_reference {
     publisher = "Canonical"
     offer     = "UbuntuServer"
     sku       = "16.04-LTS"
     version   = "latest"
   }

  os_profile {
    computer_name  = "vmhostname"
    admin_username = "adminuser"
    # admin_password = "your-password" # It's recommended to use a secret manager for the password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# Network Interface for the VM
resource "azurerm_network_interface" "vm1_nic" {
  name                = "vm1-nic-${var.project_name}-${var.environment}-${var.location}"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vnet1_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Subnet for VM in VNet 1
resource "azurerm_subnet" "vnet1_subnet" {
  name                 = "vnet1-subnet"
  resource_group_name  = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes       = ["10.0.1.0/24"]
}
