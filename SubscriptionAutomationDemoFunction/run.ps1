using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Global error action preference to enable exception handling if Az command fails
$ErrorActionPreference = "Stop"

# Authenticate with env variables
[SecureString]$sec = [Environment]::GetEnvironmentVariable("APP_SEC") | ConvertTo-SecureString -AsPlainText -Force
[PSCredential]$credentials = New-Object System.Management.Automation.PSCredential ([Environment]::GetEnvironmentVariable('APP_ID'), $sec)
$tenantId = [Environment]::GetEnvironmentVariable('APP_TENANT')

Connect-AzAccount -ServicePrincipal -Credential $credentials -Tenant $tenantId

# Interact with query parameters or the body of the request.
$billingAccount = $Request.Body.BillingAccount
$enrollmentAccount = $Request.Body.EnrollmentAccount
$subscriptionAlias = $Request.Body.SubscriptionAlias
$subscriptionName = $Request.Body.SubscriptionName

# Validate parameters
if (!$billingAccount -or !$enrollmentAccount -or !$subscriptionAlias -or !$subscriptionName) {
    $body = "Please provide a billing account, enrollment account, subscription alias, and subscription name."
} else {

    # Create subscription
    try {

        $body = "Received arguments:`nBilling Account: $billingAccount`nEnrollment Account: $enrollmentAccount`nSubscription Alias: $subscriptionAlias`nSubscription Name: $subscriptionName"
        
        # TODO This command will create a subscription
        # New-AzSubscriptionAlias -AliasName $subscriptionAlias -SubscriptionName $subscriptionName -BillingScope "/providers/Microsoft.Billing/BillingAccounts/$billingAccount/enrollmentAccounts/$enrollmentAccount"

    } catch {
        $body = "An error occurred: $_"
    }
    
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
