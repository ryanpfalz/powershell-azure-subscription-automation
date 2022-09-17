using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Global error action preference to enable exception handling if Az command fails
$ErrorActionPreference = "Stop"

# Authenticate with SP
[SecureString]$pwd = [Environment]::GetEnvironmentVariable("APP_SEC") | ConvertTo-SecureString -AsPlainText -Force
[PSCredential]$credentials = New-Object System.Management.Automation.PSCredential ([Environment]::GetEnvironmentVariable('APP_ID'), $pwd)
$tenantId = [Environment]::GetEnvironmentVariable('APP_TENANT')

Connect-AzAccount -ServicePrincipal -Credential $credentials -Tenant $tenantId

# Import-Module "./SubscriptionAutomationDemoFunction/modules/Az.Accounts/2.7.2/Az.Accounts.psm1"
# Import-Module "./SubscriptionAutomationDemoFunction/modules/Az.Subscription/0.8.1/Az.Subscription.psm1"

# Interact with query parameters or the body of the request.
$billingAccount = $Request.Body.BillingAccount
$enrollmentAccount = $Request.Body.EnrollmentAccount
$subscriptionAlias = $Request.Body.SubscriptionAlias
$subscriptionName = $Request.Body.SubscriptionName

# use https://learn.microsoft.com/en-us/powershell/azure/authenticate-azureps?view=azps-8.3.0, get credentials from KV

# Check for parameters and create subscription
if (!$billingAccount -or !$enrollmentAccount -or !$subscriptionAlias -or !$subscriptionName) {
    $body = "Please provide a billing account, enrollment account, subscription alias, and subscription name."
} else {

    try {

        $body = "Received arguments:
        Billing Account: $billingAccount
        Enrollment Account: $enrollmentAccount
        Subscription Alias: $subscriptionAlias
        Subscription Name: $subscriptionName"
        
        # This command will create a subscription
        New-AzSubscriptionAlias -AliasName $subscriptionAlias -SubscriptionName $subscriptionName -BillingScope "/providers/Microsoft.Billing/BillingAccounts/$billingAccount/enrollmentAccounts/$enrollmentAccount"

    } catch {
        $body = "An error occurred: $_"
    }
    
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
