<#
.SYNOPSIS
SetupChocolatey.

.DESCRIPTION
Simple script to setup Chocolatey for a Windows development workstation.
Inspired by https://github.com/adityastic/Windows-Config
#>

$BasicPackages = -split "git vscode vlc powertoys microsoft-windows-terminal postman python telegram poshgit powershell-core lockhunter ilspy gimp nextcloud-client nmap notepad3 neovim lf docker-desktop"

function InstallChocolatey() {
    Write-Host "Installing Chocolatey"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
}

function InstallBasicPackages(){
    Write-Host "Chocolatey - Install basic packages"
    choco install -y $BasicPackages
}

function ScheduleUpgradeJob() {
    Import-Module PSScheduledJob
    Write-Host "Chocolatey - Create background task to upgrade all packages"
    $ScheduledJob = @{
        Name = "Chocolatey upgrade"
        ScriptBlock = {choco upgrade all -y}
        Trigger = New-JobTrigger -Weekly -DaysOfWeek Monday, Wednesday, Friday -At "15:00"
        ScheduledJobOption = New-ScheduledJobOption -RunElevated -MultipleInstancePolicy StopExisting -RequireNetwork -StartIfOnBattery -ContinueIfGoingOnBattery
    }
    Register-ScheduledJob @ScheduledJob
    $task = Get-ScheduledTask -TaskName "Chocolatey upgrade"
    $task.Principal = New-ScheduledTaskPrincipal -UserId "$($env:USERDOMAIN)\$($env:USERNAME)" -LogonType ServiceAccount -RunLevel Highest
    Set-ScheduledTask $task
}

function Show-Menu {
    param (
        [string]$Title = 'Chocolatey Setup'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    Write-Host "1: Install Chocolatey."
    Write-Host "2: Install basic packages."
    Write-Host "3: Create background task to upgrade all packages."
    Write-Host "q: Quit."
}

do
 {
    Show-Menu
    $selection = Read-Host "> "
    switch ($selection)
    {
        '1' { InstallChocolatey } 
        '2' { InstallBasicPackages } 
        '3' { ScheduleUpgradeJob }
    }
    pause
 }
 until ($selection -eq 'q')
