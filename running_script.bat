@echo off
REM Get the current time for the start of the script
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set datetime=%%I
set start_time=%datetime:~8,2%:%datetime:~10,2%:%datetime:~12,2%

REM Compile the LaTeX file using xelatex twice
xelatex main.tex > NUL 2>&1
biber main > NUL 2>&1
xelatex main.tex > NUL 2>&1
xelatex main.tex > NUL 2>&1

REM Check if the command was successful
if %ERRORLEVEL% NEQ 0 (
    echo Compilation failed!
    pause
    exit /b %ERRORLEVEL%
)

REM Get the current time for the end of the script
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set datetime=%%I
set end_time=%datetime:~8,2%:%datetime:~10,2%:%datetime:~12,2%

REM Calculate and log the duration of the script
set /a start_hour=%start_time:~0,2%
set /a start_minute=%start_time:~3,2%
set /a start_second=%start_time:~6,2%

set /a end_hour=%end_time:~0,2%
set /a end_minute=%end_time:~3,2%
set /a end_second=%end_time:~6,2%

REM Convert times to seconds
set /a start_total_seconds=(%start_hour%*3600)+(%start_minute%*60)+%start_second%
set /a end_total_seconds=(%end_hour%*3600)+(%end_minute%*60)+%end_second%

REM Calculate the difference in seconds
set /a duration_seconds=%end_total_seconds% - %start_total_seconds%

REM Log the duration in seconds
echo Compilation in %duration_seconds% seconds.

REM Remove auxiliary files
del /q *.aux *.bbl *.blg *.log *.out *.toc *.fls *.fdb_latexmk *bbl* *.bcf *lof

echo Auxiliary files removed.
