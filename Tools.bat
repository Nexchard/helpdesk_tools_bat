@echo off
setlocal enabledelayedexpansion

rem 总共有33个功能选项
set "total_items=33"
rem 每页显示10个功能
set "per_page=10"
rem 当前页码初始化为1
set "current_page=1"

:menu
rem 清屏，让菜单显示更清晰
cls

rem 计算当前页的起始索引
set "start_index=%current_page%"
set /a start_index=%start_index% * %per_page% - %per_page% + 1

rem 计算当前页的结束索引
set /a end_index=%current_page% * %per_page%
if %end_index% gtr %total_items% set end_index=%total_items%

rem 计算总页数
set /a total_pages=(%total_items% + %per_page% -1) / %per_page%

rem 打印菜单标题
echo.
echo ==============================================================
echo Author: GU
echo Version: V0.1.0.20250228
echo ****************************菜单******************************
echo.

rem 静态打印当前页的功能选项
set "index=%start_index%"
:print_menu
if %index% gtr %end_index% goto :print_done
if !index! gtr %total_items% goto :print_done

rem 静态功能描述
set "title_desc="
if "%index%"=="1" set "title_desc=以管理员身份重新打开脚本"
if "%index%"=="2" set "title_desc=查询AD账户信息"
if "%index%"=="3" set "title_desc=查询网络信息"
if "%index%"=="4" set "title_desc=刷新DNS缓存"
if "%index%"=="5" set "title_desc=组策略相关"
if "%index%"=="6" set "title_desc=扫描所有端口及占用程序"
if "%index%"=="7" set "title_desc=清理系统垃圾"
if "%index%"=="8" set "title_desc=追踪路由"
if "%index%"=="9" set "title_desc=桌面图标恢复"
if "%index%"=="10" set "title_desc=生成免密应用提权运行脚本"
if "%index%"=="11" set "title_desc=硬件检测"
if "%index%"=="12" set "title_desc=防火墙规则"
if "%index%"=="13" set "title_desc=重启打印服务并清除任务缓存"
if "%index%"=="14" set "title_desc=恢复Win10照片查看器"
if "%index%"=="15" set "title_desc=电池报告"
if "%index%"=="16" set "title_desc=查询系统安装时间"
if "%index%"=="17" set "title_desc=重启网卡"
if "%index%"=="18" set "title_desc=查看本机空闲及已占用盘符"
if "%index%"=="19" set "title_desc=查看系统激活情况"
if "%index%"=="20" set "title_desc=查看office激活情况(2016及更高版本)"
if "%index%"=="21" set "title_desc=关闭bitlocker"
if "%index%"=="22" set "title_desc=删除多余用户"
if "%index%"=="23" set "title_desc=系统配置（安全模式启动或修改引导）"
if "%index%"=="24" set "title_desc=密码策略查看"
if "%index%"=="25" set "title_desc=修复程序打开方式异常"
if "%index%"=="26" set "title_desc=修复资源管理器打不开"
if "%index%"=="27" set "title_desc=获取设备SN码"
if "%index%"=="28" set "title_desc=远程修改计算机名"
if "%index%"=="29" set "title_desc=激活系统--命令行版"
if "%index%"=="30" set "title_desc=检查文件系统中的错误（chkdsk）"
if "%index%"=="31" set "title_desc=检查系统中的错误（SFC）"
if "%index%"=="32" set "title_desc=检查系统中的错误（DISM）"
if "%index%"=="33" set "title_desc=重置 Winsock修复网络连接问题"

echo. !index!. %title_desc%
set /a index+=1
goto :print_menu
:print_done

echo.
echo **************************************************************

rem 打印当前页码和总页数
echo.
echo 当前页：%current_page%/%total_pages%

rem 提示用户输入选项
echo.
echo (输入数字选择功能，或按n翻页，按b返回上一页，按q退出程序)
echo.

rem 获取用户输入
set "choice="
set /p "choice=请输入选项: "


rem 如果用户输入q，退出程序
if "%choice%"=="q" goto :exit

rem 如果用户输入n，翻到下一页
if "%choice%"=="n" (
    rem 检查当前页是否已经是最后一页
    if %current_page% geq %total_pages% (
        echo 无法翻到不存在的页，请重新选择！
        pause
        goto :menu
    )
    set /a current_page +=1
    goto :menu
)

rem 如果用户输入b，返回上一页
if "%choice%"=="b" (
    set /a current_page -=1
    rem 如果返回上一页小于1，提示用户无法返回
    if %current_page% lss 2 (
        echo 无法返回到不存在的页，请重新选择！
        set current_page=1
        pause
        goto :menu
    )
    goto :menu
)

