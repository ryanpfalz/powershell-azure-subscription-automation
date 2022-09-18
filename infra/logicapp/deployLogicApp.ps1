# === Resource names ===
$resourceGroup = "AESubAutomation"
$templateFile = "./infra/logicapp/logicappdeploy.json"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroup -TemplateFile $templateFile