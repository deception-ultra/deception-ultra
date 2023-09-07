# Generate a random password of length 12
$password = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 12 | % {[char]$_})

Write-Output "Random password: $password"
