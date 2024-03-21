$scriptPath = "$env:USERPROFILE\cmslogin.ps1"
$startupFolderPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$shortcutPath = Join-Path -Path $startupFolderPath -ChildPath "RunLoginScript.lnk"

# Create a shortcut object
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = "powershell.exe"
$shortcut.Arguments = "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$scriptPath`""
$shortcut.WorkingDirectory = $scriptPath | Split-Path
$shortcut.Save()

# Verify that the shortcut was created successfully
if (Test-Path $shortcutPath) {
    Write-Host "Shortcut created successfully in the Startup folder to run the login script at startup."
} else {
    Write-Host "Failed to create the shortcut."
}
