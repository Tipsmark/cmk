Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn;
$varMailboxDatabase=@(Get-MailboxDatabaseCopyStatus -Server $env:COMPUTERNAME | Select-Object DatabaseName,Status,ContentIndexState)
foreach ($database in $varMailboxDatabase)
 {
 IF ($database.Status -like "Mounted" -or $database.Status -like "Healthy" -and $database.ContentIndexState -like "Healthy")
  {
   $dbname=$database.DatabaseName.Replace(' ','_')
   $varStatus = 0
   Write-Output $("$($varStatus) exch.database.$($dbname) - Database: $($database.DatabaseName) Status: $($database.Status) Search Index: $($database.ContentIndexState)")
   }
   ELSE
   {
   $dbname=$database.DatabaseName.Replace(' ','_')
   $varStatus = 2
   $("$($varStatus) exch.database.$($dbname) - Database: $($database.DatabaseName) Status: $($database.Status) Search Index: $($database.ContentIndexState)")
  }
 }

$varComponentState=@(Get-ServerComponentstate -Identity $env:COMPUTERNAME)
foreach ($Component in $varComponentState)
 {
  IF ($Component.State -like "Active")
   {
    $varStatus = 0
    Write-Output $("$($varStatus) exch.health.$($Component.Component) - Component: $($Component.Component) is $($Component.State)")
	}
	ELSE
	{
	$varStatus = 2
	Write-Output $("$($varStatus) exch.health.$($Component.Component) - Component: $($Component.Component) is $($Component.State)")
  }
 }
