$moduleName = 'DellBIOSProvider'

if (-not (Get-Module -ListAvailable $moduleName)) {
    Install-Module -Name $moduleName -Force -ErrorAction Stop
}

Import-Module $moduleName

function Get-IntelTMEStatus {
    $dellBIOSSettings = Get-ChildItem -Path 'DellSmbios:\PreEnabled' -ErrorAction SilentlyContinue

    if ($null -eq $dellBIOSSettings) {
        Write-Output "Dell BIOS settings not found"
        return
    }

    $intelTMEProperty = $dellBIOSSettings | Where-Object Attribute -Contains 'IntelTME'

    if ($null -eq $intelTMEProperty) {
        Write-Output "Intel TME is not supported"
        return 0
    }

    $intelTMEValue = Get-ItemPropertyValue -Path "DellSmbios:\PreEnabled\IntelTME" -Name 'CurrentValue' -ErrorAction Stop

    switch ($intelTMEValue) {
        'Disabled' {
            Write-Output "Intel TME is disabled"
            return 1
        }
        'Enabled' {
            Write-Output "Intel TME is enabled"
            return 0
        }
        default {
            Write-Output "Unexpected Intel TME value: $intelTMEValue"
            return 1
        }
    }
}

$status = Get-IntelTMEStatus
exit $status