@echo off
setlocal enabledelayedexpansion

:loop
REM 1. 提示用户输入要查询的端口号
set /p "port=请输入要查询的端口号："

REM 2. 使用 netstat 命令查找占用该端口的 PID
set "pid="
for /f "tokens=5" %%a in ('netstat -ano ^| findstr /c:":%port% "') do (
    set "pid=%%a"
)

REM 3. 检查是否找到相关信息
if not defined pid (
    echo 没有找到占用端口 %port% 的程序。
    @REM exit /b
)

REM 4. 使用 wmic 命令获取进程信息
set "program_name="
for /f "skip=1 tokens=2 delims=," %%b in ('wmic process where "processid=%pid%" get name /format:csv') do (
    set "program_name=%%~b"
)

REM 5. 显示找到的程序信息（如果找到了）
if defined program_name (
    echo 程序名称：%program_name%
) else (
    echo 无法获取程序名称，显示程序路径：
    for /f "skip=1 tokens=2 delims=," %%c in ('wmic process where "processid=%pid%" get executablepath /format:csv') do (
        echo 程序路径：%%~c
    )
)

REM 6. 提示用户是否杀死该程序
set /p "choice=该程序正在占用端口 %port%，是否杀死该程序？ (Y/N): "
if /i "%choice%"=="Y" (
    REM 7. 杀死进程
    taskkill /f /pid %pid%
    echo 程序已被杀死，端口 %port% 已释放。
) else (
    echo 用户取消操作，程序未被杀死，端口 %port% 仍然被占用。
)

goto loop

