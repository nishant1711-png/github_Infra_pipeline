terraform {
  required_providers {
    azurerm = {
      version = "4.81.0"
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}