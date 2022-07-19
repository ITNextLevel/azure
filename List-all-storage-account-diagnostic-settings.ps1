################
# Grabs the current diagnostic settings for all storage accounts in an environment, good for environment that needs review and evidence and has hundreds of storage accounts
# author: Samuel Soto
# version: 0.1
#
# Preparation: you need a text file with all the resourceId for all the storage accounts. name it "storageaccounts.txt" and place it in C:\ drive. You can obtain these by running the "list-all-resources.ps1" script in this repo.
# Modify the variables below
# To run, after preparations indicated above, open a powershell window and use the Connect-AzAccount command to connect to Azure and execute this script.
##########################

# add file locations here
$storageaccounts = Get-Content -Path ".\storageaccounts.txt"
$storageaccountoutput = ".\all-Storage-Accounts_diagnosticsettings.csv"
$storagebloboutput = ".\all-Storage-Blobs_diagnosticsettings.csv"
$storagefilesharetoutput = ".\all-Storage-FileShares_diagnosticsettings.csv"
$storagequeueoutput = ".\all-Storage-Queue_diagnositcsettings.csv"
$storagetableoutput = ".\all-Storage-Tables_diagnosticsettings.csv"


#multiple loops to prevent locking csv output files

ForEach ($staccount in $storageaccounts) {
Get-AzDiagnosticSetting -ResourceId "$staccount" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$staccount}}, Name, StorageAccountId, ServiceBusRuleId, EventHubAuthorizationRuleId, EventHubName, WorkspaceId | Export-Csv -Path $storageaccountoutput -NoTypeInformation -Append -Force
}

ForEach ($staccount in $storageaccounts) {
$blob = $staccount + "/blobservices/default"
Get-AzDiagnosticSetting -ResourceId "$blob" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$staccount}}, Name, StorageAccountId, ServiceBusRuleId, EventHubAuthorizationRuleId, EventHubName, WorkspaceId | Export-Csv -Path $storagebloboutput -NoTypeInformation -Append -Force
}

ForEach ($staccount in $storageaccounts) {
$fileshare = $staccount + "/fileservices/default"
Get-AzDiagnosticSetting -ResourceId "$fileshare" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$staccount}}, Name, StorageAccountId, ServiceBusRuleId, EventHubAuthorizationRuleId, EventHubName, WorkspaceId | Export-Csv -Path $storagefilesharetoutput -NoTypeInformation -Append -Force
}

ForEach ($staccount in $storageaccounts) {
$table = $staccount + "/tableservices/default"
Get-AzDiagnosticSetting -ResourceId "$table" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$staccount}}, Name, StorageAccountId, ServiceBusRuleId, EventHubAuthorizationRuleId, EventHubName, WorkspaceId | Export-Csv -Path $storagetableoutput -NoTypeInformation -Append -Force
}

ForEach ($staccount in $storageaccounts) {
$queue = $staccount + "/queueservices/default"
Get-AzDiagnosticSetting -ResourceId "$queue" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$staccount}}, Name, StorageAccountId, ServiceBusRuleId, EventHubAuthorizationRuleId, EventHubName, WorkspaceId | Export-Csv -Path $storagequeueoutput -NoTypeInformation -Append -Force
}