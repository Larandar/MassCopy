Param (
    [Parameter(Mandatory=$true)][string]$drive
)
$driveLetter = $drive
$drive  = ([wmi]"Win32_LogicalDisk='$drive'")
$source = "$($PSScriptRoot)\..\Copy"

Copy-Item "$($PSScriptRoot)\..\Copy\*" $driveLetter

Write-Host "Files copied"
