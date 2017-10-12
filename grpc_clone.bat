@echo off
pushd "%~dp0"

echo #### grpc clone start!

echo #### git clone
call git clone -b v1.3.x https://github.com/grpc/grpc
cd grpc
call git submodule update --init --recursive
cd ..

echo #### props edit
powershell -executionpolicy bypass -file edit_props.ps1

echo #### nuget packages install
mkdir grpc\vsprojects\packages & cd grpc\vsprojects\packages
REM The following command works for PowerShell v2+
powershell -executionpolicy bypass -Command "(New-Object System.Net.WebClient).DownloadFile(\"https://dist.nuget.org/win-x86-commandline/latest/nuget.exe\", \"%cd%\nuget.exe\")"
REM The following command ONLY works for PowerShell v3+
REM powershell -executionpolicy bypass -Command Invoke-WebRequest https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile "%cd%\nuget.exe"

nuget.exe install ..\vcxproj\grpc\packages.config

echo #### grpc clone done!

popd
pause
