output "username" {
  description = "The name of the user who was created."
  value       = azurerm_linux_virtual_machine.this.admin_username
}
