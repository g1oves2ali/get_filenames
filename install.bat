@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

:: 检查主程序是否存在
set "EXE_PATH=%~dp0get_filenames.exe"
if not exist "%EXE_PATH%" (
    call :show_error "错误：未找到 get_filenames.exe！请确保与本程序同目录"
    exit /b 1
)

:: 生成临时注册表文件
(
    echo Windows Registry Editor Version 5.00
    echo.
    echo [HKEY_CLASSES_ROOT\Directory\Background\shell\GetFileNames]
    echo @="get_filenames"
    echo "Icon"="shell32.dll,1"
    echo.
    echo [HKEY_CLASSES_ROOT\Directory\Background\shell\GetFileNames\command]
    echo @="\"%EXE_PATH:\=\\%\" \"%%V\""
)>"%temp%\temp.reg"

:: 导入注册表
regedit /s "%temp%\temp.reg"
del "%temp%\temp.reg"

:: 显示成功提示
call :show_success "右键菜单安装成功！^请确保不要移动get_filenames.exe"
exit /b

:show_success
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('%~1', '操作成功', 'OK', 'Information')"
exit /b

:show_error
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('%~1', '错误', 'OK', 'Error')"
exit /b