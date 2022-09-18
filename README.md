# pwsh-subscription-automation


---

| Page Type | Languages     | Services |
|-----------|-----------|------------|
| Sample    | PowerShell    | Azure Functions <br> Azure Logic Apps |

---

# Automate the creation of Azure EA Subscriptions with PowerShell

This sample codebase demonstrates how to use PowerShell to programmatically create Enterprise Agreement (EA) subscriptions with a service principal.

## Prerequisite Tools
- [Install the Az PowerShell module](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-8.3.0)
- [Install the Azure Functions Core Tools](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=v4%2Cwindows%2Ccsharp%2Cportal%2Cbash)
- [Install VS Code (optional)](https://code.visualstudio.com/Download)

## Running this sample

### _*One-time setup*_
![Setup](/docs/images/onetimesetup.png)

1. Create an Azure service principal either through
    [Azure CLI](https://docs.microsoft.com/cli/azure/create-an-azure-service-principal-azure-cli?toc=%2fazure%2fazure-resource-manager%2ftoc.json),
    [PowerShell](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-authenticate-service-principal/)
    or [the portal](https://docs.microsoft.com/azure/azure-resource-manager/resource-group-create-service-principal-portal/).

2. As an EA Account Owner, follow instructions to [grant the service principal access to your enrollment account](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/assign-roles-azure-service-principals).

3. Create a [new secret in the service principal](https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal#option-2-create-a-new-application-secret) and note the value - it can only be seen at the time of creation, and it will be used in a later step.

4. [Get the ID of the billing + enrollment account you would like the subscriptions to be created in](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=rest#find-accounts-you-have-access-to). Make note of the ```billingAccount``` and ```enrollmentAccount``` names (they will appear as ```/providers/Microsoft.Billing/billingAccounts/<billingAccountName>/enrollmentAccounts/<enrollmentAccountName>```).

### _*Setting Up the Cloud Infrastructure*_
#### Function
- Change the variable names in the 'Resource names' section of the ```infra/function/deployFunction.ps1``` file to reflect the resource names you would like to deploy, and run the commands under the 'Set up resources' section.
- [Set the encrypted environment variables](https://learn.microsoft.com/en-us/azure/app-service/configure-common?tabs=portal#configure-app-settings) APP_ID, APP_TENANT, and APP_SEC in the newly created function app to contain your service principal's Application ID, Tenant ID, and Secret generated in Step 3 above.
- Run the command under the 'Deploy code' section of ```infra/function/deployFunction.ps1``` to publish the logic to the function.

#### Logic App
- Update the ```logicappdeploy.json``` file to reflect the resource name you'd like the Logic App to use, and update the file to use the Resource ID of the function deployed above (this string can be found in the 'Properties' tab of the Function in the Azure portal).
<!-- - Deploy the Logic App workflow following [these documented deployment steps](https://learn.microsoft.com/en-us/azure/logic-apps/create-single-tenant-workflows-visual-studio-code#deploy-to-azure). -->
- [Deploy the template](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/quickstart-create-templates-use-visual-studio-code?tabs=PowerShell#deploy-the-template) using the commands in ```infra/logicapp/deployLogicApp.ps1```.
- Get the URL of the Logic app by navigating to the resource in the Azure portal, opening the Logic app designer, and [copying the 'HTTP POST URL' in the 'When a HTTP request is recieved' step](https://learn.microsoft.com/en-us/azure/logic-apps/logic-apps-http-endpoint#create-a-callable-endpoint).

### _*Automated Subscription Generation*_

![Automation](/docs/images/automation.png)
1. Make a web request to the the Logic App using the URL retrieved above, providing a Subscription Alias, Subscription Name, Billing Account Name, and Enrollment Account name to the web request.
    - Note that a subscription alias is a name for the subscription creation request; this is not the same as the subscription name. The alias does not have any other lifecycle beyond the subscription creation request.
    - Follow the instructions [here](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=azure-powershell#create-subscriptions-under-a-specific-enrollment-account) for guidance on alias naming.  

## Limitations/Considerations
* Limitations can be found [here](https://learn.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=rest#limitations-of-azure-enterprise-subscription-creation-api).
* To avoid issues around [cold starts](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-powershell?tabs=portal#cold-start) and the need to [bundle](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-powershell?tabs=portal#bundle-modules-instead-of-using-install-module) modules with the function, the example deploys a function in an 'Always On' [App Service Plan](https://learn.microsoft.com/en-us/powershell/module/az.functions/new-azfunctionapp?view=azps-8.3.0#example-2-create-a-powershell-function-app-which-will-be-hosted-in-a-service-plan).

## Resources
* [Programmatically create Azure Enterprise Agreement subscriptions with the latest APIs](https://docs.microsoft.com/en-us/azure/cost-management-billing/manage/programmatically-create-subscription-enterprise-agreement?tabs=azure-cli)
* [Azure Enterprise Agreement (EA)](https://azure.microsoft.com/pricing/enterprise-agreement/)
* [Create an Azure Function in VSCode](https://docs.microsoft.com/en-us/azure/azure-functions/create-first-function-vs-code-csharp?tabs=in-process)
* [Create a subs Alias](https://learn.microsoft.com/en-us/rest/api/subscription/2020-09-01/alias/create?tabs=HTTP)
* [Create a Function App](https://learn.microsoft.com/en-us/azure/azure-functions/create-first-function-cli-powershell?tabs=azure-cli%2Cbrowser#create-supporting-azure-resources-for-your-function)
* [Deploy an Azure Function](https://learn.microsoft.com/en-us/azure/azure-functions/deployment-zip-push)
* [Create a Logic App](https://learn.microsoft.com/en-us/azure/logic-apps/quickstart-logic-apps-azure-powershell#update-logic-apps-from-powershell)
* [Using PowerShell Modules in Azure Functions](https://devblogs.microsoft.com/powershell/using-powershell-modules-in-azure-functions/)
* [Azure Functions running on Dedicated Plan](https://learn.microsoft.com/en-us/azure/azure-functions/dedicated-plan#always-on)
* [Service Principal Authentication in PowerShell](https://learn.microsoft.com/en-us/azure/developer/java/sdk/identity-service-principal-auth)