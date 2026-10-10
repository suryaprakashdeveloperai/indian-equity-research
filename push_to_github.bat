@echo off
echo ========================================================
echo  Pushing F.R.I.D.A.Y. Engine to GitHub
echo  Target: https://github.com/suryaprakashdeveloperai/indian-equity-research.git
echo ========================================================
set Path=C:\Users\ELCOT\.tools\git\cmd;%Path%
cd /d C:\Users\ELCOT\Desktop\IndianEquityResearch
git push -u origin main
echo.
echo Process complete. Press any key to exit.
pause