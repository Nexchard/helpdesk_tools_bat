@echo off
setlocal enabledelayedexpansion

rem �ܹ���33������ѡ��
set "total_items=33"
rem ÿҳ��ʾ10������
set "per_page=10"
rem ��ǰҳ���ʼ��Ϊ1
set "current_page=1"

:menu
rem �������ò˵���ʾ������
cls

rem ���㵱ǰҳ����ʼ����
set "start_index=%current_page%"
set /a start_index=%start_index% * %per_page% - %per_page% + 1

rem ���㵱ǰҳ�Ľ�������
set /a end_index=%current_page% * %per_page%
if %end_index% gtr %total_items% set end_index=%total_items%

rem ������ҳ��
set /a total_pages=(%total_items% + %per_page% -1) / %per_page%

rem ��ӡ�˵�����
echo.
echo ==============================================================
echo Author: GU
echo Version: V0.1.0.20250228
echo ****************************�˵�******************************
echo.

rem ��̬��ӡ��ǰҳ�Ĺ���ѡ��
set "index=%start_index%"
:print_menu
if %index% gtr %end_index% goto :print_done
if !index! gtr %total_items% goto :print_done

rem ��̬��������
set "title_desc="
if "%index%"=="1" set "title_desc=�Թ���Ա������´򿪽ű�"
if "%index%"=="2" set "title_desc=��ѯAD�˻���Ϣ"
if "%index%"=="3" set "title_desc=��ѯ������Ϣ"
if "%index%"=="4" set "title_desc=ˢ��DNS����"
if "%index%"=="5" set "title_desc=��������"
if "%index%"=="6" set "title_desc=ɨ�����ж˿ڼ�ռ�ó���"
if "%index%"=="7" set "title_desc=����ϵͳ����"
if "%index%"=="8" set "title_desc=׷��·��"
if "%index%"=="9" set "title_desc=����ͼ��ָ�"
if "%index%"=="10" set "title_desc=��������Ӧ����Ȩ���нű�"
if "%index%"=="11" set "title_desc=Ӳ�����"
if "%index%"=="12" set "title_desc=����ǽ����"
if "%index%"=="13" set "title_desc=������ӡ����������񻺴�"
if "%index%"=="14" set "title_desc=�ָ�Win10��Ƭ�鿴��"
if "%index%"=="15" set "title_desc=��ر���"
if "%index%"=="16" set "title_desc=��ѯϵͳ��װʱ��"
if "%index%"=="17" set "title_desc=��������"
if "%index%"=="18" set "title_desc=�鿴�������м���ռ���̷�"
if "%index%"=="19" set "title_desc=�鿴ϵͳ�������"
if "%index%"=="20" set "title_desc=�鿴office�������(2016�����߰汾)"
if "%index%"=="21" set "title_desc=�ر�bitlocker"
if "%index%"=="22" set "title_desc=ɾ�������û�"
if "%index%"=="23" set "title_desc=ϵͳ���ã���ȫģʽ�������޸�������"
if "%index%"=="24" set "title_desc=������Բ鿴"
if "%index%"=="25" set "title_desc=�޸�����򿪷�ʽ�쳣"
if "%index%"=="26" set "title_desc=�޸���Դ�������򲻿�"
if "%index%"=="27" set "title_desc=��ȡ�豸SN��"
if "%index%"=="28" set "title_desc=Զ���޸ļ������"
if "%index%"=="29" set "title_desc=����ϵͳ--�����а�"
if "%index%"=="30" set "title_desc=����ļ�ϵͳ�еĴ���chkdsk��"
if "%index%"=="31" set "title_desc=���ϵͳ�еĴ���SFC��"
if "%index%"=="32" set "title_desc=���ϵͳ�еĴ���DISM��"
if "%index%"=="33" set "title_desc=���� Winsock�޸�������������"

echo. !index!. %title_desc%
set /a index+=1
goto :print_menu
:print_done

echo.
echo **************************************************************

