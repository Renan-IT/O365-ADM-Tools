# PowerShell script to list the Azure AD groups that a user owns

# Set the variable $ownerupn with the owner user principal name
$ownerupn= "owneruserprincipalname"

# Get all the IDs of the Azure AD groups and store them in the variable $groupid
$groupid=(Get-AzADGroup).Id

# Loop through each group ID in the $groupid variable
foreach ($group in $groupid){
  # Get the owner of the group with the given ID and check if it matches the $ownerupn variable
  $eq=Get-AzureADGroupOwner -ObjectId $group | where UserPrincipalName -eq $owerupn
  # If there is a match, print the group ID
  if ($eq) {Write-Host $group}
}
