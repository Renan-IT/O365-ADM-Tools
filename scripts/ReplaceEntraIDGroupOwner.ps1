<#
.SYNOPSIS
A script to replace the owner of Azure AD groups with a new owner.
.DESCRIPTION
This script gets the IDs of all the Azure AD groups and checks if they have a specific owner based on their email address. If they do, it adds a new owner to the group using their UPN and object ID.
.PARAMETER OwnerToReplace
The owner's email address that you want to replace.
.PARAMETER NewOwner
The new owner's email address that you want to add.
.EXAMPLE
.\ReplaceGroupOwner.ps1 -OwnerToReplace alice@example.com -NewOwner bob@example.com
This example replaces Alice with Bob as the owner of all the Azure AD groups that Alice owns.
#>
param (
  # The owner's email address that you want to replace
  [Parameter(Mandatory=$true)]
  [string]$OwnerToReplace,
  # The new owner's email address that you want to add
  [Parameter(Mandatory=$true)]
  [string]$NewOwner
)

# Get the IDs of all the Azure AD groups, using the -All parameter
$GroupID = (Get-AzADGroup -All).Id

# Loop through each group ID
foreach ($Group in $GroupID) {
  # Check if the owner's email address matches any of the existing group owners, using the -Filter parameter
  $Match = Get-AzureADGroupOwner -ObjectId $Group -Filter "UserPrincipalName eq '$OwnerToReplace'"
  # If there is a match, do the following
  if ($Match) {
    # Print the group ID to the console
    Write-Host $Group
    # Add the new owner as a group owner, using their UPN
    # Get the object ID of the new owner based on their UPN
    $NewOwnerID = Get-AzureADUser -Filter "UserPrincipalName eq '$NewOwner'" | select -ExpandProperty ObjectId
    # Define the parameters for the Add-AzureADGroupOwner cmdlet
    $Params = @{
      ObjectId = $Group
      RefObjectId = $NewOwnerID
    }
    # Add the new owner to the group using splatting
    Add-AzureADGroupOwner @Params
  }
}