rem 根据用户选择跳转到对应的功能
call :function%choice%
goto :menu

rem 功能实现部分（替换为实际功能）
:function1
title 以管理员身份重新打开脚本
cls
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
	echo 请求管理员权限...
	goto UACPrompt
) else ( goto :menu )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
goto :exit


:function2
title 查询AD账户信息
cls
set /p ADUsername=请输入用户名:
net user %ADUsername% /domain
echo;
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function3
title 查询网络信息
cls
ipconfig /all
echo;
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function4
title 刷新DNS缓存
cls
ipconfig /flushdns
echo;
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function5
title 组策略相关
cls
set /p GroupStrategySelection="请选择下一步操作,刷新组策略(refreshgp)|生成组策略报告(gengp):"
if "%GroupStrategySelection%"=="refreshgp" goto refreshgp
if "%GroupStrategySelection%"=="gengp" goto generategp

:refreshgp
gpupdate /force
echo;
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:generategp
gpresult /h d:\generategp.html
echo;
echo 已生成报告generategp.html并导出至D盘
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function6
title 扫描所有端口及占用程序
cls
netstat -ano
echo;
echo 按任意键继续筛选端口号
echo;
pause >nul
goto ProcessPortNumber

:ProcessPortNumber
set /p ProcessPortNumber=请输入端口号:
netstat -ano |findstr %ProcessPortNumber%
echo;
echo 按任意键继续筛选PID
echo;
pause >nul
goto ProcessPID

:ProcessPID
set /p ProcessPID=请输入PID:
tasklist |findstr %ProcessPID%
echo;
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function7
title 清理系统垃圾
cls
echo 正在清除系统垃圾文件，请稍等......
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
echo 清除系统垃圾完成,任意键返回菜单!
echo; & pause >nul
goto :menu

:function8
title 追踪路由
cls
set /p DestinationAddress=请输入目标地址:
tracert -d %DestinationAddress%
echo;
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function9
title 桌面图标恢复
cls
taskkill /f /im explorer.exe
CD /d %userprofile%\AppData\Local
DEL IconCache.db /a
start explorer.exe
echo;
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function10
title 生成免密应用提权运行脚本
cls
set /p RunningPath=请将需要的执行程序直接拖至此处:
echo runas /user:administrator /savecred %RunningPath% >run.bat
echo 已生成run.bat
echo 如脚本无法正常使用，请检查路径部分语法是否有误。
echo;
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function11
title 硬件检测
cls
sc config  winmgmt start= auto >nul 2<&1
net start winmgmt 2>nul
setlocal  ENABLEDELAYEDEXPANSION
echo 主版:
for /f "tokens=1,* delims==" %%a in ('wmic BASEBOARD get Manufacturer^,Product^,Version^,SerialNumber /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       制造商   = %%b
     if "!tee!" == "4" echo       型  号   = %%b
     if "!tee!" == "5" echo       序列号   = %%b
     if "!tee!" == "6" echo       版  本   = %%b
)
set tee=0
echo      BIOS:
for /f "tokens=1,* delims==" %%a in ('wmic bios  get CurrentLanguage^,Manufacturer^,SMBIOSBIOSVersion^,SMBIOSMajorVersion^,SMBIOSMinorVersion^,ReleaseDate /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       当前语言 = %%b
     if "!tee!" == "4" echo       制造商   = %%b
     if "!tee!" == "5" echo       发行日期 = %%b
     if "!tee!" == "6" echo       版  本   = %%b
     if "!tee!" == "7" echo       SMBIOSMajorVersion = %%b
     if "!tee!" == "8" echo       SMBIOSMinorVersion = %%b 
)
set tee=0
echo.
echo CPU:
for /f "tokens=1,* delims==" %%a in ('wmic cpu get name^,ExtClock^,CpuStatus^,Description /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       CPU个数   = %%b
     if "!tee!" == "4" echo       处理器版本   = %%b
     if "!tee!" == "5" echo       外   频   = %%b
     if "!tee!" == "6" echo       名称及主频率   = %%b
)
set tee=0
echo.
echo 显示器:
for /f "tokens=1,* delims==" %%a in ('wmic DESKTOPMONITOR  get name^,ScreenWidth^,ScreenHeight^,PNPDeviceID /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       类    型  = %%b
     if "!tee!" == "4" echo       其他信息  = %%b
     if "!tee!" == "5" echo       屏幕高    = %%b
     if "!tee!" == "6" echo       屏幕宽    = %%b
)
set tee=0
echo.
echo 硬  盘:
for /f "tokens=1,* delims==" %%a in ('wmic DISKDRIVE get model^,interfacetype^,size^,totalsectors^,partitions /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       接口类型  = %%b
     if "!tee!" == "4" echo       硬盘型号  = %%b
     if "!tee!" == "5" echo       分区数    = %%b
     if "!tee!" == "6" echo       容    量  = %%b
     if "!tee!" == "7" echo       总扇区    = %%b
)
echo 分区信息:
wmic LOGICALDISK  where mediatype='12' get description,deviceid,filesystem,size,freespace
set tee=0
echo.
echo 网  卡:
for /f "tokens=1,* delims==" %%a in ('wmic NICCONFIG where "index='1'" get ipaddress^,macaddress^,description /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       网卡类型  = %%b
     if "!tee!" == "4" echo       网卡IP    = %%b
     if "!tee!" == "5" echo       网卡MAC   = %%b
)
set tee=0
echo.
echo 打印机:
for /f "tokens=1,* delims==" %%a in ('wmic PRINTER get caption /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       打印机名字  = %%b
)
set tee=0
echo.
echo 声   卡:
for /f "tokens=1,* delims==" %%a in ('wmic SOUNDDEV get name^,deviceid /value') do (
     set /a tee+=1
     if "!tee!" == "3" echo       其他信息  = %%b
     if "!tee!" == "4" echo       型    号  = %%b
)
set tee=0
echo.
echo 内    存: 
for /f "tokens=1,* delims==" %%a in ('systeminfo^|find "内存"') do (
    echo         %%a 4534 %%b 
)
echo.
echo 显    卡:
del /f "%TEMP%\temp.txt" 2>nul
dxdiag /t %TEMP%\temp.txt
:显卡
rem 这里需要30秒左右!
if EXIST "%TEMP%\temp.txt" (
    for /f "tokens=1,2,* delims=:" %%a in ('findstr /c:" Card name:" /c:"Display Memory:" /c:"Current Mode:" "%TEMP%\temp.txt"') do (
         set /a tee+=1
         if !tee! == 1 echo     显卡型号: %%b
         if !tee! == 2 echo     显存大小: %%b
         if !tee! == 3 echo     当前设置: %%b
)   ) else (
    ping /n 2 127.1>nul
    goto 显卡
)
set /p AdditionalInformation=需要额外信息吗(y/n): 
if /i %AdditionalInformation% == y notepad "%TEMP%\temp.txt"
del /f "%TEMP%\temp.txt" 2>nul
pause
goto :menu

