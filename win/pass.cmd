@echo off
"C:\Program Files\VeraCrypt\VeraCrypt.exe" /v C:%HOMEPATH%\Nextcloud\Documents\tc_volume /l A /q
type A:\pwd\*%1*
"C:\Program Files\VeraCrypt\VeraCrypt.exe" /d /q
