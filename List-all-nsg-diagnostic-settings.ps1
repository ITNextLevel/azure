################
# Grabs the current diagnostic settings for all NSG resources in an environment, good for environment that needs review and evidence and has hundreds of NSGs
# author: Samuel Soto
# version: 0.1
#
# Preparation: you need a text file with all the resourceId for all the NSG resources. Name it "nsg.txt" and place it in C:\ drive. You can obtain these by running the "list-all-resources.ps1" script in this repo.
# Modify the variables below
# To run, after preparations indicated above, open a powershell window and use the Connect-AzAccount command to connect to Azure and execute this script.
##########################

# add file locations here
$NSG = Get-Content -Path ".\nsg.txt"
$NSGoutput = ".\all-nsg_diagnosticsettings.csv"


#multiple loops to prevent locking csv output files

ForEach ($net in $NSG) {
Get-AzDiagnosticSetting -ResourceId "$net" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$net}}, Name, StorageAccountId, WorkspaceId | Export-Csv -Path $NSGoutput -NoTypeInformation -Append -Force
}

