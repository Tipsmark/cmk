# cmk
Check_MK scripts

Just a bunch of shell/batch/powershell scripts to add a few relevant checks to check_mk monitoring

* cmk_shares
Displays shared folders on Windows machines

* exch_mailbox.ps1 and cmk_mailbox.ps1
Suggest you run exch_mailbox.ps1 via a scheduled task every 15 or 30 minutes, then place cmk_mailbox.ps1 in the local folder to have fast execution of the check agent.

