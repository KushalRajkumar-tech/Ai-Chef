@echo off
title AiChef - Flutter Mobile App
echo ===================================================
echo     Launching AiChef Flutter Application...
echo ===================================================
echo.
cd /d "c:\Kushal\AI projects\chef"
start http://localhost:8080
python -m http.server 8080 --directory "c:\Kushal\AI projects\chef\flutter_app\build\web"
pause
