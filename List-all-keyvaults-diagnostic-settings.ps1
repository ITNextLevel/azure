################
# Grabs the current diagnostic settings for all key vaults in an environment, good for environment that needs review and evidence and has hundreds of key vaults accounts
# author: Samuel Soto
# version: 0.1
#
# Preparation: you need a text file with all the resourceId for all the keyvaults accounts. Name it "keyvaults.txt" and place it in C:\ drive. You can obtain these by running the "list-all-resources.ps1" script in this repo.
#  
# To run, after preparations indicated above, open a powershell window and use the Connect-AzAccount command to connect to Azure and execute this script.
##########################

# add file locations here
$keyvaults = Get-Content -Path "./keyvaults.txt"
$keyvaultsoutput = ".\all-keyvaults_diagnosticsettings.csv"


#multiple loops to prevent locking csv output files

ForEach ($kvobj in $keyvaults) {
Get-AzDiagnosticSetting -ResourceId "$kvobj" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$kvobj}}, Name, StorageAccountId, WorkspaceId | Export-Csv -Path $keyvaultsoutput -NoTypeInformation -Append -Force
}
