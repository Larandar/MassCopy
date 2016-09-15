#Requires -version 3.0
Register-WmiEvent -Class win32_VolumeChangeEvent -SourceIdentifier volumeChange
write-host (get-date -format s) " Beginning script..."
do{
    $newEvent = Wait-Event -SourceIdentifier volumeChange
    $eventType = $newEvent.SourceEventArgs.NewEvent.EventType
    $eventTypeName = Switch($eventType)
    {
        1 {"Configuration changed"}
        2 {"Device arrival"}
        3 {"Device removal"}
        4 {"Docking"}
    }
    Write-Host (Get-Date -format s) " Event detected = " $eventTypeName
    if ($eventType -eq 2)
    {
        $driveLetter  = $newEvent.SourceEventArgs.NewEvent.DriveName
        $argumentList = "-nologo", "-noprofile", "-executionpolicy", "bypass", "-file", "$($PSScriptRoot)\SingleInvock.ps1","-drive", "$($driveLetter)"
        Start-Process powershell.exe -ArgumentList $argumentList
    }
    Remove-Event -SourceIdentifier volumeChange
} While ( 1 -eq 1 ) #Loop until next event
Unregister-Event -SourceIdentifier volumeChange
