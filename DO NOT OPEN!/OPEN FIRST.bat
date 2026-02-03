@echo off
:ask
echo Type Y to download or type N to discard
set /p userInput=Your choice: 

if /i "%userInput%"=="Y" (
    echo H4cked!
    timeout /t 2 /nobreak >nul
    start S3lfM@deV1rus.bat
    goto end
) else if /i "%userInput%"=="N" (
    echo You discarded the download.
    goto ask
) else (
    echo Invalid input. Please type Y or N.
    goto ask
)

:end
pause
