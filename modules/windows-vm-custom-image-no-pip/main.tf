locals {
  tags = {
    Size     = var.vm_size
    Location = var.location
    PublicIP = "OFF"
    Image    = var.custom_image_sku
  }
}

resource "azurerm_network_interface" "public" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "public" {
  network_interface_id      = azurerm_network_interface.public.id
  network_security_group_id = var.network_security_group_id
}

data "azurerm_image" "search" {
  name                = var.custom_image_sku
  resource_group_name = var.custom_image_resource_group
}

resource "azurerm_virtual_machine" "public" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.public.id]
  vm_size               = var.vm_size

  delete_os_disk_on_termination = true

  identity {
    type = "SystemAssigned"
  }

  storage_image_reference {
    id = data.azurerm_image.search.id
  }

  storage_os_disk {
    name              = var.storage_os_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.managed_disk_type
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  os_profile {
    computer_name  = var.os_profile_computer_name
    admin_username = var.os_profile_admin_username
    admin_password = var.os_profile_admin_password
  }

  tags = length(var.tags) == 0 ? local.tags : var.tags

  depends_on = [
    azurerm_network_interface_security_group_association.public
  ]
}
