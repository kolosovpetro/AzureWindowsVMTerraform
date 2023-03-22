$prefix = "04";    `
   $rgName = "rg-test-$prefix";    `
   $vmName = "vm-test$prefix";    `
   $storageAccountName = "stortestvm$prefix";    `
   $containerName = "container-test-vm$prefix";

az group create -n $rgName -l "northeurope";

az vm create `
    -n $vmName `
    -g $rgName `
    --admin-username "razumovsky_r" `
    --admin-password "2HiVkwYAx0VKJoAC" `
    --nsg-rule "RDP" `
    --image "Win2022Datacenter" `
    --public-ip-address "$vmName-ip01" `
    --public-ip-address-allocation "static" `
    --size "Standard_B4ms"

az vm create `
    -n $vmName `
    -g $rgName `
    --admin-username "razumovsky_r" `
    --admin-password "2HiVkwYAx0VKJoAC" `
    --nsg-rule "RDP" `
    --image "Win2022Datacenter" `
    --public-ip-sku "Standard" `
    --size "Standard_B4ms"

az vm open-port -g $rgName -n $vmName --port 80 --priority 1010

az storage account create `
    --name $storageAccountName `
    --resource-group $rgName `
    --location "northeurope" `
    --sku "Standard_LRS" `
    --kind "StorageV2"

az storage container create `
    --name $containerName `
    --account-name $storageAccountName `
    --public-access "off"

az storage blob upload `
    --container-name $containerName `
    --file "installSoftware.ps1" `
    --name "installSoftwareNew.ps1" `
    --account-name $storageAccountName

$fileUrl = "https://stortestvm04.blob.core.windows.net/container-test-vm04/installSoftware.ps1?sp=r&st=2023-03-22T18:48:20Z&se=2023-03-23T02:48:20Z&spr=https&sv=2021-12-02&sr=b&sig=z5kmJy5bwHDSmhqv2NUC455thItzSmx9ZGOicaTx%2FGw%3D"

Set-AzVMCustomScriptExtension -ResourceGroupName $rgName `
    -VMName $vmName `
    -Location "northeurope" `
    -FileUri $fileUrl `
    -Run 'installSoftware.ps1' `
    -Name "DemoScriptExtension"

az group delete -n $rgName -y