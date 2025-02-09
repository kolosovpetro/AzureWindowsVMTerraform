variable "public_ip_name" {
  type        = string
  description = "The name of the public IP resource."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the resources."
}

variable "resource_group_location" {
  type        = string
  description = "The Azure region where the resource group is located."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet where the network interface will be deployed."
}

variable "network_interface_name" {
  type        = string
  description = "The name of the network interface associated with the virtual machine."
}

variable "ip_configuration_name" {
  type        = string
  description = "The name of the IP configuration within the network interface."
}

variable "vm_name" {
  type        = string
  description = "The name assigned to the virtual machine."
}

variable "vm_size" {
  type        = string
  description = "The Azure VM SKU size (e.g., Standard_B2ms, Standard_DS1_v2)."
  default     = "Standard_B2ms"
}

variable "storage_image_reference_sku" {
  type        = string
  description = "Specifies the SKU of the platform or marketplace image used for the virtual machine."
  default     = "2022-Datacenter"
}

variable "storage_os_disk_name" {
  type        = string
  description = "The name of the OS disk associated with the virtual machine."
}

variable "os_profile_computer_name" {
  type        = string
  description = "The hostname assigned to the virtual machine."
}

variable "os_profile_admin_username" {
  type        = string
  description = "The administrator username for the virtual machine."
}

variable "os_profile_admin_password" {
  type        = string
  description = "The administrator password for the virtual machine."
  sensitive   = true
}

variable "network_security_group_id" {
  type        = string
  description = "The ID of the Network Security Group (NSG) to associate with the network interface."
}

variable "use_custom_image" {
  type        = bool
  description = "A boolean flag to indicate whether a custom image should be used."
  default     = false
}

variable "custom_image_id" {
  type        = string
  description = "The resource ID of the custom image to use for the VM. Required when use_custom_image is true."
  default     = ""
}

variable "managed_disk_type" {
  type        = string
  description = "The type of managed disk to use for the OS disk (e.g., PremiumV2_LRS, Premium_LRS, Standard_LRS)."
  default     = "PremiumV2_LRS"
}
