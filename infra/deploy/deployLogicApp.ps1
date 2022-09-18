$resourceGroup = "SubscriptionAutomation"
$location = "centralus"
$logicAppName = "subautodemologic"

# Create Resource Group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Create Logic App #TODO DEPLOY CONSUMPTION
New-AzLogicApp -ResourceGroupName $resourceGroup -Location $location -Name $logicAppName -DefinitionFilePath "./infra/deploy/SubscriptionAutomationDemoLogicApp/workflow.json"

# Update Logic App
Set-AzLogicApp -ResourceGroupName $resourceGroup -Name $location -DefinitionFilePath "./infra/deploy/SubscriptionAutomationDemoLogicApp/workflow.json"