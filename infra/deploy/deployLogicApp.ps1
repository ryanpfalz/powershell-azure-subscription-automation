$resourceGroup = "SubscriptionAutomation"
$location = "centralus"
$logicAppName = "subscriptionautomationdemologic"

# Create Resource Group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Create Logic App
New-AzLogicApp -ResourceGroupName $resourceGroup -Location $location -Name $logicAppName -DefinitionFilePath "./infra/deploy/SubscriptionAutomationDemoLogicApp/workflow.json"

# Update Logic App
Set-AzLogicApp -ResourceGroupName $resourceGroup -Name $location -DefinitionFilePath "./infra/deploy/SubscriptionAutomationDemoLogicApp/workflow.json"