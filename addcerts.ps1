<#
.SYNOPSIS
    Adds a certificate to the Trusted Root Certification Authorities store for the current user.

.DESCRIPTION
    This script imports a specified certificate file and adds it to the Trusted Root Certification Authorities store.

.PARAMETER CertPath
    The full path to the certificate file (.cer) to be added.

.EXAMPLE
    .\script.ps1 -CertPath "C:\path\to\certificate.cer"
    Adds the specified certificate to the Trusted Root Certification Authorities store.

.NOTES
    Author: Your Name
    Date: $(Get-Date -Format yyyy-MM-dd)
#>

param (
    [string]$CertPath
)

if (-not $CertPath) {
    Write-Host "Usage: .\script.ps1 -CertPath <path to certificate>" -ForegroundColor Yellow
    exit 1
}

# Check if the certificate file exists
if (!(Test-Path $CertPath)) {
    Write-Host "Certificate file not found: $CertPath" -ForegroundColor Red
    exit 1
}

try {
    # Import the certificate
    $Cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $CertPath

    # Open the Trusted Root Certification Authorities store for the current user
    $Store = New-Object System.Security.Cryptography.X509Certificates.X509Store "Root", "CurrentUser"
    $Store.Open("ReadWrite")

    # Add the certificate
    $Store.Add($Cert)
    Write-Host "Certificate added successfully to Trusted Root Certification Authorities store." -ForegroundColor Green
}
catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
}
finally {
    # Close the store
    if ($Store -ne $null) {
        $Store.Close()
    }
}
