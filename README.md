# pwsh-subscription-automation


---

| Page Type | Languages     | Products |
|-----------|-----------|------------|
| Sample    | PowerShell    | Azure Functions <br> Azure Logic Apps |

---

# Automate the creation of Azure EA Subscriptions with PowerShell

This is sample codebase demonstrates how to use PowerShell to programmatically create EA subscriptions with a service principal.

## Prerequisites
- [Install the Az PowerShell module](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-8.3.0)
- [Install the Azure Functions Core Tools](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=v4%2Cwindows%2Ccsharp%2Cportal%2Cbash)

## Running this sample

### _*One-time setup*_
![Setup](/docs/images/onetimesetup.png)

1. Create an Azure service principal either through
    [Azure CLI](https://docs.microsoft.com/cli/azure/create-an-azure-service-principal-azure-cli?toc=%2fazure%2fazure-resource-manager%2ftoc.json),
    [PowerShell](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-authenticate-service-principal/)
    or [the portal](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-create-service-principal-portal/).

2. As an EA Account Owner, follow instructions to [grant the service principal access to your enrollment account](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/assign-roles-azure-service-principals).

3. [Get the ID of the billing + enrollment account you would like the subscriptions to be created in](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=rest#find-accounts-you-have-access-to). Make note of the ```billingAccount``` and ```enrollmentAccount``` names (they will appear as ```/providers/Microsoft.Billing/billingAccounts/<billingAccountName>/enrollmentAccounts/<enrollmentAccountName>```).

### _*Setting Up the Cloud Infrastructure*_
#### Setup
- Change the variable names in the ```infra/setupFunction.ps1``` file to reflect the resource names you would like to deploy and run the commands.

#### Deploy
- Set the function app name in the ```infra/deployFunction.ps1``` file to reflect the resource deployed in Setup step and run the command.
- Set the variable names and path to the Logic App workflow in ```infra/deployLogicApp.ps1``` and run the commands.

### _*Automated Subscription Generation*_

![Automation](/docs/images/automation.png)
1. Invoke the Logic App, providing a Subscription Alias, Subscription Name, Billing Account Name, and Enrollment Account name to the web request.
    - Note that a subscription alias is a name for the subscription creation request; this is not the same as the subscription name. The alias does not have any other lifecycle beyond the subscription creation request.
    - Follow the instructions [here](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=azure-powershell#create-subscriptions-under-a-specific-enrollment-account) for guidance on alias naming.  

## Limitations
Limitations can be found [here](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=rest#limitations-of-azure-enterprise-subscription-creation-api).

## Resources

* [Programmatically create Azure Enterprise Agreement subscriptions with the latest APIs](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=azure-cli)
* [Azure Enterprise Agreement (EA)](https://azure.microsoft.com/pricing/enterprise-agreement/)
* [Azure EA Dev/Test option](https://azure.microsoft.com/offers/ms-azr-0148p/)
* [Create an Azure Function in VSCode](https://docs.microsoft.com/en-us/azure/azure-functions/create-first-function-vs-code-csharp?tabs=in-process)
* [Create an Alias](https://learn.microsoft.com/en-us/rest/api/subscription/2020-09-01/alias/create?tabs=HTTP)
* [Create Function App](https://learn.microsoft.com/en-us/azure/azure-functions/create-first-function-cli-powershell?tabs=azure-cli%2Cbrowser#create-supporting-azure-resources-for-your-function)
* [Zip Deploy Azure Function](https://learn.microsoft.com/en-us/azure/azure-functions/deployment-zip-push)
* [Create Logic App](https://learn.microsoft.com/en-us/azure/logic-apps/quickstart-logic-apps-azure-powershell#update-logic-apps-from-powershell)