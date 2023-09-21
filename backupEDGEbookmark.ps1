# The script is used to backup Microsoft Edge bookmarks to a destination of your choice in HTML format.

# Define the path where Edge stores bookmarks by default.
$sourcePath = "$env:USERPROFILE\AppData\Local\Microsoft\Edge\User Data\Default\Bookmarks"

# Define the destination path for the backup.  Need to adjust to path you want it to save too.
$destinationPath = "C:\Users\xxxxxxxx\xxxxxx\Bookmarks\Bookmarks_Backup.html"

# Recursive function to traverse the bookmarks, including all nested folders
function ProcessBookmarks($bookmarks) {
    $htmlContent = ""

    foreach ($bookmark in $bookmarks) {
        if ($bookmark.type -eq "url") {
            $htmlContent += "<li><a href='" + $bookmark.url + "'>" + $bookmark.name + "</a></li>`n"
        } elseif ($bookmark.type -eq "folder") {
            $htmlContent += "<li>" + $bookmark.name + "<ul>`n"
            $htmlContent += ProcessBookmarks($bookmark.children)
            $htmlContent += "</ul></li>`n"
        }
    }

    return $htmlContent
}

# Check if the source file exists.
if (Test-Path $sourcePath) {

    # Load the JSON content from the source path.
    $jsonContent = Get-Content -Path $sourcePath | ConvertFrom-Json

    # Extract the bookmarks from the JSON content.
    $bookmarks = $jsonContent.roots.bookmark_bar.children

    # Define the starting HTML content.
    $htmlContent = @"
<html>
<head>
    <title>Edge Bookmarks Backup</title>
</head>
<body>
    <ul>
"@

    # Process each bookmark and append to the HTML content.
    $htmlContent += ProcessBookmarks($bookmarks)

    # End the HTML content.
    $htmlContent += @"
    </ul>
</body>
</html>
"@

    # Write the HTML content to the destination path.
    $htmlContent | Out-File -Encoding utf8 $destinationPath
    }

    # Used to exit for Task scheduler
    exit

    # Inform the user of the successful backup.
    
    #Write-Output "Bookmarks backed up successfully to $destinationPath"
    
#} else {
#    Write-Output "Edge bookmarks file not found. Ensure Edge is installed and has been run at least once."
#}
