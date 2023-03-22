# Azure VM Automation

This task assumes that you create a virtual machine with predefined state and list of preinstalled software. It can be
used: terraform, Azure DSC etc. Size of VM: `Standard_B4ms` (4 cores, 16 GB RAM)

**List of required software**:

- Google chrome
- Visual studio community
- Dotnet SDK
- Dotnet web app bundles
- IIS

## Notes

- Print available azure vm images:
    - `az vm image list`
    - https://learn.microsoft.com/en-us/cli/azure/vm/image?view=azure-cli-latest#az-vm-image-list
- Print available azure vm sizes:
    - `az vm list-sizes -l "northeurope"`
    - `az vm list-skus -l "northeurope" --size Standard_B4ms`
    - https://docs.microsoft.com/en-us/cli/azure/vm?view=azure-cli-latest#az-vm-list-sizes
- Custom script extension docs: https://learn.microsoft.com/en-us/azure/virtual-machines/extensions/custom-script-windows
- 

## Create VM via Az CLI

- `$rgName="rg-test-vm01"`
- `az group create -n $rgName -l "northeurope"`
- `$vmName="vm-test01"`
- `az vm create -n $vmName -g $rgName --admin-username "razumovsky_r" --admin-password "2HiVkwYAx0VKJoAC" --nsg-rule "RDP" --os-type "Windows" --image ""`

## Sources

- https://azure.microsoft.com/es-es/blog/chocolatey-with-custom-script-extension-on-azure-vms/
- https://devkimchi.com/2020/08/26/app-provisioning-on-azure-vm-with-chocolatey-for-live-streaming/