# Add the necessary .NET assembly
Add-Type -AssemblyName System.Windows.Forms

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

# Prompt the user for a file name
$fileName = Read-Host -Prompt "Enter a name for the screenshot file (e.g., my_screenshot)"

# Define the user's Pictures directory
$picturesPath = [Environment]::GetFolderPath("MyPictures")

# Construct the full file path
$filePath = Join-Path -Path $picturesPath -ChildPath "$fileName.png"

# Save the bitmap to the file
$bitmap.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)

# Display a confirmation message
Write-Host "Screenshot saved successfully to: $filePath"
