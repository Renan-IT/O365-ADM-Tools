<#
.SYNOPSIS
    Configure Telephony Settings for a User in Microsoft Teams.

.DESCRIPTION
    This PowerShell script automates the process of configuring telephony settings for a user in Microsoft Teams.
    It assigns a direct phone number, enables Enterprise Voice, and assigns calling policies.

.NOTES
    Prerequisite   : Microsoft Teams PowerShell module must be installed.

.PARAMETER upn
    Specifies the user's email address (User Principal Name).

.PARAMETER tenantDialPlan
    Specifies the name of the tenant dial plan.

.PARAMETER phoneNumber
    Specifies the direct phone number to assign to the user.

.EXAMPLE
    .\Configure-TeamsTelephony.ps1 -upn "user@example.com" -tenantDialPlan "MyTenantDialPlan" -phoneNumber "+1234567890"

#>

param (
    [string]$upn,
    [string]$tenantDialPlan,
    [string]$phoneNumber
)

# Assign the specified phone number to the user
$phoneNumberType = "DirectRouting"
Set-CsPhoneNumberAssignment -Identity $upn -PhoneNumber $phoneNumber -PhoneNumberType $phoneNumberType

# Enable Enterprise Voice for the user
Set-CsPhoneNumberAssignment -Identity $upn -EnterpriseVoiceEnabled $true

# Assign calling policies to the user
Grant-CsTeamsCallingPolicy -Identity $upn -PolicyName "AllowCalling"
Grant-CsTenantDialPlan -Identity $upn -PolicyName $tenantDialPlan
Grant-CsOnlineVoiceRoutingPolicy -Identity $upn -PolicyName "NoRestrictions"

# Option: Remove the phone number assignment (uncomment the line below if needed)
# Remove-CsPhoneNumberAssignment -Identity "UserObjectID" -RemoveAll
