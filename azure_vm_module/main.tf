resource "azurerm_virtual_machine" "tf-test" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.network_interface_ids
  vm_size               = "Standard_B1s"
  delete_os_disk_on_termination = true
  tags                  = var.tags

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
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

resource "azurerm_log_analytics_workspace" "tf-test" {
  name                = "tf-test-log-analytics-workspace"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_virtual_machine_extension" "tf-test" {
  name                 = "MicrosoftMonitoringAgent"
  virtual_machine_id   = azurerm_virtual_machine.tf-test.id
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "MicrosoftMonitoringAgent"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    workspaceId = azurerm_log_analytics_workspace.tf-test.id
  })
}

resource "azurerm_virtual_machine_extension" "tf-test2" {
  name                 = "Microsoft.Insights.VMDiagnosticsSettings"
  virtual_machine_id   = azurerm_virtual_machine.tf-test.id
  publisher            = "Microsoft.Azure.Diagnostics"
  type                 = "IaaSDiagnostics"
  type_handler_version = "1.5"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    StorageAccount = var.storage_account_name
    WadCfg = {
      DiagnosticMonitorConfiguration = {
        DiagnosticInfrastructureLogs = {
          scheduledTransferLogLevelFilter = "Error"
        }
        Metrics = {
          MetricAggregation = [
            {
              scheduledTransferPeriod = "PT1H"
            },
            {
              scheduledTransferPeriod = "PT1M"
            }
          ]
          resourceId = azurerm_virtual_machine.tf-test.id
        }
        PerformanceCounters = {
          PerformanceCounterConfiguration = [
            {
              counterSpecifier = "\\Processor Information(_Total)\\% Processor Time"
              sampleRate       = "PT60S"
              unit             = "Percent"
            }
          ]
          scheduledTransferPeriod = "PT1M"
        }
        WindowsEventLog = {
          DataSource = [
            {
              name = "System!*[System[(Level = 1 or Level = 2 or Level = 3)]]"
            }
          ]
          scheduledTransferPeriod = "PT1M"
        }
        overallQuotaInMB = 5120
      }
    }
  })

  protected_settings = jsonencode({
    storageAccountName      = var.storage_account_name
    storageAccountKey       = var.storage_account_primary_access_key
    storageAccountEndPoint  = "https://core.windows.net/"
  })
}
