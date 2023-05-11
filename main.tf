resource "azurerm_resource_group" "tf-test" {
  name     = "tf-test-resources"
  location = "East US"
  tags     = local.azure_tags
}

resource "azurerm_virtual_network" "tf-test" {
  name                = "tf-test-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.tf-test.location
  resource_group_name = azurerm_resource_group.tf-test.name
}

resource "azurerm_subnet" "tf-test" {
  name                 = "tf-test-subnet"
  resource_group_name  = azurerm_resource_group.tf-test.name
  virtual_network_name = azurerm_virtual_network.tf-test.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "tf-test" {
  name                = "tf-test-nsg"
  location            = azurerm_resource_group.tf-test.location
  resource_group_name = azurerm_resource_group.tf-test.name
}

resource "azurerm_network_interface" "tf-test" {
  name                = "tf-test-nic"
  location            = azurerm_resource_group.tf-test.location
  resource_group_name = azurerm_resource_group.tf-test.name

  ip_configuration {
    name                          = "tf-test-ipconfig"
    subnet_id                     = azurerm_subnet.tf-test.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tf-test.id
  }
}

resource "azurerm_public_ip" "tf-test" {
  name                = "tf-test-publicip"
  location            = azurerm_resource_group.tf-test.location
  resource_group_name = azurerm_resource_group.tf-test.name
  allocation_method   = "Dynamic"
}

module "vm_module" {
  source                             = "./azure_vm_module"
  vm_name                            = "tf-test-vm"
  resource_group_name                = azurerm_resource_group.tf-test.name
  location                           = azurerm_resource_group.tf-test.location
  network_interface_ids              = [azurerm_network_interface.tf-test.id]
  tags                               = local.azure_tags
  storage_account_name               = azurerm_storage_account.tf-test.name
  storage_account_primary_access_key = azurerm_storage_account.tf-test.primary_access_key
  admin_username                     = var.vm_admin_username
  admin_password                     = var.vm_admin_password
}

resource "azurerm_storage_account" "tf-test" {
  name                     = "tfteststorageacc"
  resource_group_name      = azurerm_resource_group.tf-test.name
  location                 = azurerm_resource_group.tf-test.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.azure_tags
}