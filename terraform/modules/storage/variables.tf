variable "storage_resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "storage_location" {
  type        = string
  description = "Location of the resource group"
}

variable "storage_account_name" {
  type        = string
  description = "Storage account name"
}

variable "storage_container_name" {
  type        = string
  description = "Storage container name"
}

variable "storage_account_tier" {
  type        = string
  #  default     = "Standard"
  description = "Storage account tier"
}

variable "storage_account_replication" {
  type        = string
  #  default = "LRS"
  description = "Storage account replication strategy"
}

variable "custom_script_extension_absolute_path" {
  type        = string
  description = "The absolute path of the custom script extension."
}

variable "custom_script_extension_file_name" {
  type        = string
  description = "The file name of the custom script extension."
}