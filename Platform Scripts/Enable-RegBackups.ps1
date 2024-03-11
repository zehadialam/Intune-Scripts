<#
This script enables backups of the registry to the RegBack folder.
See the following Microsoft documentation: https://learn.microsoft.com/en-us/troubleshoot/windows-client/installing-updates-features-roles/system-registry-no-backed-up-regback-folder
#>

$keyPath = "HKLM:\System\CurrentControlSet\Control\Session Manager\Configuration Manager"
$valueName = "EnablePeriodicBackup"

if (Test-Path $keyPath) {
    $keyValue = (Get-ItemProperty -Path $keyPath -Name $valueName -ErrorAction SilentlyContinue).$valueName
    if ($null -eq $keyValue) {
        New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Session Manager\Configuration Manager" -Name "EnablePeriodicBackup" -PropertyType DWord -Value 1
    }
}