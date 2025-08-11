$computer = Get-Content C:\temp\machines.txt
$startDate = (get-date).AddDays(-7)
foreach ($computers in $computer)
{
$slogonevents = Get-Eventlog -LogName Security -ComputerName $computers -after $startDate | where {$_.eventID -eq 4624 -or 4625 -or 4647}

$head="############# Machine is $computers ##############"
Add-Content -Path "c:\temp\Output.csv" -Value $head

# Crawl through events; print all logon history with type, date/time, status, account name, computer and IP address if user logged on remotely
foreach ($e in $slogonevents){
  ###### Local (Logon Type 2) ######
  if (($e.EventID -eq 4624 ) -and ($e.ReplacementStrings[8] -eq 2)){
      $a="Type: Local Logon `tDate: $($e.TimeGenerated) `tStatus: Success`tUser: $($e.ReplacementStrings[5]) `tWorkstation: $($e.ReplacementStrings[11])"
      Add-Content -Path "c:\temp\Output.csv" -Value $a
  }
  ###### Remote (Logon Type 10) ######
  if (($e.EventID -eq 4624 ) -and ($e.ReplacementStrings[8] -eq 10)){
      $b="Type: Remote Logon`tDate: $($e.TimeGenerated) `tStatus: Success`tUser: $($e.ReplacementStrings[5]) `tWorkstation: $($e.ReplacementStrings[11]) `tIP Address: $($e.ReplacementStrings[18])"
      Add-Content -Path "c:\temp\Output.csv" -Value $b
  }
  ###### Logon Failure ######
  if ($e.EventID -eq 4625){
      $c="Type: Logon Failed`tDate: $($e.TimeGenerated) `tStatus: Success`tUser: $($e.ReplacementStrings[5]) `tWorkstation: $($e.ReplacementStrings[11])"
      Add-Content -Path "c:\temp\Output.csv" -Value $c
  }

  ###### Logoff ######
  if ($e.EventID -eq 4647 ){
      $d="Type: Logoff `tDate: $($e.TimeGenerated) `tStatus: Success`tUser: $($e.ReplacementStrings[2]) `tWorkstation: $($e.ReplacementStrings[11])"
      Add-Content -Path "c:\temp\Output.csv" -Value $d
  }
}
}
