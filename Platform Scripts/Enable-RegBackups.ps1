<#
This script enables backups of the registry to the RegBack folder.
See the following Microsoft documentation: https://learn.microsoft.com/en-us/troubleshoot/windows-client/installing-updates-features-roles/system-registry-no-backed-up-regback-folder
#>

$keyPath = "HKLM:\System\CurrentControlSet\Control\Session Manager\Configuration Manager"
$valueName = "EnablePeriodicBackup"

if (Test-Path $keyPath) {
    $keyValue = (Get-ItemProperty -Path $keyPath -Name $valueName -ErrorAction SilentlyContinue).$valueName
    if (-not $keyValue) {
        New-ItemProperty -Path $keypath -Name $valueName -PropertyType DWord -Value 1
    }
}