$Action = New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -Argument "-File E:\Downloads\Проект_разгром\print_cat.ps1"
$Trigger = New-ScheduledTaskTrigger -Log "Microsoft-Windows-PrintService/Operational" -Id 307
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
Register-ScheduledTask -TaskName "PrintReplaceTask" -Action $Action -Trigger $Trigger -Settings $Settings -RunLevel Highest -Description "Replaces printed documents with a preset image"

pause