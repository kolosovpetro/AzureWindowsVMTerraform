output "username" {
  value = var.os_profile_admin_username
}

output "password" {
  value     = var.os_profile_admin_password
  sensitive = true
}

output "id" {
  value = azurerm_virtual_machine.public.id
}

output "principal_id" {
  value = azurerm_virtual_machine.public.identity[0].principal_id
}

output "network_interface_id" {
  value = azurerm_network_interface.public.id
}

output "ip_configuration_name" {
  value = var.ip_configuration_name
}
