################
# Grabs the current diagnostic settings for all DB resources in an environment, good for environment that needs review and evidence and has hundreds of Cosmos DB accounts
# author: Samuel Soto
# version: 0.1
#
# Preparation: you need a text file with all the resourceId for all the Cosmos DB resources. Name it "cosmosDBs.txt" and place it in C:\ drive. You can obtain these by running the "list-all-resources.ps1" script in this repo.
# Modify the variables below
# To run, after preparations indicated above, open a powershell window and use the Connect-AzAccount command to connect to Azure and execute this script.
##########################

# add file locations here
$databases = Get-Content -Path ".\cosmosDBs.txt"
$databasesoutput = ".\all_cosmosDBs_diagnostic_settings.csv"


#multiple loops to prevent locking csv output files

ForEach ($db in $databases) {
Get-AzDiagnosticSetting -ResourceId "$db" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$db}}, Name, Category, Enabled, StorageAccountId, ServiceBusRuleId, EventHubAuthorizationRuleId, EventHubName, WorkspaceId | Export-Csv -Path $databasesoutput -NoTypeInformation -Append -Force
}

