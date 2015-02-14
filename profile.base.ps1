Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

Import-Module .\vagrant-status

function prompt {
    Write-VagrantStatus
    return "> "
}
