terraform {
  backend "azurerm" {
    resource_group_name   = "Terrraform-Azure"
    storage_account_name  = "terraformazuregithub"
    container_name        = "tfstatefile"
    key                   = "dev.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "test-rg"
  location = var.location
  tags     = var.common_tags
}
