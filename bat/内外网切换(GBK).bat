@echo off
:menu
cls
echo ��ѡ����Ҫִ�еĲ�����
echo [1] ����WiFi
echo [2] �Ͽ�WiFi
set /p choice=ѡ�������
if "%choice%"=="1" goto connect
if "%choice%"=="2" goto disconnect
echo ��Ч��ѡ�������ԡ�
pause
goto menu

:connect
netsh interface set interface "��̫��" admin=disable
netsh wlan connect name="����������ȵ�"
echo WiFi�����ӡ�
goto menu

:disconnect
netsh wlan disconnect
netsh interface set interface "��̫��" admin=enable
echo WiFi�ѶϿ���
goto menu

:end