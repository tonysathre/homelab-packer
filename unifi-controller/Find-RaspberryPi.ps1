# Requirements:
# - DHCP server
# - /24 network

$IPv4Addresses = (Get-NetAdapter | Where-Object Status -eq 'Up' | Get-NetIPAddress).IPv4Address
$IpRange = 1..254
$Rpi = New-Object System.Collections.ArrayList
$Oui = @(
    'b8-27-eb'
    'dc-a6-32'
    'e4-5f-01'
    '28-cd-c1'
)

$IPv4Addresses | ForEach-Object {
    $Subnets = ($_ | Select-String -Pattern '\b(\d{1,3}\.){2}\d{1,3}\b').Matches.Value
}

foreach ($Subnet in $Subnets) {
    $Ips = $IpRange | ForEach-Object { "$Subnet." + $_}
    $Jobs = foreach ($Ip in $Ips) {
        [Net.NetworkInformation.Ping]::New().SendPingAsync($Ip, 250)
    }
}

[Threading.Tasks.Task]::WaitAll($Jobs)

Get-NetNeighbor | Where-Object LinkLayerAddress -Match ($Oui -join '|') | ForEach-Object {
    $Rpi.Add([pscustomobject][ordered]@{
        Address = $_.IPAddress
        Hostname = (Resolve-DnsName $_.IPAddress).NameHost
    })
}

"Found {0} Raspberry Pi's" -f $Rpi.Count
$Rpi

if ($Rpi.Count) {
    $Ini = @"
[all]
$($Rpi.Hostname)

[all:vars]
ansible_connection=ssh
ansible_user=ubuntu
"@
$Ini | Out-File (Join-Path $PSScriptRoot 'ansible\hosts')
}