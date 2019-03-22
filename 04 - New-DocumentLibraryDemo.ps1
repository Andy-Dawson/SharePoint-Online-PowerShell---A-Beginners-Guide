# SharePoint Online Management Shell
# Not supported



# SharePoint PnP PowerShell
Connect-PnPOnline -Url https://mydomain.sharepoint.com/sites/Test
New-PnPList -Title "Finance Documents" -Template DocumentLibrary -EnableVersioning -OnQuickLaunch 



# CSOM PowerShell
$SiteUrl = "https://mydomain.sharepoint.com/sites/Test"  
$UserName = "adminuser@mydomain.onmicrosoft.com"  
# Ask the user for the password
$Password = Read-Host -Prompt "Enter your password: " -AsSecureString
$listTitle = "Finance Documents"
$listDescription = "Finance documents"
$listTemplate = 101 #DocuentLibrary

Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.8523.1200\lib\net45\Microsoft.SharePoint.Client.dll" 
Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.8523.1200\lib\net45\Microsoft.SharePoint.Client.Runtime.dll" 

$spoCtx = New-Object Microsoft.SharePoint.Client.ClientContext($SiteUrl)  
$spoCredentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Username, $Password)   
$spoCtx.Credentials = $spoCredentials

#create list using ListCreationInformation object (lci)
$lci = New-Object Microsoft.SharePoint.Client.ListCreationInformation
$lci.title = $listTitle
$lci.description = $listDescription
$lci.TemplateType = $listTemplate

$spoCtx.web.lists.add($lci)
$spoCtx.executeQuery()
