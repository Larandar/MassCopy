Param (
    [Parameter(Mandatory=$true)][string]$drive
)
$driveLetter = $drive
$drive = Get-WmiObject "Win32_LogicalDisk WHERE DeviceID='$driveLetter'"

Set-Volume -DriveLetter $driveLetter[0] -NewFileSystemLabel "Galliance"
Write-Host "Device renamed"
