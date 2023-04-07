resource "azurerm_resource_group" "public" {
  location = var.resource_group_location
  name     = "${var.resource_group_name}-${var.prefix}"
}

resource "azurerm_virtual_network" "public" {
  name                = "${var.vnet_name}-${var.prefix}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.public.location
  resource_group_name = azurerm_resource_group.public.name
}

resource "azurerm_subnet" "internal" {
  name                 = "${var.subnet_name}-${var.prefix}"
  resource_group_name  = azurerm_resource_group.public.name
  virtual_network_name = azurerm_virtual_network.public.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "vmPublicIP-${var.prefix}"
  resource_group_name = azurerm_resource_group.public.name
  location            = azurerm_resource_group.public.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "public" {
  name                = "${var.network_interface_name}-${var.prefix}"
  location            = azurerm_resource_group.public.location
  resource_group_name = azurerm_resource_group.public.name

  ip_configuration {
    name                          = "${var.ip_configuration_name}-${var.prefix}"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_security_group" "example" {
  name                = "nsg-${var.prefix}"
  location            = azurerm_resource_group.public.location
  resource_group_name = azurerm_resource_group.public.name

  # RDP
  security_rule {
    name                       = "AllowRDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # HTTP
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # HTTPS
  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 1020
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.public.id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_virtual_machine" "public" {
  name                  = "${var.vm_name}-${var.prefix}"
  location              = azurerm_resource_group.public.location
  resource_group_name   = azurerm_resource_group.public.name
  network_interface_ids = [azurerm_network_interface.public.id]
  vm_size               = var.vm_size

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = var.storage_image_reference_publisher # MicrosoftWindowsServer
    offer     = var.storage_image_reference_offer     # WindowsServer
    sku       = var.storage_image_reference_sku       # 2022-Datacenter
    version   = var.storage_image_reference_version   # latest
  }

  storage_os_disk {
    name              = "${var.storage_os_disk_name}-${var.prefix}" # osdisk-prefix
    caching           = var.storage_os_disk_caching                 # ReadWrite
    create_option     = var.storage_os_disk_create_option           # FromImage
    managed_disk_type = var.storage_os_disk_managed_disk_type       # StandardSSD_LRS
  }

  os_profile_windows_config {
  }

  os_profile {
    computer_name  = var.os_profile_computer_name
    admin_username = var.os_profile_admin_username
    admin_password = var.os_profile_admin_password
  }
}