resource "azurerm_virtual_machine" "tf-test" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.network_interface_ids
  vm_size               = "Standard_B1s"
  #tags                  = local.azure_tags

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-tf-test"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent        = true
  }
}

resource "azurerm_virtual_machine_extension" "tf-test" {
  name                 = "tf-test-diagnostics"
  virtual_machine_id   = azurerm_virtual_machine.tf-test.id
  publisher            = "Microsoft.Azure.Diagnostics"
  type                 = "IaaSDiagnostics"
  type_handler_version = "1.5"

  settings = jsonencode({
    "WadCfg": {
      "DiagnosticMonitorConfiguration": {
        "overallQuotaInMB": 4096,
        "sinks": "application"
      }
    }
  })

  protected_settings = jsonencode({
    "storageAccountName": var.storage_account_name
    "storageAccountKey": var.storage_account_primary_access_key
    "storageAccountEndPoint": "https://core.windows.net/"
  })
}