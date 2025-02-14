#################################################################################################################
# REQUIRED VARIABLES
#################################################################################################################

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the resources."
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

variable "custom_image_sku" {
  type        = string
  description = "The resource SKU of the custom image to use for the VM."
}

variable "custom_image_resource_group" {
  type        = string
  description = "The resource group name of the custom image to use for the VM."
}

#################################################################################################################
# OPTIONAL VARIABLES
#################################################################################################################

variable "location" {
  type        = string
  description = "The Azure region where the resource group is located."
  default     = "northeurope"
}

variable "vm_size" {
  type        = string
  description = "The Azure VM SKU size (e.g., Standard_B2ms, Standard_DS1_v2)."
  default     = "Standard_B4ms"
}

variable "managed_disk_type" {
  type        = string
  description = "The type of managed disk to use for the OS disk (e.g., Premium_LRS, Standard_LRS)."
  default     = "Premium_LRS"
}

variable "tags" {
  type        = map(string)
  description = "VM tags."
  default     = {}
}
