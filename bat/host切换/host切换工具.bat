@echo off

setlocal enabledelayedexpansion

set BACKUP_DIR=%cd%
set HOST_ORIGINAL=%BACKUP_DIR%\hosts.原始.txt
set CHOICE=

REM 检查原始 host 文件是否存在，不存在则备份当前 host 文件并创建
if not exist "%HOST_ORIGINAL%" (
    echo 备份当前 host 文件为 hosts.原始.txt
    copy "%SYSTEMROOT%\System32\drivers\etc\hosts" "%HOST_ORIGINAL%" /Y
)

REM 获取备份文件列表
set /a i=0
for %%f in ("%BACKUP_DIR%\hosts.*.txt") do (
    set /a i+=1
    set HOST_BACKUP[!i!]=%%f
    echo [!i!] %%f
)

REM 提示用户选择备份文件
set /p CHOICE=请输入要切换的备份文件 [1-%i%]: 

REM 检查用户输入是否有效
if not defined HOST_BACKUP[%CHOICE%] (
    echo 无效的输入，请输入一个数字 [1-%i%].
    goto :EOF
)

REM 替换 host 文件为选择的备份文件
echo 替换 host 文件为 %HOST_BACKUP[%CHOICE%]%
copy "%HOST_BACKUP[%CHOICE%]%" "%SYSTEMROOT%\System32\drivers\etc\hosts" /Y

echo 完成切换到 %HOST_BACKUP[%CHOICE%]%.