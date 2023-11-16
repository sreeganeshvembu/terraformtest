terraform {
  backend "azurerm" {
    resource_group_name   = "Terrraform-Azure"
    storage_account_name  = "terraformazuregithub"
    container_name        = "tfstatefile"
    key                   = "dev.terraform.tfstate"
  }
}
