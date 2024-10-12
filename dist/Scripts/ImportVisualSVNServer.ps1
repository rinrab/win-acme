<#
.SYNOPSIS
Imports a certificate from WASC renewal into VisualSVN Server.

.DESCRIPTION
Note that this script is intended to be run via the install script plugin
from WASC via the batch script wrapper. As such, we use positional parameters
to avoid issues with using a dash in the cmd line.

.PARAMETER PfxFile
File name in the CertificatePath.

.PARAMETER PfxPassword
(Central Certificate Store) Password of the .pfx file.

.EXAMPLE

./Scripts/ImportVisualSVNServer.ps1 '{CacheFile}' '{CachePassword}'

.NOTES
Set-SvnServerConfiguration PowerShell function help:
https://www.visualsvn.com/support/topic/00088/#Set-SvnServerConfiguration

This script requires a clean installation of VisualSVN Server.

#>

param(
    [Parameter(Position = 0, Mandatory = $true)]
    [string]
    $PfxFile,

    [Parameter(Position = 1, Mandatory = $true)]
    [string]
    $PfxPassword
)

Import-Module VisualSVN

$password = ConvertTo-SecureString $PfxPassword -AsPlainText -Force

$certData = Get-PfxData $PfxFile -Password $password
Set-SvnServerConfiguration -ServerCertificatePfx $certData.EndEntityCertificates.Export("Pfx")
