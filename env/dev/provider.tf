terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.78.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "dev_rg"
    storage_account_name = "statestorage88888"
    container_name       = "container"
    key                  = "dev_terraform.tfstate"
  }
}
provider "azurerm" {
  features {}
  subscription_id = "9246877f-9bea-4e72-9d6d-6b6d49d180df"
}