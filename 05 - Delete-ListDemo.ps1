# SharePoint Online Management Shell
# Not supported



# SharePoint PnP PowerShell
Connect-PnPOnline -Url https://mydomain.sharepoint.com/sites/Test
Remove-PnPList -Identity "Finance Documents" -Force -Recycle



# CSOM PowerShell
$SiteUrl = "https://mydomain.sharepoint.com/sites/Test"  
$UserName = "adminuser@mydomain.onmicrosoft.com"  
# Ask the user for the password
$Password = Read-Host -Prompt "Enter your password: " -AsSecureString

Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.8523.1200\lib\net45\Microsoft.SharePoint.Client.dll" 
Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.8523.1200\lib\net45\Microsoft.SharePoint.Client.Runtime.dll" 
Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.8523.1200\lib\net45\Microsoft.SharePoint.Client.Publishing.dll"

$spoCtx = New-Object Microsoft.SharePoint.Client.ClientContext($SiteUrl)  
$spoCredentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Username, $Password)   
$spoCtx.Credentials = $spoCredentials

$list = $spoCtx.Web.Lists.GetByTitle('Finance Documents')
$spoCtx.Load($list)
$spoCtx.ExecuteQuery()

$list.DeleteObject() 
# Really removes it (no recycle bin)
$spoCtx.ExecuteQuery()