:function12
title 防火墙规则
cls
:FirewallRules
set /p FirewallRules="输入选择添加(add)防火墙规则或查看(show)防火墙规则：(add|show|quit)"
if "%FirewallRules%"=="add" goto AddFirewallRules
if "%FirewallRules%"=="show" goto ShowFirewallRules
if "%FirewallRules%"=="quit" goto :menu

:ShowFirewallRules
netsh advfirewall firewall show rule name=all
goto FirewallRules

:AddFirewallRules
set /p AddFirewallRules="选择加出|入规则(addout|addin):"
if "%AddFirewallRules"=="addout" goto FirewallExitDirection
if "%AddFirewallRules%"=="addin" goto FirewallEntryDirection

:FirewallEntryDirection
set /p FirewallRuleName="规则名称："
set /p ProgramPath="程序路径："
set /p RuleType="允许|阻止(a|b)："
if "%RuleType"=="a" set FirewallAction="allow"
if "%RuleType%"=="b" set FirewallAction="block"
netsh advfirewall firewall add rule name="%FirewallRuleName%" dir=in action="%FirewallAction%" program="%ProgramPath%" enable=yes
goto FirewallRules

:FirewallExitDirection
set /p FirewallRuleName="规则名称："
set /p ProgramPath="程序路径："
set /p RuleType="允许|阻止(a|b)："
if "%RuleType%"=="a" set FirewallAction="allow"
if "%RuleType%"=="b" set FirewallAction="block"
netsh advfirewall firewall add rule name="%FirewallRuleName%" dir=out action="%FirewallAction%" program="%ProgramPath%" enable=yes
goto FirewallRules

:function13
title 重启打印服务并清除任务缓存
cls
net stop spooler
del c:\windows\system32\spool\printers\*.* /Q /F
net start spooler
pause
goto :menu

