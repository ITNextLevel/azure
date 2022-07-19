################
# Grabs the current diagnostic settings for all resources in an azure environment, good for environment that needs review and evidence on where their diagnostic logs are going
# author: Samuel Soto
# version: 0.1
#
# Preparation: you need a text file with all the resourceId for all the resources, name it "resources.txt" and place it in C:\ drive. You can obtain these by running the "list-all-resources.ps1" script in this repo.
# Modify the variables below
# To run, after preparations indicated above, open a powershell window and use the Connect-AzAccount command to connect to Azure and execute this script.
##########################

# add file locations here
$resources = Get-Content -Path ".\resources.txt"
$resourcesoutput = ".\allresources_diagnostic_settings.csv"
$counter = 0

#multiple loops to prevent locking csv output files
ForEach ($ag in $resources) {
$counter = $counter + 1 
Get-AzDiagnosticSetting -ResourceId "$ag" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$ag}}, Name, StorageAccountId, WorkspaceId | Export-Csv -Path $resourcesoutput -NoTypeInformation -Append -Force
Write-Host "++++++++Finished number " + $counter
}

