variable "subscription_id" {
  description = "The subscription ID for your Azure account."
  type        = string
}

variable "client_id" {
  description = "The client ID for your Azure account."
  type        = string
}

variable "client_secret" {
  description = "The client secret for your Azure account."
  sensitive   = true
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for your Azure account."
  type        = string
}

variable "vm_admin_username" {
  description = "The VM Administrator username"
  type        = string
}

variable "vm_admin_password" {
  description = "The VM Administrator password"
  type        = string
}


# variable "backend_resource_group_name" {
#   description = "The Resource Group name in which the AzureRM backend will be stored in"
#   type        = string
# }


# variable "backend_storage_account_name" {
#   description = "The Storage Account name in which the AzureRM backend will be stored in"
#   type        = string
# }


# variable "backend_container_name" {
#   description = "The Container name in which the AzureRM backend will be stored in"
#   type        = string
# }
