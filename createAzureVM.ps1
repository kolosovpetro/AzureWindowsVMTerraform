$prefix = "05";     `
    $rgName = "rg-test-$prefix";     `
    $vmName = "vm-test$prefix";     `
    $storageAccountName = "stortestvm$prefix";     `
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
    --name "installSoftware.ps1" `
    --account-name $storageAccountName

$Date = (Get-Date).AddDays(5).ToString('yyyy-MM-dd');
$key = $( az storage account keys list --resource-group $rgName --account-name $storageAccountName --query [0].value -o tsv );
$sas = $( az storage container generate-sas --name $containerName --expiry $Date --permissions "racwdli" --account-name $storageAccountName --account-key "$key" ).Replace("`"","");

$fileUrl = "https://$storageAccountName.blob.core.windows.net/$containerName/installSoftware.ps1?$sas"

Set-AzVMCustomScriptExtension -ResourceGroupName $rgName `
    -VMName $vmName `
    -Location "northeurope" `
    -FileUri $fileUrl `
    -Run 'installSoftware.ps1' `
    -Name "DemoScriptExtension"

az group delete -n $rgName -y