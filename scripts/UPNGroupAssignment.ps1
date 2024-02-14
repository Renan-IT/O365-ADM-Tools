<# 
.SYNOPSIS
This PowerShell script automates the process of adding users to a specified group based on their UserPrincipalName (UPNs).

.DESCRIPTION
    This PowerShell script automates the process of adding users to a specified group
    by retrieving their Active Directory (AD) accounts using their UPNs.

.NOTES
    Prerequisite   : Active Directory module must be installed.
    
#>

# Define a variable for the group name
$group = "YourGroupName"

# Define an array of user email addresses
$users = "YourUser1@example.com","YourUser2@example.com"

# Loop through each user in the array
foreach ($user in $users){
  # Get the account name of the user based on the email address
  $account = Get-ADUser -Filter {UserPrincipalName -eq $user} | Select-Object -ExpandProperty SamAccountName
  # Add the user to the group
  Add-ADGroupMember -Identity $group -Members $account
}
