data "azurerm_client_config" "current" {}

module "network" {
  source                  = "./modules/network"
  resource_group_location = azurerm_resource_group.public.location
  resource_group_name     = azurerm_resource_group.public.name
  subnet_name             = "vm-win-subnet-${var.prefix}"
  vnet_name               = "vm-win-vnet-${var.prefix}"

  depends_on = [
    azurerm_resource_group.public
  ]
}

module "virtual_machine" {
  source                      = "./modules/vm"
  ip_configuration_name       = "vm-win-ip-config-${var.prefix}"
  network_interface_name      = "vm-win-nic-${var.prefix}"
  os_profile_admin_password   = var.os_profile_admin_password
  os_profile_admin_username   = var.os_profile_admin_username
  os_profile_computer_name    = "vm-win-${var.prefix}"
  public_ip_name              = "vm-win-ip-${var.prefix}"
  resource_group_location     = azurerm_resource_group.public.location
  resource_group_name         = azurerm_resource_group.public.name
  storage_image_reference_sku = var.storage_image_reference_sku
  storage_os_disk_name        = "vm-win-os-disk-${var.prefix}"
  subnet_id                   = module.network.subnet_id
  vm_name                     = "vm-win-${var.prefix}"
  vm_size                     = var.vm_size
  nsg_name                    = "vm-win-nsg-${var.prefix}"

  depends_on = [
    module.network,
    azurerm_resource_group.public
  ]
}
