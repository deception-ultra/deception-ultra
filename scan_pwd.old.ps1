Write-Host "######################################"
Write-Host "#                                    #"
Write-Host "#            deception-ultra         #"
Write-Host "#               1-24-2023            #"
Write-Host "#                                    #"
Write-Host "#  **  EDUCATIONAL USE ONLY  **      #"
Write-Host "#                                    #"
Write-Host "######################################"



# Define the directory to search for password files
$dir = "C:\"

# Define the regular expression to match against passwords
$regex = "(password|pwd|pass)"

# Search for files containing passwords
Get-ChildItem -Path $dir -Recurse -ErrorAction SilentlyContinue -ErrorVariable errors |
    Select-String -Pattern $regex -SimpleMatch |
    Group-Object Path |
    Select-Object Name, Count, @{Name="Passwords"; Expression={$_.Group | Select-Object -ExpandProperty Line}} |
    Export-Csv -Path "passwords.csv" -NoTypeInformation

# Check if there were any errors while scanning for passwords
if ($errors) {
    Write-Host "Access to the following directories was denied:" -ForegroundColor Yellow
    $errors.Path | ForEach-Object {Write-Host "  $_"}
}


#This script searches for files recursively starting at the C:\ directory and 
#outputs any potential passwords found to C:\passwords.txt. The regular expression 
#pattern used in this script is designed to match common password strings, such as
# password=1234 or password = "secret".
