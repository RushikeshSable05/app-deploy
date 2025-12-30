terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "5436afe4-d2f6-433b-8b99-8e4d3be5144f"
}

variable "deployment" {
  type = any
}

module "foundation" {
  source     = "../../../terraform-azurerm-foundation"
  deployment = var.deployment
}

module "compute" {
  source     = "../../../terraform-azurerm-compute"
  deployment = var.deployment
  foundation = module.foundation
}
