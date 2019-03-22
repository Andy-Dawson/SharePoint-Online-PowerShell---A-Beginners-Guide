#SharePoint Online Management Shell
# not supported



#SharePoint PnP PowerShell
Connect-PnPOnline -Url https://mydomain.sharepoint.com
New-PnPTermGroup -GroupName "Corporate Terms"
New-PnPTermSet -Name "Departments" -TermGroup "Corporate Terms" -Lcid 1033
New-PnPTerm -TermSet "Departments" -TermGroup "Corporate Terms" -Name "Finance" -Lcid 1033
New-PnPTerm -TermSet "Departments" -TermGroup "Corporate Terms" -Name "HR" -Lcid 1033

# Note that we can specify the GUID IDs if required (which can sometimes be very helpful!)



# CSOM PowerShell
# This assumes a central installation; modify path to match your environment
Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.8523.1200\lib\net45\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.8523.1200\lib\net45\Microsoft.SharePoint.Client.Runtime.dll"
Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.8523.1200\lib\net45\Microsoft.SharePoint.Client.Taxonomy.dll"

$sitename = "https://mydomain.sharepoint.com"
$user = "adminuser@mydomain.onmicrosoft.com"
$Password = Read-Host -Prompt "Please enter your password" -AsSecureString

#Bind to MMS
$session = New-Object Microsoft.SharePoint.Client.ClientContext($sitename)
$Creds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($User,$Password)
$session.Credentials = $Creds
$MMS = [Microsoft.SharePoint.Client.Taxonomy.TaxonomySession]::GetTaxonomySession($session)
$session.Load($MMS)
$session.ExecuteQuery()

#Retrieve Term Stores
$termStores = $MMS.TermStores
$session.Load($termStores)
$session.ExecuteQuery()

#Bind to Term Store
$termStore = $termStores[0]
$session.Load($termStore)
$session.ExecuteQuery()

$group = $termStore.CreateGroup("Corporate",[System.Guid]::NewGuid().toString())
$session.Load($group)
$session.ExecuteQuery()

#Set Group description
Write-Host "  Setting description for TermGroup Corporate"
$group.description = "Term Group Description"
$session.Load($group)
$session.ExecuteQuery()

# Pause here for a few seconds to allow things to catch up...
Write-Host "  Pausing to allow the system to catch up..." -ForegroundColor DarkGreen
Start-Sleep 10

#Create TermSet
Write-Host "  Creating TermSet Depts"
$termSet = $group.CreateTermSet("Depts",[System.Guid]::NewGuid().toString(),1033)
$session.Load($TermSet)
$session.ExecuteQuery()

#Set TermSet Properties
Write-Host "  Setting properties for TermSet Depts"
$termSet.Description = "Term Set Description"
$termSet.IsAvailableForTagging = $true
$termSet.IsOpenForTermCreation = $true
$session.Load($termSet)
$session.ExecuteQuery()
            
# Pause here for a few seconds to allow things to catch up...
Write-Host "  Pausing to allow the system to catch up..." -ForegroundColor DarkGreen
Start-Sleep 10

#Create Appropriate terms
Write-Host "  Creating 'IT' term"
$session.Load($termSet)
$NewTerm = $termSet.CreateTerm("IT", 1033, [System.Guid]::NewGuid().toString())
$session.Load($NewTerm)
$session.ExecuteQuery()

Write-Host "  Creating 'Sales' term"
$session.Load($termSet)
$NewTerm = $termSet.CreateTerm("Sales", 1033, [System.Guid]::NewGuid().toString())
$session.Load($NewTerm)
$session.ExecuteQuery()
