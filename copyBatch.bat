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
	set sourceFolder="C:\CTestCut"
	set destFolder="D:\CTestCut-%datetime%"
	set sourceDCopy="D:\DTestCopy"
	set destDCopy="C:\DTestCopy"
	:: grant permission to folder and files	
	:: cacls "%sourceFolder%" /e /g Everyone:F /T
	echo.
	echo Moving files C to D
	echo.
	xcopy /y "%sourceFolder%" "%destFolder%" /e /i /h /f
	echo.
	echo Done moving file
	@echo off
	IF exist "%destFolder%" (rd /s /q "%sourceFolder%")	
	echo.
	echo Copying files D to C
	echo.	
	xcopy /y "%sourceDCopy%" "%destDCopy%" /e /i /h /f
	echo.
	echo Done
	echo.
	pause
:noAdmin
echo You must run this script as an Administrator!
pause