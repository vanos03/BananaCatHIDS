set WORKDIR=%appdata%\test
mkdir "%WORKDIR%"
powershell Start-Process "%WORKDIR%\add_task.ps1" -Verb RunAs -WindowStyle Hidden