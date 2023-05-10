output "resource_group" {
  value = [azurerm_resource_group.tf-test.name, azurerm_resource_group.tf-test.id]
}

output "virtual_network" {
  value = [azurerm_virtual_network.tf-test.name, azurerm_virtual_network.tf-test.id]
}

output "subnet" {
  value = [azurerm_subnet.tf-test.name, azurerm_subnet.tf-test.id]
}

output "network_security_group" {
  value = [azurerm_network_security_group.tf-test.name, azurerm_network_security_group.tf-test.id]
}

output "network_interface" {
  value = [azurerm_network_interface.tf-test.name, azurerm_network_interface.tf-test.id]
}

output "public_ip" {
  value = [azurerm_public_ip.tf-test.name, azurerm_public_ip.tf-test.id]
}

# output "virtual_machine" {
#   value = [azurerm_virtual_machine.tf-test.name, azurerm_virtual_machine.tf-test.id]
#   #sensitive = true
# }

output "storage_account" {
  value = [azurerm_storage_account.tf-test.name, azurerm_storage_account.tf-test.id]
  #sensitive = true
}
