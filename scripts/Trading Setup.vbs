Dim oShell, oVoice, scriptDir
Set oShell = CreateObject("WScript.Shell")
Set oVoice = CreateObject("SAPI.SpVoice")
scriptDir = Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\"))

' 0. Voice greeting
oVoice.Speak "Good morning. Starting your trading session."

' 1. Launch TradingView with CDP (hidden PS window, wait for it to finish activating)
oShell.Run "powershell -NoProfile -ExecutionPolicy Bypass -File """ & scriptDir & "launch_tv_debug.ps1""", 0, True

' 2. Start Claude Bot Dashboard server in background (hidden, from bot directory)
oShell.Run "cmd /c cd /d ""C:\Users\ricke\claude-tradingview-mcp-trading"" && node dashboard.js > nul 2>&1", 0, False

' 3. Give server 2.5 seconds to bind port 3333
WScript.Sleep 2500

' 4. Open Claude Bot Dashboard in default browser
oShell.Run "http://localhost:3333"

' 5. Open Railway logs in a new browser tab (short delay so tabs open in order)
WScript.Sleep 500
oShell.Run "https://railway.com/project/7c96f024-ef3a-4d2f-9afa-2d3d5cd9c67f/service/9a79abf1-7b9f-490b-be43-cee90b20e586"

' 6. Launch Hermes (gateway check + chat window)
WScript.Sleep 500
oShell.Run "wscript.exe ""C:\Users\ricke\AppData\Local\hermes\start_hermes.vbs""", 0, False

' 7. Open Claude Code in a cmd window in the MCP project directory
WScript.Sleep 500
oShell.Run "cmd /k ""cd /d C:\Users\ricke\tradingview-mcp-jackson && claude""", 1, False

' 8. Schedule Win+H via Task Scheduler — interactive user session has full UI rights
WScript.Sleep 1000
Dim psFile
psFile = scriptDir & "voice_typing.ps1"
oShell.Run "schtasks /create /tn ""WinHVoiceOnce"" /tr ""powershell -NoProfile -ExecutionPolicy Bypass -File '" & psFile & "'"" /sc once /st " & Format(Now + TimeSerial(0,0,20), "HH:mm:ss") & " /f", 0, True

' 9. Voice confirmation once everything is up
WScript.Sleep 2000
oVoice.Speak "Trading setup complete. Good luck today."
