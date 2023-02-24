Write-Host "######################################"
Write-Host "#                                    #"
Write-Host "#            deception-ultra         #"
Write-Host "#               1-24-2023            #"
Write-Host "#                                    #"
Write-Host "######################################"

# Set up variables
$subnet = "192.168.1"
# Add or remove ports needed to check connection with
$ports = @(80, 443, 3389, 21, 22, 23, 25, 53, 67, 68, 110, 137, 139, 143, 161, 445, 465, 587, 993, 995)
$results = @()

# Loop through IP addresses and test connectivity and open ports
for ($i = 1; $i -le 255; $i++) {
    $ip = "$subnet.$i"
    $ping = Test-Connection -ComputerName $ip -Count 1 -Quiet
    if ($ping) {
        # Determine the operating system by checking the TTL value of the ping response
        $ttl = (Test-Connection -ComputerName $ip -Count 1).ipv4interface.interfaceindex
        if ($ttl -eq 1) {
            $os = "Windows"
        } else {
            $os = "Linux"
        }
        # Loop through each port and test for open or closed status
        foreach ($port in $ports) {
            $test = Test-NetConnection -ComputerName $ip -Port $port -WarningAction SilentlyContinue
            if ($test.TcpTestSucceeded) {
                $results += [PSCustomObject] @{
                    "IP" = $ip
                    "OS" = $os
                    "Port" = $port
                    "Status" = "Open"
                }
            } else {
                $results += [PSCustomObject] @{
                    "IP" = $ip
                    "OS" = $os
                    "Port" = $port
                    "Status" = "Closed"
                }
            }
        }
    }
}

# Export results to CSV file
$results | Export-Csv -Path "scan_results.csv" -NoTypeInformation
