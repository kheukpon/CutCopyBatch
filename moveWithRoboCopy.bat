@echo off
:: check admin or not
FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
IF (%adminTest%)==(Access) goto noAdmin
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_move_file "%%G")
echo.
echo Event Logs have been cleared! ^<press any key^>

:do_move_file
@echo off
:: set datetime now for name folder
    For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%b%%a%%c)
	For /f "tokens=1-3 delims=/:/./ " %%a in ("%TIME%") do (set mytime=%%a-%%b-%%c)
	set datetime=%mydate%_%mytime%
	set sourceFolder="C:\testCopy"
	set destFolder="D:\testDest\CopyC-%datetime%"
	set sourceDCopy="D:\testCopy"
	set destDCopy="C:\t"
	:: grant permission to folder and files
	::icacls "%sourceFolder%" /grant Everyone:(OI)(CI)(F) /T
	echo.
	echo Moving files C to D
	echo.
	robocopy /move /e "%sourceFolder%" "%destFolder%"
	echo.
	echo Done moving file
	echo.
	echo Copying files D to C
	echo.	
	robocopy /e "%sourceDCopy%" "%destDCopy%"
	echo.
	echo Done
	echo.
	pause
:noAdmin
echo You must run this script as an Administrator!
pause