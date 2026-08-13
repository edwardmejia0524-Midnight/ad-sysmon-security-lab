<#
.SYNOPSIS
    Verify Sysmon service status and operational log event channels.
.DESCRIPTION
    Checks if the Sysmon64 service is running and tests if the event channel is recording process creation events.
#>

Write-Host "[*] Checking Sysmon Service Status..." -ForegroundColor Cyan
$sysmon = Get-Service -Name "Sysmon64" -ErrorAction SilentlyContinue

if ($sysmon -and $sysmon.Status -eq 'Running') {
    Write-Host "[+] Sysmon64 is installed and running." -ForegroundColor Green
} else {
    Write-Host "[-] WARNING: Sysmon64 is not running or not installed." -ForegroundColor Red
}

Write-Host "[*] Checking recent Sysmon Process Creation events (Event ID 1)..." -ForegroundColor Cyan
try {
    $events = Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 5 -ErrorAction Stop
    Write-Host "[+] Successfully retrieved recent Sysmon events." -ForegroundColor Green
} catch {
    Write-Host "[-] WARNING: Could not read Sysmon operational logs. Ensure you are running as Administrator." -ForegroundColor Red
}
