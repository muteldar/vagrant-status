#
# Based on the great work by Posh-git!
#
# Vagrant status is slower then is resonable for a prompt to render. I am making some assumptions
# by scraping the .vagrant folder for any id files that should represent active/aborted some sort
# of Vagrant machine activity.
#
#
function Get-VagrantFile {
    $fileName = 'Vagrantfile'
    $base = Get-Item -Force .
    if ($base.PSProvider.Name -ne 'FileSystem'){
        return $FALSE
    }
    $vagrantFile = Join-Path $base.FullName $fileName
    if(Test-Path -LiteralPath $vagrantFile)
    {
        return $TRUE
    }
    return $FALSE
}

function Get-VagrantDir {
    $dirName = '.vagrant'
    $base = Get-Item -Force .
    if($base.PSProvider.Name -ne 'FileSystem'){
        return $FALSE
    }
    $vagrantDir = Join-Path $base.FullName $dirName
    if(Test-Path -LiteralPath $vagrantDir)
    {
        return $vagrantDir
    }
    return $FALSE
}

function Write-VagrantStatus {
    $vagrantFolder = Get-VagrantDir
    if(Test-Path $vagrantFolder)
    {
        $vagrantActive = $FALSE
        $items = Get-ChildItem -Path $vagrantFolder -Recurse -File -Filter 'id'
        foreach($item in $items)
        {
            if($item.ToString().Contains("id"))
            {
                $vagrantActive = $TRUE
            }
            else
            {
                $vagrantActive = $FALSE
            }
        }
        if($vagrantActive)
        {
            Write-Host($pwd.ProviderPath) -NoNewline
            Write-Host ' [' -NoNewline
            Write-Host '^' -ForegroundColor Green -NoNewline
            Write-Host ']' -NoNewline
        }
        else
        {
            Write-Host "PS " -NoNewline
            Write-Host($pwd.ProviderPath) -NoNewline
            Write-Host ' [' -NoNewline
            Write-Host '-' -ForegroundColor Gray -NoNewline
            Write-Host ']' -NoNewline

        }
    }
    elseif(Get-VagrantFile)
    {
      Write-Host "PS " -NoNewline
      Write-Host($pwd.ProviderPath) -NoNewline
      Write-Host ' [' -NoNewline
      Write-Host '-' -ForegroundColor Gray -NoNewline
      Write-Host ']' -NoNewline
    }
    else
    {
        Write-Host "PS " -NoNewline
        Write-Host($pwd.ProviderPath) -NoNewline
    }
}

#
# Vagrant Status Backed function
#
function Write-VagrantStatusVS {
    if(Get-VagrantFile)
    {
        $machineStatus = $null
        $n = 0
        $r = 0
        $a = 0
        $regex = '.+[)]'
        $status = vagrant status 2>$null
        $status = $status | Select-String -Pattern $regex 2>$null
        $statusSplit = ($status.ToString() -replace '\s{\(,}','|').Split('|')

        foreach($machine in $statusSplit)
        {
            $machineSplit = ($machine -replace '\s{1,}',',').Split(',')
            $machineStatus += $machineSplit[1]
        }

        foreach($item in $machineStatus)
        {
            switch($item){
                'aborted' { $a += 1; break}
                'not' {$n += 1; break}
                'running' {$r += 1; break}
                'poweroff' {$n += 1; break}
                default { break}
            }
        }
        Write-Host($pwd.ProviderPath) -NoNewline
        Write-Host '[' -NoNewline
        Write-Host "N:${n} " -ForegroundColor Gray -NoNewline
        Write-Host "R:${r} " -ForegroundColor Green -NoNewline
        Write-Host "A:${a}" -ForegroundColor DarkYellow -NoNewline
        Write-Host ']' -NoNewline
    }
    else
    {
      Write-Host "PS " -NoNewline
      Write-Host($pwd.ProviderPath) -NoNewline
    }
}
