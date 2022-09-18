# === Resource names ===
$resourceGroup = "AESubAutomation"
$location = "centralus"
$storageAccountName = "aesubautodemostorage"
$functionAppName = "aesubautodemofunction"
$appServicePlanName = "aesubautodemoasp"

## === Set up resources ===

# Resource group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Storage account
New-AzStorageAccount -ResourceGroupName $resourceGroup -Name $storageAccountName -SkuName "Standard_LRS" -Location $location

# Function app (dedicated)
New-AzAppServicePlan -ResourceGroupName $resourceGroup -Name $appServicePlanName -Location $location -Tier "Basic" -NumberofWorkers 1 -WorkerSize "Small" -Linux

New-AzFunctionApp -Name $functionAppName -ResourceGroupName $resourceGroup -PlanName $appServicePlanName -StorageAccount $storageAccountName -Runtime "PowerShell" -FunctionsVersion 4 -RuntimeVersion "7.0" -OSType "Linux"

## === Deploy code ===

# deploy using the Azure Functions Core Tools
func azure functionapp publish $functionAppName