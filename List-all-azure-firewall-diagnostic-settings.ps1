################
# Grabs the current diagnostic settings for all azure firewall resources in an environment, good for environment that needs review and evidence and has hundreds of azure firewalls
# author: Samuel Soto
# version: 0.1
#
# Preparation: you need a text file with all the resourceId for all the azure firewall resources.  Name it "azurefirewall.txt" and place it in C:\ drive. You can obtain these by running the "list-all-resources.ps1" script in this repo.
# Modify the variables below
# To run, after preparations indicated above, open a powershell window and use the Connect-AzAccount command to connect to Azure and execute this script.
##########################

# add file locations here
$azurefirewall = Get-Content -Path ".\azurefirewall.txt"
$azurefirewalloutput = ".\azurefirewall_diagnosticsettings.csv"


#multiple loops to prevent locking csv output files

ForEach ($afs in $azurefirewall) {
Get-AzDiagnosticSetting -ResourceId "$afs" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$afs}}, Name, StorageAccountId, WorkspaceId | Export-Csv -Path $azurefirewalloutput -NoTypeInformation -Append -Force
}