rem ��ӡ��ǰҳ�����ҳ��
echo.
echo ��ǰҳ��%current_page%/%total_pages%

rem ��ʾ�û�����ѡ��
echo.
echo (��������ѡ���ܣ���n��ҳ����b������һҳ����q�˳�����)
echo.

rem ��ȡ�û�����
set "choice="
set /p "choice=������ѡ��: "


rem ����û�����q���˳�����
if "%choice%"=="q" goto :exit

rem ����û�����n��������һҳ
if "%choice%"=="n" (
    rem ��鵱ǰҳ�Ƿ��Ѿ������һҳ
    if %current_page% geq %total_pages% (
        echo �޷����������ڵ�ҳ��������ѡ��
        pause
        goto :menu
    )
    set /a current_page +=1
    goto :menu
)

rem ����û�����b��������һҳ
if "%choice%"=="b" (
    set /a current_page -=1
    rem ���������һҳС��1����ʾ�û��޷�����
    if %current_page% lss 2 (
        echo �޷����ص������ڵ�ҳ��������ѡ��
        set current_page=1
        pause
        goto :menu
    )
    goto :menu
)

rem �����û�ѡ����ת����Ӧ�Ĺ���
call :function%choice%
goto :menu

rem ����ʵ�ֲ��֣��滻Ϊʵ�ʹ��ܣ�
:function1
title �Թ���Ա������´򿪽ű�
cls
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
	echo �������ԱȨ��...
	goto UACPrompt
) else ( goto :menu )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
goto :exit


:function2
title ��ѯAD�˻���Ϣ
cls
set /p ADUsername=�������û���:
net user %ADUsername% /domain
echo;
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function3
title ��ѯ������Ϣ
cls
ipconfig /all
echo;
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function4
title ˢ��DNS����
cls
ipconfig /flushdns
echo;
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function5
title ��������
cls
set /p GroupStrategySelection="��ѡ����һ������,ˢ�������(refreshgp)|��������Ա���(gengp):"
if "%GroupStrategySelection%"=="refreshgp" goto refreshgp
if "%GroupStrategySelection%"=="gengp" goto generategp

:refreshgp
gpupdate /force
echo;
echo ����������ز˵�
echo;
pause >nul
goto :menu

:generategp
gpresult /h d:\generategp.html
echo;
echo �����ɱ���generategp.html��������D��
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function6
title ɨ�����ж˿ڼ�ռ�ó���
cls
netstat -ano
echo;
echo �����������ɸѡ�˿ں�
echo;
pause >nul
goto ProcessPortNumber

:ProcessPortNumber
set /p ProcessPortNumber=������˿ں�:
netstat -ano |findstr %ProcessPortNumber%
echo;
echo �����������ɸѡPID
echo;
pause >nul
goto ProcessPID

:ProcessPID
set /p ProcessPID=������PID:
tasklist |findstr %ProcessPID%
echo;
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function7
title ����ϵͳ����
cls
echo �������ϵͳ�����ļ������Ե�......
del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old
del /f /s /q %systemdrive%\recycled\*.* 
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\prefetch\*.* 
rd /s /q %windir%\temp & md %windir%\temp
del /f /q %userprofile%\cookies\*.* 
del /f /q %userprofile%\recent\*.* 
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*" 
del /f /s /q "%userprofile%\Local Settings\Temp\*.*" 
del /f /s /q "%userprofile%\recent\*.*" 
echo;
echo ���ϵͳ�������,��������ز˵�!
echo; & pause >nul
goto :menu

