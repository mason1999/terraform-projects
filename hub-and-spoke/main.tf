terraform {
  required_version = ">=1.7.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.97.1"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "test-rg"
  location = "Australia East"
}

resource "azurerm_public_ip" "example_hub" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.example.location
  name                = format("pip-%s", "hub")
  resource_group_name = azurerm_resource_group.example.name
}

module "linux_vm" {
  source                        = "./modules/linux-vm"
  task                          = "hub"
  resource_group_name           = azurerm_resource_group.example.name
  virtual_network_address_space = ["10.0.0.0/16"]
  subnet_address_space          = ["10.0.0.0/24"]
  private_ip_address            = "10.0.0.4"
  public_ip_address_id          = azurerm_public_ip.example_hub.id
  enable_ssh                    = true
}

output "hub_user" {
  value = format("%s@%s", module.linux_vm.username, azurerm_public_ip.example_hub.ip_address)
}
