@echo off

sc config w32time start= auto

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters" /v NtpServer /d "192.168.0.103" /f

net stop w32time
net start w32time

w32tm /resync

pause