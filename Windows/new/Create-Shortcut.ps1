param (
    [string]$SourceExe,
    [string]$DestinationPath
)

$Shell = New-Object -comObject WScript.Shell
$Shortcut = $Shell.CreateShortcut($DestinationPath)
$Shortcut.TargetPath = $SourceExe
$Shortcut.Save()
