resource "azurerm_resource_group" "public" {
  location = var.resource_group_location
  name     = "${var.resource_group_name}-${var.prefix}"
}

module "network" {
  source                  = "./modules/network"
  nsg_name                = "${var.nsg_name}-${var.prefix}"
  resource_group_location = azurerm_resource_group.public.location
  resource_group_name     = azurerm_resource_group.public.name
  subnet_name             = "${var.subnet_name}-${var.prefix}"
  vnet_name               = "${var.vnet_name}-${var.prefix}"

  depends_on = [
    azurerm_resource_group.public
  ]
}

module "storage" {
  source                                = "./modules/storage"
  custom_script_extension_absolute_path = var.custom_script_extension_absolute_path
  custom_script_extension_file_name     = var.custom_script_extension_file_name
  storage_account_name                  = "${var.storage_account_name}${var.prefix}"
  storage_account_replication           = var.storage_account_replication
  storage_account_tier                  = var.storage_account_tier
  storage_container_name                = "${var.storage_container_name}${var.prefix}"
  storage_location                      = azurerm_resource_group.public.location
  storage_resource_group_name           = azurerm_resource_group.public.name

  depends_on = [
    azurerm_resource_group.public
  ]
}

module "virtual_machine" {
  source                            = "./modules/vm"
  ip_configuration_name             = var.ip_configuration_name
  network_interface_name            = "${var.network_interface_name}-${var.prefix}"
  network_security_group_id         = module.network.network_security_group_id
  os_profile_admin_password         = var.os_profile_admin_password
  os_profile_admin_username         = var.os_profile_admin_username
  os_profile_computer_name          = var.os_profile_computer_name
  public_ip_name                    = "${var.public_ip_name}-${var.prefix}"
  resource_group_location           = azurerm_resource_group.public.location
  resource_group_name               = azurerm_resource_group.public.name
  storage_image_reference_offer     = var.storage_image_reference_offer
  storage_image_reference_publisher = var.storage_image_reference_publisher
  storage_image_reference_sku       = var.storage_image_reference_sku
  storage_image_reference_version   = var.storage_image_reference_version
  storage_os_disk_caching           = var.storage_os_disk_caching
  storage_os_disk_create_option     = var.storage_os_disk_create_option
  storage_os_disk_managed_disk_type = var.storage_os_disk_managed_disk_type
  storage_os_disk_name              = "${var.storage_os_disk_name}-${var.prefix}"
  subnet_id                         = module.network.subnet_id
  vm_name                           = "${var.vm_name}-${var.prefix}"
  vm_size                           = var.vm_size
}

#resource "azurerm_public_ip" "public" {
#  name                = "vmPublicIP-${var.prefix}"
#  resource_group_name = azurerm_resource_group.public.name
#  location            = azurerm_resource_group.public.location
#  allocation_method   = "Static"
#}
#
#resource "azurerm_network_interface" "public" {
#  name                = "${var.network_interface_name}-${var.prefix}"
#  location            = azurerm_resource_group.public.location
#  resource_group_name = azurerm_resource_group.public.name
#
#  ip_configuration {
#    name                          = "${var.ip_configuration_name}-${var.prefix}"
#    subnet_id                     = azurerm_subnet.internal.id
#    private_ip_address_allocation = "Dynamic"
#    public_ip_address_id          = azurerm_public_ip.public.id
#  }
#}
#
#resource "azurerm_network_interface_security_group_association" "public" {
#  network_interface_id      = azurerm_network_interface.public.id
#  network_security_group_id = azurerm_network_security_group.public.id
#}
#
#resource "azurerm_virtual_machine" "public" {
#  name                  = "${var.vm_name}-${var.prefix}"
#  location              = azurerm_resource_group.public.location
#  resource_group_name   = azurerm_resource_group.public.name
#  network_interface_ids = [azurerm_network_interface.public.id]
#  vm_size               = var.vm_size
#  
#  delete_os_disk_on_termination = true
#
#  storage_image_reference {
#    publisher = var.storage_image_reference_publisher # MicrosoftWindowsServer
#    offer     = var.storage_image_reference_offer     # WindowsServer
#    sku       = var.storage_image_reference_sku       # 2019-Datacenter
#    version   = var.storage_image_reference_version   # latest
#  }
#
#  storage_os_disk {
#    name              = "${var.storage_os_disk_name}-${var.prefix}" # osdisk-prefix
#    caching           = var.storage_os_disk_caching                 # ReadWrite
#    create_option     = var.storage_os_disk_create_option           # FromImage
#    managed_disk_type = var.storage_os_disk_managed_disk_type       # StandardSSD_LRS
#  }
#
#  os_profile_windows_config {
#    provision_vm_agent = true
#  }
#
#  os_profile {
#    computer_name  = var.os_profile_computer_name
#    admin_username = var.os_profile_admin_username
#    admin_password = var.os_profile_admin_password
#  }
#}

#resource "azurerm_storage_account" "public" {
#  name                     = "${var.storage_account_name}${var.prefix}"
#  location                 = azurerm_resource_group.public.location
#  resource_group_name      = azurerm_resource_group.public.name
#  account_tier             = "Standard"
#  account_replication_type = "LRS"
#}
#
#resource "azurerm_storage_container" "public" {
#  name                  = var.storage_container_name
#  storage_account_name  = azurerm_storage_account.public.name
#  container_access_type = "blob"
#}
#
#resource "azurerm_storage_blob" "public" {
#  name                   = var.custom_script_extension_file_name
#  storage_account_name   = azurerm_storage_account.public.name
#  storage_container_name = azurerm_storage_container.public.name
#  type                   = "Block"
#  source                 = var.custom_script_extension_absolute_path
#}

#resource "azurerm_virtual_machine_extension" "public" {
#  name                 = "${var.os_profile_computer_name}H"
#  virtual_machine_id   = azurerm_virtual_machine.public.id
#  publisher            = "Microsoft.Compute"
#  type                 = "CustomScriptExtension"
#  type_handler_version = "1.10"
#
#  settings = <<SETTINGS
#        {
#            "fileUris": [
#                "${azurerm_storage_blob.public.url}"
#                ],
#            "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -File ${var.custom_script_extension_file_name}"
#        }
#    SETTINGS
#}