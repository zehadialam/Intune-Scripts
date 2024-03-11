Import-Module DellBIOSProvider
Set-Item -Path DellSmbios:\PreEnabled\IntelTME -Value Enabled
Write-Output "Intel TME is enabled"
exit 0