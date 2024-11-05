@echo off
setlocal enabledelayedexpansion

:loop
REM 1. ��ʾ�û�����Ҫ��ѯ�Ķ˿ں�
set /p "port=������Ҫ��ѯ�Ķ˿ںţ�"

REM 2. ʹ�� netstat �������ռ�øö˿ڵ� PID
set "pid="
for /f "tokens=5" %%a in ('netstat -ano ^| findstr /c:":%port% "') do (
    set "pid=%%a"
)

REM 3. ����Ƿ��ҵ������Ϣ
if not defined pid (
    echo û���ҵ�ռ�ö˿� %port% �ĳ���
    @REM exit /b
)

REM 4. ʹ�� wmic �����ȡ������Ϣ
set "program_name="
for /f "skip=1 tokens=2 delims=," %%b in ('wmic process where "processid=%pid%" get name /format:csv') do (
    set "program_name=%%~b"
)

REM 5. ��ʾ�ҵ��ĳ�����Ϣ������ҵ��ˣ�
if defined program_name (
    echo �������ƣ�%program_name%
) else (
    echo �޷���ȡ�������ƣ���ʾ����·����
    for /f "skip=1 tokens=2 delims=," %%c in ('wmic process where "processid=%pid%" get executablepath /format:csv') do (
        echo ����·����%%~c
    )
)

REM 6. ��ʾ�û��Ƿ�ɱ���ó���
set /p "choice=�ó�������ռ�ö˿� %port%���Ƿ�ɱ���ó��� (Y/N): "
if /i "%choice%"=="Y" (
    REM 7. ɱ������
    taskkill /f /pid %pid%
    echo �����ѱ�ɱ�����˿� %port% ���ͷš�
) else (
    echo �û�ȡ������������δ��ɱ�����˿� %port% ��Ȼ��ռ�á�
)

goto loop

