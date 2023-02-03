:: A script that downloads a repository without needing git on the computer.
:: Can be used with "fine-grained access tokens".
:: Access token only needs "contents:read-only" permission.
:: Should work on most Windows 10+ computers.


:: Owner of the Repo
SET "_user=" 

:: Name of the Repo
SET "_repo="

:: Repo's access token
SET "_token="

curl -H "Authorization: token %_token%" -L "https://api.github.com/repos/%_user%/%_repo%/zipball/main" > main.zip

powershell -command (Expand-Archive -Force ".\\main.zip" -DestinationPath ".\\")

FOR /F "delims=" %%i IN ('powershell -command Get-ChildItem -Path '.\\' -Recurse -Filter '*%_user%-%_repo%*' -name') DO SET _folder=%%i

powershell -command Move-Item -Force -Path ".\\%_folder%\\*" -Destination ".\\"

powershell -command Remove-Item -Force -Path ".\\main.zip"

powershell -command Remove-Item -Force -Recurse -Path ".\\%_folder%"