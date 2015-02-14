if (Get-Module vagrant-status)
{
    return
}

Push-Location $PSScriptRoot
. .\VagrantUtils.ps1
Pop-Location

Export-ModuleMember -Function Get-VagrantFile, Write-VagrantStatus, Write-VagrantStatusVS
