# Azure Windows VM Terraform

Terraform module for Azure Windows VM

- Module for Azure Windows VM using Azure images
- Module for Azure Windows VM using Azure images no public ip
- Module for Azure Windows VM using custom images
- Module for Azure Windows VM using custom images no public ip

## Examples

### Module for Azure Windows VM using custom images

```hcl
module "windows_vm_custom_image" {
  source                      = "git::git@github.com:kolosovpetro/AzureWindowsVMTerraform.git//modules/windows-vm-custom-image?ref=master"
  ip_configuration_name       = "ipc-custom-${var.prefix}"
  network_interface_name      = "nic-custom-${var.prefix}"
  network_security_group_id   = azurerm_network_security_group.public.id
  os_profile_admin_password   = trimspace(file("${path.root}/password.txt"))
  os_profile_admin_username   = "razumovsky_r"
  os_profile_computer_name    = "vm-custom-${var.prefix}"
  public_ip_name              = "pip-custom-${var.prefix}"
  location                    = azurerm_resource_group.public.location
  resource_group_name         = azurerm_resource_group.public.name
  custom_image_resource_group = "rg-packer-images-win"
  custom_image_sku            = "windows-server2022-v1"
  storage_os_disk_name        = "osdisk-custom-${var.prefix}"
  subnet_id                   = azurerm_subnet.internal.id
  vm_name                     = "vm-custom-${var.prefix}"
}
```

### Module for Azure Windows VM using custom images no public ip

```hcl
module "windows_vm_custom_image_no_pip" {
  source                      = "git::git@github.com:kolosovpetro/AzureWindowsVMTerraform.git//modules/windows-vm-custom-image-no-pip?ref=master"
  ip_configuration_name       = "ipc-custom1-${var.prefix}"
  network_interface_name      = "nic-custom1-${var.prefix}"
  network_security_group_id   = azurerm_network_security_group.public.id
  os_profile_admin_password   = trimspace(file("${path.root}/password.txt"))
  os_profile_admin_username   = "razumovsky_r"
  os_profile_computer_name    = "vm-custom1-${var.prefix}"
  location                    = azurerm_resource_group.public.location
  resource_group_name         = azurerm_resource_group.public.name
  custom_image_resource_group = "rg-packer-images-win"
  custom_image_sku            = "windows-server2022-v1"
  storage_os_disk_name        = "osdisk-custom1-${var.prefix}"
  subnet_id                   = azurerm_subnet.internal.id
  vm_name                     = "vm-custom1-${var.prefix}"
}
```

### Module for Azure Windows VM using Azure images

```hcl
module "windows_vm" {
  source                      = "git::git@github.com:kolosovpetro/AzureWindowsVMTerraform.git//modules/windows-vm?ref=master"
  ip_configuration_name       = "ipc-${var.prefix}"
  network_interface_name      = "nic-${var.prefix}"
  network_security_group_id   = azurerm_network_security_group.public.id
  os_profile_admin_password   = trimspace(file("${path.root}/password.txt"))
  os_profile_admin_username   = "razumovsky_r"
  os_profile_computer_name    = "vm-${var.prefix}"
  public_ip_name              = "pip-${var.prefix}"
  location                    = azurerm_resource_group.public.location
  resource_group_name         = azurerm_resource_group.public.name
  storage_image_reference_sku = "2022-Datacenter"
  storage_os_disk_name        = "osdisk-${var.prefix}"
  subnet_id                   = azurerm_subnet.internal.id
  vm_name                     = "vm-${var.prefix}"
}
```

### Module for Azure Windows VM using Azure images no public ip

```hcl
module "windows_vm_no_pip" {
  source                      = "git::git@github.com:kolosovpetro/AzureWindowsVMTerraform.git//modules/windows-vm-no-pip?ref=master"
  ip_configuration_name       = "ipc1-${var.prefix}"
  network_interface_name      = "nic1-${var.prefix}"
  network_security_group_id   = azurerm_network_security_group.public.id
  os_profile_admin_password   = trimspace(file("${path.root}/password.txt"))
  os_profile_admin_username   = "razumovsky_r"
  os_profile_computer_name    = "vm1-${var.prefix}"
  location                    = azurerm_resource_group.public.location
  resource_group_name         = azurerm_resource_group.public.name
  storage_image_reference_sku = "2022-Datacenter"
  storage_os_disk_name        = "osdisk1-${var.prefix}"
  subnet_id                   = azurerm_subnet.internal.id
  vm_name                     = "vm1-${var.prefix}"
}
```

## Notes

- Print available azure vm images:
  - `az vm image list`
  - https://learn.microsoft.com/en-us/cli/azure/vm/image?view=azure-cli-latest#az-vm-image-list
- Print available azure vm sizes:
  - `az vm list-sizes -l "northeurope"`
  - `az vm list-skus -l "northeurope" --size Standard_B4ms`
  - https://docs.microsoft.com/en-us/cli/azure/vm?view=azure-cli-latest#az-vm-list-sizes
- Custom script extension
  docs: https://learn.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows

## Modules used

- https://azure.microsoft.com/es-es/blog/chocolatey-with-custom-script-extension-on-azure-vms/
- https://devkimchi.com/2020/08/26/app-provisioning-on-azure-vm-with-chocolatey-for-live-streaming/
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension
