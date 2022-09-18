$resourceGroup = "AESubAutomation"
$location = "centralus"
$storageAccountName = "aesubautodemostorage"
$functionAppName = "aesubautodemofunction"
$appServicePlanName = "aesubautodemoasp"

# Resource group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Storage account
New-AzStorageAccount -ResourceGroupName $resourceGroup -Name $storageAccountName -SkuName "Standard_LRS" -Location $location

# Function app (consumption)
# New-AzFunctionApp -Name $functionAppName -ResourceGroupName $resourceGroup -StorageAccount $storageAccountName -Runtime "PowerShell" -FunctionsVersion 4 -Location $location -OSType "Linux" -RuntimeVersion "7.0"

# Function app (dedicated ASP)

New-AzAppServicePlan -ResourceGroupName $resourceGroup -Name $appServicePlanName -Location $location -Tier "Basic" -NumberofWorkers 1 -WorkerSize "Small" #-Linux

New-AzFunctionApp -Name $functionAppName -ResourceGroupName $resourceGroup -PlanName $appServicePlanName -StorageAccount $storageAccountName -Runtime "PowerShell" -FunctionsVersion 4 -RuntimeVersion "7.0" # -OSType "Linux"