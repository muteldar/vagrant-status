##Vagrant-Status

A PowerShell prompt modification that shows the basic status of [Vagrant](https://www.vagrantup.com/) machines in the current directory.

###Install Guide

1. Clone this repo
2. In PowerShell make sure that your ExecutionPolicy is Unrestricted
  * Get-ExecutionPolicy will show you current ExecutionPolicy.
  * Set-ExecutionPolicy Unrestricted will set your ExecutionPolicy to Unrestricted.
3. Run install.ps1 to install to your profile

###Prompt Explanation

The prompt is defined in the profile.base.ps1 which will output a working directory as well as a basic Vagrant status indicator.

If there are any active Vagrant machines you will see [^] on the powershell prompt. The ^ is colorized in green. If there is a vagrantfile and/or folder but no Vagrant machines active you will see [-].

###Other Info

The prompt was originally powered by Vagrant's "Vagrant Status" command however this has proven to be quite slow for use on a prompt. ~4-10 second rendering time between prompt display is a bit much. So for the time being that code has been left in but not used. If you want to try it out feel free to change "Write-VagrantStatus" to "Write-VagrantStatusVS" in profile.base.ps1

vagrant-status can be installed with posh-git from the following repo  [posh-git-vagrant-status](https://github.com/n00bworks/posh-git-vagrant-status)

###Based On

This project is heavily based on the great PowerShell prompt plug-in [posh-git](https://github.com/dahlbyk/posh-git)

###Contributing

 1. Fork it
 2. Create your feature branch (git checkout -b my-new-feature)
 3. Commit your changes (git commit -am 'Add some feature')
 4. Push to the branch (git push origin my-new-feature)
 5. Create a new Pull Request
