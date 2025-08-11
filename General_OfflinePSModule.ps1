$url="https://aamirhsn-pwsh.s3.amazonaws.com/powershell-yaml.zip"
New-Item -ItemType Directory -Force -Path 'C:\temp'
New-Item -ItemType Directory -Force -Path 'C:\temp\powershell-yaml'
Invoke-WebRequest $url -Outfile C:\temp\powershell-yaml.zip
Expand-Archive -Path C:\temp\powershell-yaml.zip -Force -DestinationPath "C:\temp\powershell-yaml"
Copy-Item -Path "C:\temp\powershell-yaml\" -Destination "C:\Windows\system32\WindowsPowerShell\v1.0\Modules" -Recurse -Force
Copy-Item -Path "C:\temp\powershell-yaml\" -Destination "C:\Program Files\WindowsPowerShell\Modules" -Recurse -Force
Copy-Item -Path "C:\temp\powershell-yaml\" -Destination "C:\Program Files (x86)\AWS Tools\PowerShell" -Recurse -Force
