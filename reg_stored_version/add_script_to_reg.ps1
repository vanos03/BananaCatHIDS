$script = @'

$PrinterName = (Get-WmiObject -Query "SELECT * FROM Win32_Printer WHERE Default = TRUE").Name

if (-not $PrinterName) {
    exit 1
}
Get-Printer | ForEach-Object { Get-PrintJob -PrinterName $_.Name | Remove-PrintJob -Confirm:$false }
$ImagePath = "cat.jpg"

if (-Not (Test-Path $ImagePath)) {
    exit 1
}

Start-Process -FilePath "mspaint.exe" -ArgumentList "/pt `"$ImagePath`" `"$PrinterName`"" -NoNewWindow -Wait
'@

$script_name = "BananaCat"
$reg_path = "HKCU:\Software\$script_name"

New-Item -Path $reg_path -Force | Out-Null
Set-ItemProperty -Path $reg_path -Name $script_name -Value $script