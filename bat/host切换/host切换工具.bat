@echo off

setlocal enabledelayedexpansion

set BACKUP_DIR=%cd%
set HOST_ORIGINAL=%BACKUP_DIR%\hosts.ԭʼ.txt
set CHOICE=

REM ���ԭʼ host �ļ��Ƿ���ڣ��������򱸷ݵ�ǰ host �ļ�������
if not exist "%HOST_ORIGINAL%" (
    echo ���ݵ�ǰ host �ļ�Ϊ hosts.ԭʼ.txt
    copy "%SYSTEMROOT%\System32\drivers\etc\hosts" "%HOST_ORIGINAL%" /Y
)

REM ��ȡ�����ļ��б�
set /a i=0
for %%f in ("%BACKUP_DIR%\hosts.*.txt") do (
    set /a i+=1
    set HOST_BACKUP[!i!]=%%f
    echo [!i!] %%f
)

REM ��ʾ�û�ѡ�񱸷��ļ�
set /p CHOICE=������Ҫ�л��ı����ļ� [1-%i%]: 

REM ����û������Ƿ���Ч
if not defined HOST_BACKUP[%CHOICE%] (
    echo ��Ч�����룬������һ������ [1-%i%].
    goto :EOF
)

REM �滻 host �ļ�Ϊѡ��ı����ļ�
echo �滻 host �ļ�Ϊ %HOST_BACKUP[%CHOICE%]%
copy "%HOST_BACKUP[%CHOICE%]%" "%SYSTEMROOT%\System32\drivers\etc\hosts" /Y

echo ����л��� %HOST_BACKUP[%CHOICE%]%.