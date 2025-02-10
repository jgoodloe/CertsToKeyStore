<#
.SYNOPSIS
    Adds all .crt certificates from a specified directory to the Trusted Root Certification Authorities store for the current user.

.DESCRIPTION
    This script scans a specified directory for all .crt files and adds them to the Trusted Root Certification Authorities store.

.PARAMETER CertDir
    The full path to the directory containing the .crt certificate files to be added.

.EXAMPLE
    .\script.ps1 -CertDir "C:\path\to\certificates"
    Adds all .crt files from the specified directory to the Trusted Root Certification Authorities store.

.NOTES
    Author: Your Name
    Date: $(Get-Date -Format yyyy-MM-dd)
#>

param (
    [string]$CertDir
)

if (-not $CertDir -or !(Test-Path $CertDir)) {
    Write-Host "Usage: .\script.ps1 -CertDir <path to directory>" -ForegroundColor Yellow
    exit 1
}

# Get all .crt files in the directory
$CertFiles = Get-ChildItem -Path $CertDir -Filter "*.crt" -File

if ($CertFiles.Count -eq 0) {
    Write-Host "No .crt files found in the directory: $CertDir" -ForegroundColor Yellow
    exit 0
}

try {
    # Open the Trusted Root Certification Authorities store for the current user
    $Store = New-Object System.Security.Cryptography.X509Certificates.X509Store "Root", "CurrentUser"
    $Store.Open("ReadWrite")

    foreach ($CertFile in $CertFiles) {
        try {
            # Import the certificate
            $Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $CertFile.FullName
            
            # Add the certificate
            $Store.Add($Cert)
            Write-Host "Certificate added successfully: $($CertFile.FullName)" -ForegroundColor Green
        }
        catch {
            Write-Host "Failed to add certificate: $($CertFile.FullName). Error: $_" -ForegroundColor Red
        }
    }
}
catch {
    Write-Host "An error occurred while processing certificates: $_" -ForegroundColor Red
}
finally {
    # Close the store
    if ($Store -ne $null) {
        $Store.Close()
    }
}