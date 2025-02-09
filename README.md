# Azure Windows VM Terraform

Terraform module for Azure Windows VM

- Module for Azure Windows VM using Azure images
- Module for Azure Windows VM using custom images

## Examples

### Module for Azure Windows VM using Azure images

```hcl
module "windows_vm" {
  source                      = "git::git@github.com:kolosovpetro/AzureWindowsVMTerraform.git//modules/windows-vm"
  ip_configuration_name       = "ipc-${var.prefix}"
  network_interface_name      = "nic-${var.prefix}"
  network_security_group_id   = azurerm_network_security_group.public.id
  os_profile_admin_password   = var.os_profile_admin_password
  os_profile_admin_username   = "razumovsky_r"
  os_profile_computer_name    = "vm-${var.prefix}"
  public_ip_name              = "pip-${var.prefix}"
  resource_group_location     = azurerm_resource_group.public.location
  resource_group_name         = azurerm_resource_group.public.name
  storage_image_reference_sku = "2022-Datacenter"
  storage_os_disk_name        = "osdisk-${var.prefix}"
  subnet_id                   = azurerm_subnet.internal.id
  vm_name                     = "vm-${var.prefix}"
}
```

### Module for Azure Windows VM using custom images

```hcl
data "azurerm_image" "search" {
    name                = "windows-server2022-v1"
    resource_group_name = "rg-packer-images-win"
}

module "windows_vm_custom_image" {
    source                    = "git::git@github.com:kolosovpetro/AzureWindowsVMTerraform.git//modules/windows-vm-custom-image"
    ip_configuration_name     = "ipc-custom-${var.prefix}"
    network_interface_name    = "nic-custom-${var.prefix}"
    network_security_group_id = azurerm_network_security_group.public.id
    os_profile_admin_password = var.os_profile_admin_password
    os_profile_admin_username = "razumovsky_r"
    os_profile_computer_name  = "vm-custom-${var.prefix}"
    public_ip_name            = "pip-custom-${var.prefix}"
    resource_group_location   = azurerm_resource_group.public.location
    resource_group_name       = azurerm_resource_group.public.name
    custom_image_id           = data.azurerm_image.search.id
    storage_os_disk_name      = "osdisk-custom-${var.prefix}"
    subnet_id                 = azurerm_subnet.internal.id
    vm_name                   = "vm-custom-${var.prefix}"

    depends_on = [
        data.azurerm_image.search
    ]
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
