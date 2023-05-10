variable "subscription_id" {
  description = "The subscription ID for your Azure account."
}

variable "client_id" {
  description = "The client ID for your Azure account."
}

variable "client_secret" {
  description = "The client secret for your Azure account."
  sensitive   = true
}

variable "tenant_id" {
  description = "The tenant ID for your Azure account."
}

variable "vm_admin_username" {
    description = "The VM Administrator username"
}

variable "vm_admin_password" {
    description = "The VM Administrator password"
}