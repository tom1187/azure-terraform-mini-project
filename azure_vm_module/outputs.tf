
output "virtual_machine_id" {
  description = "The ID of the virtual machine created by the module"
  value       = azurerm_virtual_machine.tf-test.id
}
