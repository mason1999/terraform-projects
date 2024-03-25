resource "azurerm_virtual_network" "this" {
  name                = format("vnet-%s", var.task)
  address_space       = var.virtual_network_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "this" {
  name                 = format("subnet-%s", var.task)
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = var.subnet_address_space
}

resource "azurerm_network_security_group" "this" {
  name                = format("nsg-%s", var.task)
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "rules" {
  source = "../network-security-rule"

  resource_group_name         = var.resource_group_name
  subnet_id                   = azurerm_subnet.this.id
  network_security_group_id   = azurerm_network_security_group.this.id
  network_security_group_name = azurerm_network_security_group.this.name
  enable_ssh                  = var.enable_ssh
}

resource "azurerm_network_interface" "this" {
  name                 = format("nic-%s", var.task)
  location             = var.location
  resource_group_name  = var.resource_group_name
  enable_ip_forwarding = var.enable_ip_forwarding

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.this.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = format("vm-%s", var.task)
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_DS1_v2"
  admin_username      = format("user_%s", var.task)
  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  disable_password_authentication = false
  admin_password                  = "WeakPassword123"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
