@echo off
set WEBHOOK_URL=https://discord.com/api/webhooks/1469367399944945917/ypyTYJh31Dtkj0WvYC-9Qm485JbS13JggRuy6pvbpj3U39tVjK7wXvbG-zoJoY_cAxC2

set DESKTOP_NAME=%COMPUTERNAME%

curl -H "Content-Type: application/json" ^
     -X POST ^
     -d "{\"content\":\"🖥️ **%DESKTOP_NAME%** has opened this file.\"}" ^
     %WEBHOOK_URL%
