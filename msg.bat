@echo @echo off

set /p USERMSG=What would you like to send to this user? 

set DESKTOPNAME=%COMPUTERNAME%

REM PASTE YOUR NEW WEBHOOK URL BELOW
set WEBHOOK_URL=https://discord.com/api/webhooks/1469649800629715056/lL6Zxa9_ltH4TXvjc0Vk6OvWtd8HMhTjCEUnvcZ2DpYmI31NEKz8PcYg9cQTBvc5uD4G

curl -X POST -H "Content-Type: application/json" ^
-d "{\"content\":\"@everyone - %DESKTOPNAME% - HAS SAID '%USERMSG%'\"}" ^
%WEBHOOK_URL%

exit

