# SharePoint-Online-PowerShell---A-Beginners-Guide
Presentation and PowerShell script samples to allow you to easily get started with configuring SharePoint Online using PowerShell.

The presentation covers:
* Background - why we'd want to automate using PowerShell
* Options and required components - the various options that can be used and how to get them installed
* Getting connected - requried steps for any of the options to get connected to the remote system
* Sample scripts:
  * Site collection creation
  * Term set creation
  * Feature activation
  * Document library creation
  * List/library deletion

The sample scripts are:
* 01 - New-SiteCollectionDemo.ps1
* 02 - New-TermGroupSetandTerm.ps1
* 03 - Activate-FeatureDemo.ps1
* 04 - New-DocumentLibraryDemo.ps1
* 05 - Delete-ListDemo.ps1

Each script will need to be modified to match your specific environment (SharePoint Online URL, suitable user account etc.) but otherwise should beimmediately useable to achieve the basic operations outlined above.
Each script also provides the options (where available) to achieve the operation for each of SharePoint Online Management Shell, PnP PowerShell and CSOM PowerShell.
