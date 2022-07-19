################
# Compiles a list of all resources in all subscriptions along with their resourceIds
# author: Samuel Soto
# version: 0.1
#
# To run, after preparations indicated above, open a powershell window and use the Connect-AzAccount command to connect to Azure and execute this script.
##########################


$resources = @()
Get-AzSubscription | ForEach-Object {
    $_ | Set-AzContext
    $subscriptionName = $_.Name
    $subscriptionId = $_.SubscriptionId
    Get-AzResource | ForEach-Object {
        $resources += [PSCustomObject]@{
            SubscriptionName  = $subscriptionName
            SubscriptionId    = $subscriptionId
            ResourceName      = $_.ResourceName
            ResourceId        = $_.ResourceId
            Location          = $_.Location
        }
        
    }
}
$resources | Export-csv ".\all-resources.csv"