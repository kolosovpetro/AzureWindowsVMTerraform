# Azure Windows VM Custom Script Extensions

This task assumes that you create a virtual machine with predefined state and list of preinstalled software. It can be
used: terraform, Azure DSC etc. Size of VM: `Standard_B4ms` (4 cores, 16 GB RAM)

## List of required software

- Edge browser [choco install microsoft-edge](https://community.chocolatey.org/packages/microsoft-edge)
- Visual studio
  community [choco install visualstudio2022community](https://community.chocolatey.org/packages/visualstudio2022community)
- Internet Information Services (IIS)
- Git [choco install git.install](https://community.chocolatey.org/packages/git.install)
- .NET Framework 4.8 SDK [choco install netfx-4.8-devpack](https://community.chocolatey.org/packages/netfx-4.8-devpack)
- .NET 6 [choco install dotnet-6.0-sdk](https://community.chocolatey.org/packages/dotnet-6.0-sdk)
- OpenSsl [choco install openssl](https://community.chocolatey.org/packages/openssl)
- PowerShell Core [choco install powershell-core](https://community.chocolatey.org/packages/powershell-core)
- WinRAR [choco install winrar](https://community.chocolatey.org/packages/winrar)
- Notepad++ [choco install notepadplusplus](https://community.chocolatey.org/packages/notepadplusplus)
- SQL Server 2019 Developer [choco install sql-server-2019](https://community.chocolatey.org/packages/sql-server-2019)
- SQL Server Management
  Studio [choco install sql-server-management-studio](https://community.chocolatey.org/packages/sql-server-management-studio)
- NVM for Windows [choco install nvm](https://community.chocolatey.org/packages/nvm)

## General steps to deploy

1. Create custom script extension `ps1` file
2. Create blob storage account and container
3. Upload `ps1` file to blob storage
4. Create windows virtual machine
5. Deploy custom script extension to virtual machine providing custom script extension `ps1` file url from step 3

## Terraform commands

- Init examples:
    - `terraform init`
    - `terraform init -backend-config="azure.conf"`
    - `terraform init -backend-config="azure.sas.conf"`
- Plan examples
    - `terraform plan -var "prefix=${prefix}" -out "main.tfplan"`
    - `terraform plan -var "prefix=${prefix}" -var "sql_admin_password=$env:MANGO_TF_SQL_PASS" -out "main.tfplan"`
    - `terraform plan -var "prefix=${prefix}" -var "os_profile_admin_password=1wSWB2Mbl8918kFvtwac" -out "main.tfplan"`
    - `terraform plan -out main.tfplan`
    - `terraform plan -var-file='terraform.dev.tfvars' -var sql_admin_username='razumovsky_r' -var sql_admin_password='Zd2yqLgyV4uHVC0eTPiH' -out 'main.tfplan'`
    - `terraform plan -var-file='terraform.dev.tfvars' -out 'dev.tfplan'`
- Apply examples:
    - `terraform apply main.tfplan`
    - `terraform fmt --check`
- Destroy examples:
    - `terraform plan -var "sql_admin_password=$env:MANGO_TF_SQL_PASS" -var "prefix=${prefix}" -destroy -out "main.destroy.tfplan"`
    - `terraform apply -destroy -auto-approve "main.destroy.tfplan"`
- Workspace examples:
    - `terraform workspace new d01`
    - `terraform workspace select d01`

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