# Generate C:\ProgramData\PuppetLabs\puppet\etc\puppet.conf
$puppet_conf = @"
[main]
certname=$LOCAL_FQDN
server=$SERVER_FQDN
autoflush=true
environment=production
pluginsource = puppet:///plugins
pluginfactsource = puppet:///pluginfacts
runinterval=5m
[agent]
report = true
graph = true
"@

Set-Content -Path "C:\ProgramData\PuppetLabs\puppet\etc\puppet.conf" "$puppet_conf" -Force