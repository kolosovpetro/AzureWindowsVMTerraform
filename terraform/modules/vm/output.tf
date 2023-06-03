output "vm_public_ip" {
  value = azurerm_public_ip.public.ip_address
}

output "vm_id" {
  value = azurerm_virtual_machine.public.id
}