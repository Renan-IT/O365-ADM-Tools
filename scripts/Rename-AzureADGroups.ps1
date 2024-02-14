<#
.SYNOPSIS
    Rename Azure AD Groups from a CSV File.

.DESCRIPTION
    This PowerShell script automates the process of renaming Azure Active Directory (AD) groups based on information provided in a CSV file.
    The CSV file should have columns "name" (current group name) and "new" (desired new name).

.NOTES
    Prerequisite   : Azure PowerShell module must be installed.

.PARAMETER csvFilePath
    Specifies the path to the CSV file containing group name mappings.

.EXAMPLE
    .\Rename-AzureADGroups.ps1 -csvFilePath 'C:\path\to\your\csvfile.csv'

#>

param (
    [string]$csvFilePath
)

# Import data from the CSV file into a variable
# Ensure that the CSV file contains columns "name" (current group name) and "new" (desired new name)
$csvData = Import-Csv -Path $csvFilePath -Delimiter ';'

# Iterate through each row in the variable
$csvData | ForEach-Object {
    # Get the current group object using the group name
    $group = Get-AzADGroup -DisplayName $_.name

    # Rename the group using the desired new name
    Update-AzADGroup -ObjectId $group.Id -DisplayName $_.new
}
