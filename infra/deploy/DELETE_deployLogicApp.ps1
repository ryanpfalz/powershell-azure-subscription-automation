$resourceGroup = "SubscriptionAutomation"
$location = "centralus"
$logicAppName = "subautodemologic"

# Create Resource Group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Create Logic App
New-AzLogicApp -ResourceGroupName $resourceGroup -Location $location -Name $logicAppName -DefinitionFilePath "./SubscriptionAutomationDemoLogicApp/workflow.json"

# Update Logic App
Set-AzLogicApp -ResourceGroupName $resourceGroup -Name $location -DefinitionFilePath "./SubscriptionAutomationDemoLogicApp/workflow.json"