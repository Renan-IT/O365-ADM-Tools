<# 
Synopsis:
This PowerShell script automates the process of adding users to a specified group based on their email addresses.

Description:
The script accomplishes the following steps:

1. Group Name Definition:
   - A variable named $group is defined to store the name of the target group. Replace "YourGroupName" with the actual name of the group you want to add users to.

2. User Email Addresses:
   - An array named $users is created to hold user email addresses. You can modify this array by adding or removing email addresses as needed.
   - For example, the current array contains two sample email addresses: "YourUser1@example.com" and "YourUser2@example.com".

3. User Addition Loop:
   - The script iterates through each user in the $users array.
   - For each user, it performs the following actions:
     - Retrieves the corresponding Active Directory (AD) account name based on the email address using the Get-ADUser cmdlet.
     - Adds the user to the specified group using the Add-ADGroupMember cmdlet.

Remember to customize the group name and user email addresses according to your specific requirements. Once you've made the necessary adjustments, you can execute the script to efficiently manage group memberships based on email addresses. 🚀
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
