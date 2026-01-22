terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.50.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-practice"
    storage_account_name = "remotebackendpractice"
    container_name       = "devtfstate"
    key                  = "terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
  subscription_id = "d35bdc6e-160c-43c0-8640-db1dcc21d896"
}