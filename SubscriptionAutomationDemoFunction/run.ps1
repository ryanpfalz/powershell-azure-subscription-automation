using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Interact with query parameters or the body of the request.
$billingAccount = $Request.Body.BillingAccount
$enrollmentAccount = $Request.Body.EnrollmentAccount
$subscriptionAlias = $Request.Body.SubscriptionAlias
$subscriptionName = $Request.Body.SubscriptionName

# use https://learn.microsoft.com/en-us/powershell/azure/authenticate-azureps?view=azps-8.3.0, get credentials from KV

$ErrorActionPreference = "Stop"

# Check for parameters and create subscription
if (!$billingAccount -or !$enrollmentAccount -or !$subscriptionAlias -or !$subscriptionName) {
    $body = "Please provide a billing account, enrollment account, subscription alias, and subscription name."
} else {

    try {
        # This command will create a subscription
        # New-AzSubscriptionAlias -AliasName $subscriptionAlias -SubscriptionName $subscriptionName -BillingScope "/providers/Microsoft.Billing/BillingAccounts/$billingAccount/enrollmentAccounts/$enrollmentAccount"

        $test = Get-AzContext

        $body = "Success: $billingAccount $enrollmentAccount $subscriptionAlias $subscriptionName $($test[0].Name)"
    } catch {
        $body = "An error occurred: $_"
    }
    
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body = $body
})
