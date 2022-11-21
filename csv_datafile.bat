@echo off
set "_dat=%~1"
if "%_dat%"=="" echo DRAG AND DROP DATAFILE TO THIS SCRIPT&pause&exit

set "_output=%~n1"
cd /d "%~dp0"

title "%_output%"
findstr /c:"<rom name=" "%_dat%" >temp.txt

echo. "Which Region(s) do you want to extract the hash values?"
echo.
echo. 1 = ALL:
echo. 2 = ^(USA^)
echo. 3 = ^(Europe^)
echo. 4 = ^(Europe^)+
echo. 5 = ^(Japan^)
echo. 6 = ^(Demos^)
echo.
choice /n /c:123456 /m:"Enter Option: "

set "_find="&set "_opt="
if %errorlevel% equ 1 goto save_all
if %errorlevel% equ 2 set "_find=\(USA[,)]"
if %errorlevel% equ 3 set "_find=\(Europe[,)]"
if %errorlevel% equ 4 set "_find=\(USA[,)] \(Europe[,)] \(Japan[,)]"&set _opt=/v
if %errorlevel% equ 5 set "_find=\(Japan[,)]"
if %errorlevel% equ 6 set "_find=\(Demo\)"&goto save_demos

rem //remove demos
findstr /v "(Demo)" temp.txt >temp.1
del temp.txt&ren temp.1 temp.txt 

:save_demos
findstr /r %_opt% "%_find%" temp.txt >temp.1
del temp.txt&ren temp.1 temp.txt

:save_all
cls&echo Processing...

(echo rom_name,size,crc,md5,sha1) >"%_output%.csv"
for /f tokens^=2^,4^,6^,8^,10^ delims^=^" %%g in (temp.txt) do (
	(echo "%%g",%%h,%%i,%%j,%%k) >>"%_output%.csv"
)
del temp.txt
cls&echo FINISHED
pause&exit