:function14
title 恢复Win10照片查看器
cls
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpg" /t REG_SZ /d PhotoViewer.FileAssoc.Tiff /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".jpeg" /t REG_SZ /d PhotoViewer.FileAssoc.Tiff /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".bmp" /t REG_SZ /d PhotoViewer.FileAssoc.Tiff /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".png" /t REG_SZ /d PhotoViewer.FileAssoc.Tiff /f
echo 请双击或右击图片，选择"照片查看器"即可
pause
goto :menu

:function15
title 电池报告
cls
powercfg /batteryreport output "D:/电池报告.html"
echo;
echo 已生成报告"电池报告.html"并导出至D盘
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function16
title 查询系统安装时间
cls
systeminfo
echo;
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function17
title 重启网卡
cls
netsh interface show interface
set /p NICSelection="请输入需要重启的网卡接口名称："
echo.
echo 正在重启网卡%NICSelection%
netsh interface set interface "%NICSelection%" disable
for /f "delims=" %%i in ('netsh interface set interface "%NICSelection%" enabled') do set Returnvalue=%%i
IF NOT "%Returnvalue%"=="" echo 出现错误请重试,按任意键返回菜单
if "%Returnvalue%"=="" echo %NICSelection%重启成功，按任意键返回菜单
echo;
pause >nul
goto :menu

:function18
title 查看本机空闲及已占用盘符
cls
set DiskDriveNumber=a b c d e f g h i j k l m n o p q r s t u v x y z
echo 当前系统空闲盘符(a~z)有：
for %%f in (%DiskDriveNumber%) do if not exist %%f: echo %%f:
echo 当前系统占用盘符(a~z)有：
for %%b in (%DiskDriveNumber%) do if exist %%b: echo %%b:
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function19
title 查看系统激活情况
cls
slmgr /xpr > nul
if %errorlevel% equ 0 (
    echo Windows已成功激活。
) else if %errorlevel% equ 1792 (
    echo Windows未能连接到互联网进行激活验证。
) else (
    slmgr.vbs -dlv | findstr "License Status"
)
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function20
title 查看office激活情况(2016及更高版本)
cls
powershell -Command "(Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Office\16.0\Common\OEM' -Name 'FirstInstallDate').FirstInstallDate" > nul
if %errorlevel% equ 0 (
    echo Office已成功激活。
) else (
    echo Office未能激活。
)
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function21
title 关闭bitlocker
cls
set /p DriveLetter=请输入需要关闭的盘符：
manage-bde -off %DriveLetter%:
echo;
pause >nul
goto :menu

:function22
title 删除多余用户
cls
set /p DeleteUser=请输入需要删除的用户名：
net user %DeleteUser% /delete
echo 用户已删除，按任意键返回菜单
echo;
pause >nul
goto :menu

:function23
title 系统配置（安全模式启动或修改引导）
cls
msconfig
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function24
title 密码策略查看
cls
net accounts /domain
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function25
title 修复程序打开方式异常
cls
echo y|reg add "HKEY_CLASSES_ROOT\exefile\shell\open\command" /ve /t REG_SZ /d "\"%1\" %*" /f
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function26
title 修复资源管理器打不开
cls
echo y|reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d "Explorer.exe" /f
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function27
title 获取设备SN码
cls
wmic bios get serialnumber
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function28
title 远程修改计算机名
cls
set /p OldComputerName=请输入需要修改的计算机名：
set /p NewComputerName=请输入需要修改的计算机名：
netdom renamecomputer %OldComputerName% /newname:%NewComputerName% /userd:baheal\p /passwordd:000000
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function29
title 激活系统--命令行版
cls
set /p="irm https://massgrave.dev/get | iex"<nul |clip
echo 该功能需要PowerShell配合执行对应命令
echo 复制以下命令："irm https://massgrave.dev/get | iex"
echo 或者复制备选命令："irm https://get.activated.win | iex"
echo 以上命令会自动复制到剪切板，可直接在新窗口粘贴执行！！
echo 请按下回车，在弹出的新窗口中执行复制出来的命令。
pause
powershell -Command "Start-Process PowerShell -Verb RunAs"
echo 再按一次任意键返回菜单
echo;
pause >nul
goto :menu

:function30
title 检查文件系统中的错误（chkdsk）
cls
chkdsk C: /f /r
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function31
title 检查系统中的错误（SFC）
cls
sfc /scannow
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function32
title 检查系统中的错误（DISM）
cls
dism /online /cleanup-image /restorehealth
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:function33
title 重置 Winsock修复网络连接问题
cls
netsh winsock reset
echo 按任意键返回菜单
echo;
pause >nul
goto :menu

:exit
rem 结束脚本
endlocal
exit /b