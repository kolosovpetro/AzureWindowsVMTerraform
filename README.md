# Azure Windows VM Terraform

Automation of azure VM initial state via custom script extensions and Terraform

## Trello tasks

- Terraform: https://trello.com/c/lEv89VzJ
- IIS: https://trello.com/c/abEYNHOT

## List of required software

- Edge browser [choco install microsoft-edge -y](https://community.chocolatey.org/packages/microsoft-edge)
- Visual studio
  community [choco install visualstudio2022community -y](https://community.chocolatey.org/packages/visualstudio2022community)
- Internet Information Services (IIS)
- Git [choco install git.install](https://community.chocolatey.org/packages/git.install)
- .NET Framework 4.8 SDK [choco install netfx-4.8-devpack](https://community.chocolatey.org/packages/netfx-4.8-devpack)
- .NET 6 [choco install dotnet-6.0-sdk](https://community.chocolatey.org/packages/dotnet-6.0-sdk)
- OpenSsl [choco install openssl](https://community.chocolatey.org/packages/openssl)
- PowerShell Core [choco install powershell-core](https://community.chocolatey.org/packages/powershell-core)
- WinRAR [choco install winrar](https://community.chocolatey.org/packages/winrar)
- Notepad++ [choco install notepadplusplus](https://community.chocolatey.org/packages/notepadplusplus)
- SQL Server 2019 Developer [choco install sql-server-2019 -y](https://community.chocolatey.org/packages/sql-server-2019)
- SQL Server Management
  Studio [choco install sql-server-management-studio](https://community.chocolatey.org/packages/sql-server-management-studio)
- NVM for Windows [choco install nvm](https://community.chocolatey.org/packages/nvm)

## General steps to deploy

1. Create custom script extension `ps1` file
2. Create blob storage account and container
3. Upload `ps1` file to blob storage
4. Create windows virtual machine
5. Deploy custom script extension to virtual machine providing custom script extension `ps1` file url from step 3

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

## Sources

- https://azure.microsoft.com/es-es/blog/chocolatey-with-custom-script-extension-on-azure-vms/
- https://devkimchi.com/2020/08/26/app-provisioning-on-azure-vm-with-chocolatey-for-live-streaming/
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.71.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.71.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./modules/keyvault | n/a |
| <a name="module_key_vault_secrets"></a> [key\_vault\_secrets](#module\_key\_vault\_secrets) | ./modules/keyvault-secrets | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_storage"></a> [storage](#module\_storage) | ./modules/storage | n/a |
| <a name="module_virtual_machine"></a> [virtual\_machine](#module\_virtual\_machine) | ./modules/vm | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.public](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.71.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_os_profile_admin_password"></a> [os\_profile\_admin\_password](#input\_os\_profile\_admin\_password) | Specifies the password of the administrator account. | `string` | n/a | yes |
| <a name="input_os_profile_admin_username"></a> [os\_profile\_admin\_username](#input\_os\_profile\_admin\_username) | Specifies the name of the administrator account. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Resources name prefix | `string` | n/a | yes |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of the resource group. | `string` | n/a | yes |
| <a name="input_storage_account_replication"></a> [storage\_account\_replication](#input\_storage\_account\_replication) | Specifies the replication type for this storage account. | `string` | n/a | yes |
| <a name="input_storage_account_tier"></a> [storage\_account\_tier](#input\_storage\_account\_tier) | Specifies the tier to use for this storage account. | `string` | n/a | yes |
| <a name="input_storage_image_reference_offer"></a> [storage\_image\_reference\_offer](#input\_storage\_image\_reference\_offer) | Specifies the offer of the platform image or marketplace image used to create the virtual machine. | `string` | n/a | yes |
| <a name="input_storage_image_reference_publisher"></a> [storage\_image\_reference\_publisher](#input\_storage\_image\_reference\_publisher) | The publisher of the image used to create the virtual machine. | `string` | n/a | yes |
| <a name="input_storage_image_reference_sku"></a> [storage\_image\_reference\_sku](#input\_storage\_image\_reference\_sku) | Specifies the SKU of the platform image or marketplace image used to create the virtual machine. | `string` | n/a | yes |
| <a name="input_storage_image_reference_version"></a> [storage\_image\_reference\_version](#input\_storage\_image\_reference\_version) | Specifies the version of the platform image or marketplace image used to create the virtual machine. | `string` | n/a | yes |
| <a name="input_storage_os_disk_caching"></a> [storage\_os\_disk\_caching](#input\_storage\_os\_disk\_caching) | Specifies the caching requirements for the OS disk. | `string` | n/a | yes |
| <a name="input_storage_os_disk_create_option"></a> [storage\_os\_disk\_create\_option](#input\_storage\_os\_disk\_create\_option) | Specifies how the virtual machine should be created. | `string` | n/a | yes |
| <a name="input_storage_os_disk_managed_disk_type"></a> [storage\_os\_disk\_managed\_disk\_type](#input\_storage\_os\_disk\_managed\_disk\_type) | Specifies the storage account type for the managed disk. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The size of the virtual machine. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | n/a |
| <a name="output_username"></a> [username](#output\_username) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
