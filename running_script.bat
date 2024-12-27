@echo off
REM Compile the LaTeX file using xelatex twice
xelatex main.tex > NUL 2>&1
xelatex main.tex

REM Check if the command was successful
if %ERRORLEVEL% NEQ 0 (
    echo Compilation failed!
    pause
    exit /b %ERRORLEVEL%
)

echo Compilation successful!

REM Remove auxiliary files
del /q *.aux *.bbl *.blg *.log *.out *.toc *.fls *.fdb_latexmk *bbl* *.bcf *lof

echo Auxiliary files removed.
