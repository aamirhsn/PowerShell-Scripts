## Change ownership of the file and take Full Control
takeown /F "C:\Windows\SysWOW64\curl.exe"
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("SYSTEM","FullControl","Allow")
$curlfile = Get-Acl "C:\Windows\SysWOW64\curl.exe"
$curlfile.SetAccessRule($AccessRule)
$curlfile | Set-Acl "C:\Windows\SysWOW64\curl.exe"
rm "C:\Windows\SysWOW64\curl.exe"
