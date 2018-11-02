$varMailbox = (
Get-MailboxStatistics -Server $env:COMPUTERNAME | ? {$_.DisplayName -notlike "Health*" -and $_.DisplayName -notlike "Personal Archive*" -and $_.DisplayName -notlike "System*" -and $_.DisplayName -notlike "Microsoft*" -and $_.DisplayName -notlike "Discovery*" -and $_.Database -notlike "Mailbox*" }
)
Remove-Item c:\scripts\exch.mailbox.log -Force -ErrorAction SilentlyContinue
foreach ($Box in $varMailbox) 
 {
  $Mailbox = $Box.DisplayName.Replace(' ','_').Replace('æ','ae').Replace('ø','oe').Replace('å', 'aa').Replace('ä','a').Replace('ö','o').replace('Ö','O')
  $MailboxTotalItemSize = $Box.TotalItemSize.Value.ToMB()
   Write-Output $("0 exch.mb.$($Box.Database).$($Mailbox) ItemCount=$($Box.ItemCount)|DeletedItemCount=$($Box.DeletedItemCount)|TotalItemSize=$($MailboxTotalItemSize);10000;20000 LastLogonTime: $($Box.LastLogonTime) ") | Out-File c:\scripts\exch.mailbox.log -Append
}
