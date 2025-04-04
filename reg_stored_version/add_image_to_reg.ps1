$ImagePath = "C:\path\image.jpg"
$ImageName = "ТЕСТ"
$RegPath   = "HKCU:\Software\MyApp"

$bytes = [System.IO.File]::ReadAllBytes($ImagePath)

New-Item -Path $RegPath -Force | Out-Null
Set-ItemProperty -Path $RegPath -Name $ImageName -Value $bytes
