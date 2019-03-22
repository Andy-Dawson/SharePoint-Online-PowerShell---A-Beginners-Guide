# SharePoint Online Management Shell
Connect-SPOService -Url https://mydomain-admin.sharepoint.com -credential adminuser@mydomain.onmicrosoft.com 
New-SPOSite -Url https://mydomain.sharepoint.com/sites/Test2 -Owner adminuser@mydomain.onmicrosoft.com -StorageQuota 1000 -Title "Test Site Collection" -Template STS#0
# May need to remove old site collections from the recycle bin
#Remove-SPODeletedSite https://mydomain.sharepoint.com/sites/<site>
# Be patient when deleting site collections - it takes time to process



# SharePoint PnP PowerShell
Connect-PnPOnline -Url https://mydomain.sharepoint.com
New-PnPTenantSite -Url https://mydomain.sharepoint.com/sites/Test -Owner adminuser@mydomain.onmicrosoft.com -TimeZone 2 -Title "Test Site Collection" -Template STS#0 -StorageQuota 1000
# Use Get-PnPTimeZone to retrieve tinezone IDs
# Limited list of Lcids allowed at site creation time - see https://msdn.microsoft.com/en-us/library/microsoft.sharepoint.splanguage.lcid.aspx for the list of supported values



# CSOM PowerShell
# This assumes a central installation; modify path to match your environment
Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.8523.1200\lib\net45\Microsoft.SharePoint.Client.dll" 
Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.8523.1200\lib\net45\Microsoft.Online.SharePoint.Client.Tenant.dll"
 
#URLs and prerequisites
$adminSiteUrl = "https://mydomain-admin.sharepoint.com"
$newsiteUrl = "https://mydomain.sharepoint.com/sites/Test"
$username = "adminuser@mydomain.onmicrosoft.com"
$password = Read-Host "Please enter your Password" -AsSecureString
 
Write-Host "Establishing Connection to Office 365."
#Get the context and feed in the credentials
$ctx = New-Object Microsoft.SharePoint.Client.ClientContext($adminSiteUrl) 
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $password)  
$ctx.Credentials = $credentials

Write-Host "Now configuring the new Site Collection"
 
#Get the tenant object
$tenant = New-Object Microsoft.Online.SharePoint.TenantAdministration.Tenant($ctx)
 
#Set the Site Creation Properties values
$SCproperties = New-Object Microsoft.Online.SharePoint.TenantAdministration.SiteCreationProperties
$SCproperties.Url = $newsiteUrl
$SCproperties.Template =  "STS#0"
$SCproperties.Owner = $username
$SCproperties.StorageMaximumLevel = 1000
$SCproperties.UserCodeMaximumLevel = 0
$SCproperties.Title = "Test"
#$SCproperties.TimeZoneId = 1200 # This is for GMT - See https://msdn.microsoft.com/en-us/library/gg154758.aspx for a list of IDs.
# Other items we can specify here are available at https://msdn.microsoft.com/en-us/library/office/microsoft.online.sharepoint.tenantadministration.sitecreationproperties_members.aspx
 
#Create the site using the properties
#$tenant.CreateSite($SCproperties) | Out-Null
$tenant.CreateSite($SCproperties)

Write-Host "Creating site collection"

$ctx.ExecuteQuery()
