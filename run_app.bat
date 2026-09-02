@echo off
title AI Chef Mobile App Launcher
echo ===================================================
echo           Starting AI Chef Mobile Web App           
echo ===================================================
echo.
echo Opening app in your default browser...
start http://localhost:3000/index.html
echo Starting Python local web server on port 3000...
echo (Keep this window open while using the app)
echo.
python -m http.server 3000
pause
