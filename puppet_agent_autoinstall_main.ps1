#VARIABLES
$LOCAL_FQDN = (Get-WmiObject win32_computersystem).DNSHostName+"."+(Get-WmiObject win32_computersystem).Domain
$LOCAL_FQDN = $LOCAL_FQDN.ToLower()
$SERVER_FQDN = "puppet.domain.local"
$SERVER_FQDN = $SERVER_FQDN.ToLower()
write-host $LOCAL_FQDN
Write-Host $SERVER_FQDN
$folder = "C:\_cmd\puppet_autoinstall"

$installer_x32 = "$folder" + "\" + "puppet-agent-x86-latest.msi"
$installer_x64 = "$folder" + "\" + "puppet-agent-x64-latest.msi"

$time = Get-Date -Format U

# Download latest release. May be disabled.
$release_downloader = "$folder" + "\" + "puppet_agent_latest_rellease_download.ps1"
include .\puppet_agent_latest_rellease_download.ps1
#."$release_downloader"


# Detect system platform
$bit = Get-WmiObject Win32_OperatingSystem
$bit = $bit.OSArchitecture


if ($bit -like "64*") {

    Write-Host -BackgroundColor Green - "This system is 64-bit."
    $install_64 = "$folder" + "\" + "install_x64.ps1"
    #include .\install_x64.ps1
    ."$install_64"

}

elseif ($bit -like "32*") {

    Write-Host -BackgroundColor DarkGreen  "This system is 32-bit."
    $install_32 = "$folder" + "\" + "install_x64.ps1"
    #include .\install_x32.ps1
    ."$install_32"
}

else {
    Write-Host -BackgroundColor Red "Error detect system"

} 

# stop puppet agent service
Start-Sleep -Seconds 10
Stop-Service -Name "puppet"
Start-Sleep -Seconds 10

# Generate puppet agent config file
# Default path to puppet config file look like as C:\ProgramData\PuppetLabs\puppet\etc\puppet.conf
$conf_gen = "$folder" + "\" + "puppet_agent_conf_generator.ps1"
# include .\puppet_agent_conf_generator.ps1
Write-Host "Sleep 1 min"
Start-Sleep -Seconds 60
."$conf_gen"

# start puppet agent service
Start-Sleep -Seconds 10
Start-Service -Name "puppet"
Start-Sleep -Seconds 10

Start-Process -FilePath 'C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat' -ArgumentList "agent --test --waitforcert 5"; Write-Host -BackgroundColor Yellow "Puppet agent process done"


#include .\end.ps1
    $end = "$folder" + "\" + "end.ps1"
    #include .\end.ps1
    ."$end"
