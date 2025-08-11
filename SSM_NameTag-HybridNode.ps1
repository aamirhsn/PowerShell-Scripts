######### VERSION 1 ###############
Install-Module -Name AWSPowerShell -Confirm:$false
Get-CimInstance -ClassName Win32_ComputerSystem
$hostname = (Get-CimInstance -ClassName Win32_ComputerSystem).Name
$instanceHostname = (Get-Content "C:\ProgramData\Amazon\SSM\runtimeconfig\identity_config.json" | ConvertFrom-Json).InstanceId
$tag = New-Object Amazon.SimpleSystemsManagement.Model.Tag
$tag.Key = "systemhostname"
$tag.Value = '{0}' -F $hostname
Add-SSMResourceTag -ResourceType "ManagedInstance" -ResourceId $instanceHostname -Tag $tag -Force -ProfileName [CLI profile name] -Region [Region]



######### VERSION 2 ###############
Install-Module -Name AWSPowerShell -Confirm:$false
Get-CimInstance -ClassName Win32_ComputerSystem
$hostname = (Get-CimInstance -ClassName Win32_ComputerSystem).Name
$path = & 'C:\Program Files\Amazon\SSM\ssm-cli.exe' get-instance-information
$instanceHostname = ($path | ConvertFrom-Json).'instance-id'
$tag = New-Object Amazon.SimpleSystemsManagement.Model.Tag
$tag.Key = "systemhostname"
$tag.Value = '{0}' -F $hostname
Add-SSMResourceTag -ResourceType "ManagedInstance" -ResourceId $instanceHostname -Tag $tag -Force -ProfileName [CLI profile name] -Region [Region]
