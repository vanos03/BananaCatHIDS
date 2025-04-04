$ImagePath = "C:\path\image.jpg"
$ImageName = "ТЕСТ"
$RegPath   = "HKCU:\Software\MyApp"

$img = Get-ItemProperty -Path $RegPath -Name $ImageName

[System.IO.File]::WriteAllBytes($ImagePath, $img.$ImageName)
