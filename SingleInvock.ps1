Param (
    [Parameter(Mandatory=$true)][string]$drive
)
$driveLetter = $drive
$drive = ([wmi]"Win32_LogicalDisk='$drive'")

# Execute process if drive matches specified condition(s)
if ( [string]::IsNullOrEmpty($drive.VolumeName) -Or $drive.VolumeName -eq 'Galliance' )
{
    Get-ChildItem "$($PSScriptRoot)/Scripts" -Filter *.ps1 | Sort-Object |
    Foreach-Object {
        $arguments = "-file", $_.FullName, "-drive", $driveLetter
        # Give a posibility to stop it
        Write-Host (get-date -format s) " Starting task $($_) in 1 seconds..."
        Start-Sleep -seconds 1
        # Lauch after
        Start-Process -Wait -NoNewWindow powershell.exe -ArgumentList $arguments
    }
}
