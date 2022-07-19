################
# Grabs the current diagnostic settings for all event hub resources in an environment, good for environment that needs review and evidence and has hundreds of event Hub resources
# author: Samuel Soto
# version: 0.1
#
# Preparation: you need a text file with all the resourceId for all the Event Hub resources. Name it "eventhubs.txt" and place it in C:\ drive. You can obtain these by running the "list-all-resources.ps1" script in this repo.
# Modify the variables below
# To run, after preparations indicated above, open a powershell window and use the Connect-AzAccount command to connect to Azure and execute this script.
##########################

# add file locations here
$eventhubs = Get-Content -Path ".\eventhubs.txt"
$eventhubsoutput = ".\all_eventhubs_diagnostic_resources.csv"


#multiple loops to prevent locking csv output files

ForEach ($eh in $eventhubs) {
Get-AzDiagnosticSetting -ResourceId "$eh" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$eh}}, Name, StorageAccountId, WorkspaceId | Export-Csv -Path $eventhubsoutput -NoTypeInformation -Append -Force
}

