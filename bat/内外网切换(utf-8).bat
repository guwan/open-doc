@echo off
:menu
cls
echo 请选择您要执行的操作：
echo [1] 连接WiFi
echo [2] 断开WiFi
set /p choice=选择操作：
if "%choice%"=="1" goto connect
if "%choice%"=="2" goto disconnect
echo 无效的选择，请重试。
pause
goto menu

:connect
netsh interface set interface "以太网" admin=disable
netsh wlan connect name="技术古玩的热点"
echo WiFi已连接。
goto menu

:disconnect
netsh wlan disconnect
netsh interface set interface "以太网" admin=enable
echo WiFi已断开。
goto menu

:end