Write-Host "######################################"
Write-Host "#                                    #"
Write-Host "#            deception-ultra         #"
Write-Host "#               1-24-2023            #"
Write-Host "#                                    #"
Write-Host "#  **  EDUCATIONAL USE ONLY  **      #"
Write-Host "#                                    #"
Write-Host "######################################"

# Set up the progress bar
$totalFiles = @(Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue).Count
$i = 0
Write-Progress -Activity "Scanning files for passwords" -Status "Initializing..." -PercentComplete 0

# Scan for passwords
Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
    $i++
    Write-Progress -Activity "Scanning files for passwords" -Status "File $($i) of $($totalFiles)" -PercentComplete (($i / $totalFiles) * 100)

    # Search for passwords in the file
    $fileContent = Get-Content $_.FullName -ErrorAction SilentlyContinue
    if ($fileContent -match "password") {
        Write-Output "$($_.FullName) contains a password."
    }
}

# Clear the progress bar
Write-Progress -Activity "Scanning files for passwords" -Completed