:function8
title ׷��·��
cls
set /p DestinationAddress=������Ŀ���ַ:
tracert -d %DestinationAddress%
echo;
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function9
title ����ͼ��ָ�
cls
taskkill /f /im explorer.exe
CD /d %userprofile%\AppData\Local
DEL IconCache.db /a
start explorer.exe
echo;
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function10
title ��������Ӧ����Ȩ���нű�
cls
set /p RunningPath=�뽫��Ҫ��ִ�г���ֱ�������˴�:
echo runas /user:administrator /savecred %RunningPath% >run.bat
echo ������run.bat
echo ��ű��޷�����ʹ�ã�����·�������﷨�Ƿ�����
echo;
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function11
title Ӳ�����
cls
sc config  winmgmt start= auto >nul 2<&1
net start winmgmt 2>nul
setlocal  ENABLEDELAYEDEXPANSION
echo ����:
for /f "tokens=1,* delims==" %%a in ('wmic BASEBOARD get Manufacturer^,Product^,Version^,SerialNumber /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ������   = %%b
     if "!tee!" == "4" echo       ��  ��   = %%b
     if "!tee!" == "5" echo       ���к�   = %%b
     if "!tee!" == "6" echo       ��  ��   = %%b
)
set tee=0
echo      BIOS:
for /f "tokens=1,* delims==" %%a in ('wmic bios  get CurrentLanguage^,Manufacturer^,SMBIOSBIOSVersion^,SMBIOSMajorVersion^,SMBIOSMinorVersion^,ReleaseDate /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ��ǰ���� = %%b
     if "!tee!" == "4" echo       ������   = %%b
     if "!tee!" == "5" echo       �������� = %%b
     if "!tee!" == "6" echo       ��  ��   = %%b
     if "!tee!" == "7" echo       SMBIOSMajorVersion = %%b
     if "!tee!" == "8" echo       SMBIOSMinorVersion = %%b 
)
set tee=0
echo.
echo CPU:
for /f "tokens=1,* delims==" %%a in ('wmic cpu get name^,ExtClock^,CpuStatus^,Description /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       CPU����   = %%b
     if "!tee!" == "4" echo       �������汾   = %%b
     if "!tee!" == "5" echo       ��   Ƶ   = %%b
     if "!tee!" == "6" echo       ���Ƽ���Ƶ��   = %%b
)
set tee=0
echo.
echo ��ʾ��:
for /f "tokens=1,* delims==" %%a in ('wmic DESKTOPMONITOR  get name^,ScreenWidth^,ScreenHeight^,PNPDeviceID /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ��    ��  = %%b
     if "!tee!" == "4" echo       ������Ϣ  = %%b
     if "!tee!" == "5" echo       ��Ļ��    = %%b
     if "!tee!" == "6" echo       ��Ļ��    = %%b
)
set tee=0
echo.
echo Ӳ  ��:
for /f "tokens=1,* delims==" %%a in ('wmic DISKDRIVE get model^,interfacetype^,size^,totalsectors^,partitions /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       �ӿ�����  = %%b
     if "!tee!" == "4" echo       Ӳ���ͺ�  = %%b
     if "!tee!" == "5" echo       ������    = %%b
     if "!tee!" == "6" echo       ��    ��  = %%b
     if "!tee!" == "7" echo       ������    = %%b
)
echo ������Ϣ:
wmic LOGICALDISK  where mediatype='12' get description,deviceid,filesystem,size,freespace
set tee=0
echo.
echo ��  ��:
for /f "tokens=1,* delims==" %%a in ('wmic NICCONFIG where "index='1'" get ipaddress^,macaddress^,description /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ��������  = %%b
     if "!tee!" == "4" echo       ����IP    = %%b
     if "!tee!" == "5" echo       ����MAC   = %%b
)
set tee=0
echo.
echo ��ӡ��:
for /f "tokens=1,* delims==" %%a in ('wmic PRINTER get caption /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ��ӡ������  = %%b
)
set tee=0
echo.
echo ��   ��:
for /f "tokens=1,* delims==" %%a in ('wmic SOUNDDEV get name^,deviceid /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       ������Ϣ  = %%b
     if "!tee!" == "4" echo       ��    ��  = %%b
)
set tee=0
echo.
echo ��    ��: 
for /f "tokens=1,* delims==" %%a in ('systeminfo^|find "�ڴ�"') do (
    echo         %%a 4534 %%b 
)
echo.
echo ��    ��:
del /f "%TEMP%\temp.txt" 2>nul
dxdiag /t %TEMP%\temp.txt
:�Կ�
rem ������Ҫ30������!
if EXIST "%TEMP%\temp.txt" (
    for /f "tokens=1,2,* delims=:" %%a in ('findstr /c:" Card name:" /c:"Display Memory:" /c:"Current Mode:" "%TEMP%\temp.txt"') do (
         set /a tee+=1
         if !tee! == 1 echo     �Կ��ͺ�: %%b
         if !tee! == 2 echo     �Դ��С: %%b
         if !tee! == 3 echo     ��ǰ����: %%b
)   ) else (
    ping /n 2 127.1>nul
    goto �Կ�
)
set /p AdditionalInformation=��Ҫ������Ϣ��(y/n): 
if /i %AdditionalInformation% == y notepad "%TEMP%\temp.txt"
del /f "%TEMP%\temp.txt" 2>nul
pause
goto :menu

