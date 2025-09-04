# Add the necessary .NET assembly for screen capture
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Get the screen's dimensions
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$width = $screen.Width
$height = $screen.Height

# Create a bitmap to hold the screen capture
$bitmap = New-Object System.Drawing.Bitmap($width, $height)

# Create a graphics object from the bitmap
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

# Copy the screen to the bitmap
$graphics.CopyFromScreen($screen.Location, [System.Drawing.Point]::Empty, $screen.Size)

# Prompt the user for a base file name
$baseName = Read-Host -Prompt "Enter a name for the screenshot file (e.g., my_screenshot)"

# Define the user's Pictures directory
$picturesPath = [Environment]::GetFolderPath("MyPictures")

# Get the current date in YYYYMMDD format
$date = Get-Date -Format "yyyyMMdd"

# Construct the initial file path with the base name and date
$fileName = "$baseName-$date"
$filePath = Join-Path -Path $picturesPath -ChildPath "$fileName.png"

# Check for existing files and add an incrementing number if a conflict is found
$counter = 1
while (Test-Path -Path $filePath) {
    # If the file exists, update the filename with an incrementing counter (e.g., my_screenshot-20250904_001.png)
    $counterPadded = "{0:D3}" -f $counter
    $filePath = Join-Path -Path $picturesPath -ChildPath "$baseName-$date-$counterPadded.png"
    $counter++
}

# Save the bitmap to the file
$bitmap.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)

# Display a confirmation message
Write-Host "Screenshot saved successfully to: $filePath"
