$lastUpdate = (gci c:\scripts\exch.mailbox.log -ErrorAction SilentlyContinue)
IF ($lastUpdate.CreationTime -gt $(Get-Date).AddMinutes(-22))
 {
  Get-Content -Path $lastUpdate.FullName
  }
  ELSE
  {
  Get-Content -Path $lastUpdate.FullName | ForEach-Object { $_ -Replace '^0', '1'}
 }
