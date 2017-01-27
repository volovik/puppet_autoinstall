$computers = Get-Content C:\_cmd\puppet_autoinstall\computers.txt

foreach ($computer in $computers)
{
Invoke-Command -ComputerName $computer -ScriptBlock {hostname | Write-Host -BackgroundColor DarkYellow -ForegroundColor DarkRed};
Write-Host Copy files
Copy-Item -Destination \\$computer\c$\_cmd\ -path "C:\_cmd" -Recurse -Force ;
Invoke-Command -ComputerName $computer -ScriptBlock {Set-ExecutionPolicy -ExecutionPolicy RemoteSigned};
Invoke-Command -ComputerName $computer -ScriptBlock {Get-ExecutionPolicy};
Invoke-Command -ComputerName $computer -ScriptBlock {C:\_cmd\puppet_autoinstall\puppet_agent_autoinstall_main.ps1};
}
