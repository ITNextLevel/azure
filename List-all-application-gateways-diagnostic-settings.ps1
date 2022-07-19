################
# Grabs the current diagnostic settings for all application gatways resources in an environment, good for environment that needs review and evidence and has hundreds of application gateways
# author: Samuel Soto
# version: 0.1
#
# Preparation: you need a text file with all the resourceId for all the application gateways resources. Name it "applicationgateways.txt" and place it in C:\ drive. You can obtain these by running the "list-all-resources.ps1" script in this repo.
# Modify the variables below
# To run, after preparations indicated above, open a powershell window and use the Connect-AzAccount command to connect to Azure and execute this script.
##########################

# add file locations here
$applicationgateways = Get-Content -Path ".\applicationgateways.txt"
$applicationgatewaysoutput = ".\applicationgateways_diagnosticsettings.csv"


#multiple loops to prevent locking csv output files

ForEach ($ag in $applicationgateways) {
Get-AzDiagnosticSetting -ResourceId "$ag" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$ag}}, Name, StorageAccountId, WorkspaceId | Export-Csv -Path $applicationgatewaysoutput -NoTypeInformation -Append -Force
}

