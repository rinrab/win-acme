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
