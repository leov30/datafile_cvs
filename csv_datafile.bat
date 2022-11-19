@echo off

set "_dat="
for %%g in (*.dat) do set "_dat=%%g"
if "%_dat%"=="" echo NO DATAFILE WAS FOUND&pause&exit

title Processing...
findstr /b /c:"		<rom name=" "%_dat%" >temp.txt

(echo rom_name,size,crc,md5,sha1) >output.csv
for /f tokens^=2^,4^,6^,8^,10^ delims^=^" %%g in (temp.txt) do (
	(echo "%%g",%%h,%%i,%%j,%%k) >>output.csv
)
del temp.txt
title FINISHED
pause&exit
