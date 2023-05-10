variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "location" {
  description = "The Azure location where the virtual machine should be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the virtual machine is located"
  type        = string
}

variable "network_interface_ids" {
  description = "A list of Network Interface IDs which should be associated with the Virtual Machine"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the virtual machine"
  type        = map(string)
  default     = {}
}

variable "admin_username" {
  description = "The username of the admin account on the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "The password of the admin account on the virtual machine"
  type        = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_account_primary_access_key" {
  type = string
}
