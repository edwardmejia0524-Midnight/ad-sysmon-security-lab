# Attack Simulation & Telemetry Verification Playbook

## Phase 1: Baseline Verification
1. Verify Sysmon service is running on the Windows Client (`Get-Service Sysmon64`).
2. Verify logs are forwarding cleanly to the Ubuntu Splunk instance.

## Phase 2: Simulated Techniques
* **Execution & Living off the Land:** Run encoded PowerShell scripts to test Event ID 1 logging.
* **Credential Access:** Simulate memory dumping or credential enumeration to trigger Sysmon Event ID 10 alerts on LSASS.
* **Lateral Movement:** Use PsExec or WinRM to test session authentication logs on the Domain Controller (Event ID 4624 / 4672).
