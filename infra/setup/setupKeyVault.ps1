$resourceGroup = "SubscriptionAutomation"
$location = "centralus"
$keyVaultName = "subautokv"

# https://learn.microsoft.com/en-us/azure/key-vault/secrets/quick-create-powershell#adding-a-secret-to-key-vault

New-AzKeyVault -Name $keyVaultName -ResourceGroupName $resourceGroup -Location $location

$clientId = "<YOUR-SERVICEPRINCIPAL-OBJECTID>"
Set-AzKeyVaultAccessPolicy -VaultName $keyVaultName -UserPrincipalName $clientId -PermissionsToSecrets get,set

$secretvalue = ConvertTo-SecureString "<YOUR-SERVICEPRINCIPAL-SECRET>" -AsPlainText -Force
$secret = Set-AzKeyVaultSecret -VaultName $keyVaultName -Name "SpSecret" -SecretValue $secretvalue