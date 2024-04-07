Connect-AzureAD

# Setup and diagnostic
$PSVersionTable
Import-Module -Name AzureAD -UseWindowsPowerShell
Import-Module -Name AzureAD -SkipEditionCheck


# Assign SPN to Azure AD security group 
$spn = Get-AzureADServicePrincipal -SearchString "BIA EUC VSTS SPN"
$group = Get-AzureADGroup -SearchString "ORG-EMEA-BI-DEVELOPMENT"
$group_nsr = Get-AzureADGroup -SearchString "SEC-IDM-NSR-DA-EMEA"
Add-AzureADGroupMember -ObjectId $($group.ObjectId) -RefObjectId $($spn.ObjectId)

# Get other objects
$group = Get-AzureADGroup -SearchString "ORG-EMEA-BI-DATA-SCIENCE"
$group = Get-AzureADGroup -SearchString "SEC-IDM-BIA-ECM-APAC-CH-TEST"
$user = Get-AzureADUser -SearchString 8d8f17ab-7a04-4422-a0d3-1b2269e3f439


# Assign SPN to Azure AD security group - ver.2
$group = Get-AzureADGroup -SearchString "SEC-IDM-NSR-DA-EMEA"
$svcprincipal = Get-AzureADServicePrincipal -All $true | ? { $_.DisplayName -match "BIA EUC VSTS SPN" }
Add-AzureADGroupMember -ObjectId $group.ObjectId -RefObjectId $svcprincipal.ObjectId

# Check the members of an Azure AD group
Get-AzureADGroupMember -ObjectId $group.ObjectId

#Explore accounts
Import-Module Activedirectory
Get-ADUser -Filter 'Name -like "*X38277*"' 
