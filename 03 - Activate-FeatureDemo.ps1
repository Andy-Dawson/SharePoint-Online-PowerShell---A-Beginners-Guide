# SharePoint Online Management Shell
# Not supported



# SharePoint PnP PowerShell
Connect-PnPOnline -Url https://mydomain.sharepoint.com/sites/Test2
Enable-PnPFeature -Identity f6924d36-2fa8-4f0b-b16d-06b7250180fa -Scope Site
# Careful of scope here!



# CSOM PowerShell
$sSiteColUrl = "https://mydomain.sharepoint.com/sites/Test3"  
$sUserName = "adminuser@mydomain.onmicrosoft.com"  
$sFeatureGuid= "f6924d36-2fa8-4f0b-b16d-06b7250180fa" 
$sPassword = Read-Host -Prompt "Enter your password: " -AsSecureString

# This assumes a central installation; modify path to match your environment
Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.8523.1200\lib\net45\Microsoft.SharePoint.Client.dll" 
Add-Type -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.SharePointOnline.CSOM.16.1.8523.1200\lib\net45\Microsoft.SharePoint.Client.Runtime.dll" 

#SPO Client Object Model Context 
$spoCtx = New-Object Microsoft.SharePoint.Client.ClientContext($sSiteColUrl)  
$spoCredentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($sUsername, $sPassword)   
$spoCtx.Credentials = $spoCredentials       
 
# The following disables the timeout so that the feature activation doesnt fail
$spoCtx.RequestTimeout = -1
$spoCtx.ExecuteQuery() 

$guiFeatureGuid = [System.Guid] $sFeatureGuid 
$spoSite=$spoCtx.Site 
$spoSite.Features.Add($sFeatureGuid, $true, [Microsoft.SharePoint.Client.FeatureDefinitionScope]::None) 
$spoCtx.ExecuteQuery() 
