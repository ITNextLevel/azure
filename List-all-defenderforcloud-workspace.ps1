#######################
# Checks all subscriptions you have access to and output the current defender for cloud workspace config
# author: Samuel Soto
# version: 0.1
#
# Preparation: None needed.
# To run, open a powershell window and use the Connect-AzAccount command to connect to Azure and execute this script.
###########################

$resources = @()
Get-AzSubscription | ForEach-Object {
    $_ | Set-AzContext
    $subscriptionName = $_.Name
    $subscriptionId = $_.SubscriptionId
    Get-AzSecurityWorkspaceSetting | ForEach-Object {
        $resources += [PSCustomObject]@{
            SubscriptionName  = $subscriptionName
            SubscriptionId    = $subscriptionId
            ResourceId        = $_.Id
            Name              = $_.Name
            WorkspaceUsed    = $_.WorkspaceId
        }
        
    }
}
$resources | Export-csv ".\DefenderForCloud_Workspace_config.csv"