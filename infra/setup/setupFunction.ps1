$resourceGroup = "SubscriptionAutomation"
$location = "centralus"
$storageAccountName = "subautodemostorage"
$functionAppName = "subautodemofunction"

# Resource group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Storage account
New-AzStorageAccount -ResourceGroupName $resourceGroup -Name $storageAccountName -SkuName "Standard_LRS" -Location $location

# Function app
New-AzFunctionApp -Name $functionAppName -ResourceGroupName $resourceGroup -StorageAccount $storageAccountName -Runtime "PowerShell" -FunctionsVersion 4 -Location $location -OSType "Linux" -RuntimeVersion "7.0"