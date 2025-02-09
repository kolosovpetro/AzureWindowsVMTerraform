variable "location" {
  type        = string
  description = "Resource group location"
  default     = "northeurope"
}

variable "prefix" {
  type        = string
  description = "Prefix for all resources"
  default     = "d01"
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
  default     = "1b08b9a2-ac6d-4b86-8a2f-8fef552c8371"
}

variable "os_profile_admin_password" {
  type        = string
  description = "Windows OS admin user password"
  default     = "2HiVkwYAx0VKJoAC"
}

variable "tags" {
  type        = map(string)
  description = "Tags for all resources"
  default = {
    Environment  = "DEV"
    Owner        = "Terraform"
    Autoshutdown = "OFF"
  }
}
