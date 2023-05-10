terraform {
  backend "azurerm" {
    resource_group_name  = "tf-backend-resources"
    storage_account_name = "tftestbackend"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}