:function12
title ����ǽ����
cls
:FirewallRules
set /p FirewallRules="����ѡ�����(add)����ǽ�����鿴(show)����ǽ����(add|show|quit)"
if "%FirewallRules%"=="add" goto AddFirewallRules
if "%FirewallRules%"=="show" goto ShowFirewallRules
if "%FirewallRules%"=="quit" goto :menu

:ShowFirewallRules
netsh advfirewall firewall show rule name=all
goto FirewallRules

:AddFirewallRules
set /p AddFirewallRules="ѡ��ӳ�|�����(addout|addin):"
if "%AddFirewallRules"=="addout" goto FirewallExitDirection
if "%AddFirewallRules%"=="addin" goto FirewallEntryDirection

:FirewallEntryDirection
set /p FirewallRuleName="�������ƣ�"
set /p ProgramPath="����·����"
set /p RuleType="����|��ֹ(a|b)��"
if "%RuleType"=="a" set FirewallAction="allow"
if "%RuleType%"=="b" set FirewallAction="block"
netsh advfirewall firewall add rule name="%FirewallRuleName%" dir=in action="%FirewallAction%" program="%ProgramPath%" enable=yes
goto FirewallRules

:FirewallExitDirection
set /p FirewallRuleName="�������ƣ�"
set /p ProgramPath="����·����"
set /p RuleType="����|��ֹ(a|b)��"
if "%RuleType%"=="a" set FirewallAction="allow"
if "%RuleType%"=="b" set FirewallAction="block"
netsh advfirewall firewall add rule name="%FirewallRuleName%" dir=out action="%FirewallAction%" program="%ProgramPath%" enable=yes
goto FirewallRules

:function13
title ������ӡ����������񻺴�
cls
net stop spooler
del c:\windows\system32\spool\printers\*.* /Q /F
net start spooler
pause
goto :menu

:function14
title �ָ�Win10��Ƭ�鿴��
cls
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg" /t REG_SZ /d PhotoViewer.FileAssoc.Tiff /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t REG_SZ /d PhotoViewer.FileAssoc.Tiff /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".bmp" /t REG_SZ /d PhotoViewer.FileAssoc.Tiff /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png" /t REG_SZ /d PhotoViewer.FileAssoc.Tiff /f
echo ��˫�����һ�ͼƬ��ѡ��"��Ƭ�鿴��"����
pause
goto :menu

:function15
title ��ر���
cls
powercfg /batteryreport output "D:/��ر���.html"
echo;
echo �����ɱ���"��ر���.html"��������D��
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function16
title ��ѯϵͳ��װʱ��
cls
systeminfo
echo;
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function17
title ��������
cls
netsh interface show interface
set /p NICSelection="��������Ҫ�����������ӿ����ƣ�"
echo.
echo ������������%NICSelection%
netsh interface set interface "%NICSelection%" disable
for /f "delims=" %%i in ('netsh interface set interface "%NICSelection%" enabled') do set Returnvalue=%%i
IF NOT "%Returnvalue%"=="" echo ���ִ���������,����������ز˵�
if "%Returnvalue%"=="" echo %NICSelection%�����ɹ�������������ز˵�
echo;
pause >nul
goto :menu

