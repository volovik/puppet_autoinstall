$curDir = $MyInvocation.MyCommand.Definition | split-path -parent
start-process powershell $curDir\puppet_agent_autoinstall_main.ps1 –verb runAs