################
# Grabs the current location for a list of resourceids
# author: Samuel Soto
# version: 0.1
#
# Preparation: you need a text file with all the resourceId for all resources to query. name it "resources.txt" and place it in C:\ drive. You can obtain these by running the "list-all-resources.ps1" script in this repo.
# Modify the variables below
#
# To run, after preparations indicated above, open a powershell window and use the Connect-AzAccount command to connect to Azure and execute this script.
##########################

# add file locations here
$resources = Get-Content -Path ".\resources.txt"
$locationoutput = ".\resources-location.csv"


#multiple loops to prevent locking csv output files
$counter = 0
ForEach ($id in $resources) {
$counter = $counter + 1
Write-Host "Running number " + $counter
Get-AzResource -ResourceId "$id" | Select-Object -Property @{Name = 'ResourceId'; Expression = {$id}}, ResourceType, Location | Export-Csv -Path $locationoutput -NoTypeInformation -Append -Force
}