:function18
title �鿴�������м���ռ���̷�
cls
set DiskDriveNumber=a b c d e f g h i j k l m n o p q r s t u v x y z
echo ��ǰϵͳ�����̷�(a~z)�У�
for %%f in (%DiskDriveNumber%) do if not exist %%f: echo %%f:
echo ��ǰϵͳռ���̷�(a~z)�У�
for %%b in (%DiskDriveNumber%) do if exist %%b: echo %%b:
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function19
title �鿴ϵͳ�������
cls
slmgr /xpr > nul
if %errorlevel% equ 0 (
    echo Windows�ѳɹ����
) else if %errorlevel% equ 1792 (
    echo Windowsδ�����ӵ����������м�����֤��
) else (
    slmgr.vbs -dlv | findstr "License Status"
)
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function20
title �鿴office�������(2016�����߰汾)
cls
powershell -Command "(Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Office\16.0\Common\OEM' -Name 'FirstInstallDate').FirstInstallDate" > nul
if %errorlevel% equ 0 (
    echo Office�ѳɹ����
) else (
    echo Officeδ�ܼ��
)
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function21
title �ر�bitlocker
cls
set /p DriveLetter=��������Ҫ�رյ��̷���
manage-bde -off %DriveLetter%:
echo;
pause >nul
goto :menu

:function22
title ɾ�������û�
cls
set /p DeleteUser=��������Ҫɾ�����û�����
net user %DeleteUser% /delete
echo �û���ɾ��������������ز˵�
echo;
pause >nul
goto :menu

:function23
title ϵͳ���ã���ȫģʽ�������޸�������
cls
msconfig
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function24
title ������Բ鿴
cls
net accounts /domain
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function25
title �޸�����򿪷�ʽ�쳣
cls
echo y|reg add "HKEY_CLASSES_ROOT\exefile\shell\open\command" /ve /t REG_SZ /d "\"%1\" %*" /f
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function26
title �޸���Դ�������򲻿�
cls
echo y|reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d "Explorer.exe" /f
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function27
title ��ȡ�豸SN��
cls
wmic bios get serialnumber
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function28
title Զ���޸ļ������
cls
set /p OldComputerName=��������Ҫ�޸ĵļ��������
set /p NewComputerName=��������Ҫ�޸ĵļ��������
netdom renamecomputer %OldComputerName% /newname:%NewComputerName% /userd:baheal\p /passwordd:000000
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function29
title ����ϵͳ--�����а�
cls
set /p="irm https://massgrave.dev/get | iex"<nul |clip
echo �ù�����ҪPowerShell���ִ�ж�Ӧ����
echo �����������"irm https://massgrave.dev/get | iex"
echo ���߸��Ʊ�ѡ���"irm https://get.activated.win | iex"
echo ����������Զ����Ƶ����а壬��ֱ�����´���ճ��ִ�У���
echo �밴�»س����ڵ������´�����ִ�и��Ƴ��������
pause
powershell -Command "Start-Process PowerShell -Verb RunAs"
echo �ٰ�һ����������ز˵�
echo;
pause >nul
goto :menu

:function30
title ����ļ�ϵͳ�еĴ���chkdsk��
cls
chkdsk C: /f /r
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function31
title ���ϵͳ�еĴ���SFC��
cls
sfc /scannow
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function32
title ���ϵͳ�еĴ���DISM��
cls
dism /online /cleanup-image /restorehealth
echo ����������ز˵�
echo;
pause >nul
goto :menu

:function33
title ���� Winsock�޸�������������
cls
netsh winsock reset
echo ����������ز˵�
echo;
pause >nul
goto :menu

:exit
rem �����ű�
endlocal
exit /b