# pwsh-subscription-automation


---

| Page Type | Languages     | Products |
|-----------|-----------|------------|
| Sample    | PowerShell    | Azure Functions <br> Azure Logic Apps |

---

# Automate the creation of Azure EA Subscriptions with PowerShell

This is sample codebase demonstrates how to use PowerShell to programmatically create EA subscriptions with a service principal.

## Running this sample

#### _*One-time setup*_
![Setup](/docs/images/onetimesetup.png)

1. [Install the Azure Az PowerShell module](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-8.3.0)
2. Create an Azure service principal either through
    [Azure CLI](https://docs.microsoft.com/cli/azure/create-an-azure-service-principal-azure-cli?toc=%2fazure%2fazure-resource-manager%2ftoc.json),
    [PowerShell](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-authenticate-service-principal/)
    or [the portal](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-create-service-principal-portal/).

3. As an EA Account Owner, follow instructions to [grant the service principal access to your enrollment account](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/assign-roles-azure-service-principals).

4. [Get the ID of the billing + enrollment account you would like the subscriptions to be created in](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=rest#find-accounts-you-have-access-to). Make note of the ```billingAccount``` and ```enrollmentAccount``` names (they will appear as ```/providers/Microsoft.Billing/billingAccounts/<billingAccountName>/enrollmentAccounts/<enrollmentAccountName>```).

#### _*Setting Up the Infrastructure*_
<!-- 1. Change the variable names in the ```infra/setup.ps1``` file to reflect the resource names you would like to deploy.
2. Run the commands in the file.
3. Publish the PowerShell script to the Azure Function that was provisioned.
4. Create an Logic App to invoke the Azure Function. -->

#### _*Automated Subscription Generation*_

![Automation](/docs/images/automation.png)
1. Invoke the Logic App, providing a Subscription Alias, Subscription Name, Billing Account Name, and Enrollment Account name to the web request.
    - Note that a subscription alias is a name for the subscription creation request; this is not the same as the subscription name. The alias does not have any other lifecycle beyond the subscription creation request.
    - Follow the instructions [here](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=azure-powershell#create-subscriptions-under-a-specific-enrollment-account) for guidance on alias naming.  

## Notes
- If debugging the function locally, ensure you install the [Azure Functions Core Tools](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=v4%2Cwindows%2Ccsharp%2Cportal%2Cbash). Functions can be debugged locally by changing into the project directory and running ```func start```.

## Resources

* [Programmatically create Azure Enterprise Agreement subscriptions with the latest APIs](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=azure-cli)
* [Azure Enterprise Agreement (EA)](https://azure.microsoft.com/pricing/enterprise-agreement/)
* [Azure EA Dev/Test option](https://azure.microsoft.com/offers/ms-azr-0148p/)
* [Create an Azure Function in VSCode](https://docs.microsoft.com/en-us/azure/azure-functions/create-first-function-vs-code-csharp?tabs=in-process)