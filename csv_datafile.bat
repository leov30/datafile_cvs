@echo off
set "_dat=%~1"
if "%_dat%"=="" echo DRAG AND DROP DATAFILE TO THIS SCRIPT&pause&exit

set "_output=%~n1"
cd /d "%~dp0"
title Processing...
findstr /b /c:"		<rom name=" "%_dat%" >temp.txt

(echo rom_name,size,crc,md5,sha1) >"%_output%.csv"
for /f tokens^=2^,4^,6^,8^,10^ delims^=^" %%g in (temp.txt) do (
	(echo "%%g",%%h,%%i,%%j,%%k) >>"%_output%.csv"
)
del temp.txt
title FINISHED
pause&exit
