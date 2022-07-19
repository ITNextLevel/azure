################
# Grabs the current diagnostic settings for all container node pool resources in an environment, good for environment that needs review and evidence and has hundreds of container node pools
# author: Samuel Soto
# version: 0.1
#
# Preparation: you need a text file with all the resourceId for all the container node pool resources.  Name it "containernodepools.txt" and place it in C:\ drive. You can obtain these by running the "list-all-resources.ps1" script in this repo.
# Modify the variables below
# To run, after preparations indicated above, open a powershell window and use the Connect-AzAccount command to connect to Azure and execute this script.
##########################

# add file locations here
$containers = Get-Content -Path ".\containernodepools.txt"
$containersoutput = ".\allcontainernodepools.txt_diagnosticsettings.csv"


#multiple loops to prevent locking csv output files

ForEach ($cnp in $containers) {
Get-AzDiagnosticSetting -ResourceId "$cnp" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$cnp}}, Name, StorageAccountId, WorkspaceId | Export-Csv -Path $containersoutput -NoTypeInformation -Append -Force
}

