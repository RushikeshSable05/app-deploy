terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0, < 5.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  # subscription_id = "756f5ce6-99f8-4fc1-83b3-b22a54669118"
  # tenant_id = "1177b4ed-160b-495d-84b4-0505d2343c75"
  # client_id = "d7e3720f-35e0-4df0-8292-12daab7e18d1"
  features {}
  subscription_id = "5436afe4-d2f6-433b-8b99-8e4d3be5144f"
}


variable "deployment" {
  type = any
}

module "compute" {
  source     = "../../../terraform-azurerm-compute"
  deployment = var.deployment
}
