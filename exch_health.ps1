$varMailboxDatabase=@(Get-MailboxDatabaseCopyStatus -Server $env:COMPUTERNAME | Select-Object DatabaseName,Status,ContentIndexState)
Remove-Item c:\scripts\exch.health.log -Force
foreach ($database in $varMailboxDatabase)
 {
 IF ($database.Status -like "Mounted" -or $database.Status -like "Healthy" -and $database.ContentIndexState -like "Healthy")
  {
   $dbname=$database.DatabaseName.Replace(' ','_')
   $varStatus = 0
   Write-Output $("$($varStatus) exch.database.$($dbname) - Database: $($database.DatabaseName) Status: $($database.Status) Search Index: $($database.ContentIndexState)") | Out-File c:\scripts\exch.health.log -Append
   }
   ELSE
   {
   $dbname=$database.DatabaseName.Replace(' ','_')
   $varStatus = 2
   $("$($varStatus) exch.database.$($dbname) - Database: $($database.DatabaseName) Status: $($database.Status) Search Index: $($database.ContentIndexState)") | Out-File c:\scripts\exch.health.log -Append
  }
 }

$varComponentState=@(Get-ServerComponentstate -Identity $env:COMPUTERNAME)
foreach ($Component in $varComponentState)
 {
  IF ($Component.State -like "Active")
   {
    $varStatus = 0
    Write-Output $("$($varStatus) exch.health.$($Component.Component) - Component: $($Component.Component) is $($Component.State)") | Out-File c:\scripts\exch.health.log -Append
	}
	ELSE
	{
	$varStatus = 2
	Write-Output $("$($varStatus) exch.health.$($Component.Component) - Component: $($Component.Component) is $($Component.State)") | Out-File c:\scripts\exch.health.log -Append
  }
 }
