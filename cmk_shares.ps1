Foreach ($Share in (Get-WmiObject -Class Win32_Share | Select Name, Path))
{ Write-Host 0 Share.$(($Share.Name).Replace(" ","_")) - $($Share.Path) shared as $($Share.Name) }
