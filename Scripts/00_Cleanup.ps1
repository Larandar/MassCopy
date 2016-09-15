Param (
    [Parameter(Mandatory=$true)][string]$drive
)
$driveLetter = $drive
$drive = ([wmi]"Win32_LogicalDisk='$drive'")

Get-ChildItem -Path $driveLetter -Include *.* -File -Recurse | foreach { $_.Delete()}

Write-Host "Drive cleaned"
