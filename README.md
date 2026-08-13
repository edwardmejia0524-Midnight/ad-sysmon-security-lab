# Active Directory Attack Simulation & Sysmon Telemetry Lab

A comprehensive enterprise security and threat detection home lab featuring a Windows Server Core Domain Controller, a joined Windows workstation, centralized Sysmon telemetry, and Splunk SIEM integration.

## Architecture Overview
* **Domain Controller:** Windows Server 2022 Core (AD DS, DNS)
* **Endpoint Workstation:** Windows 10/11 Client (Sysmon monitoring enabled)
* **SIEM / Log Analysis:** Ubuntu Server running Splunk Enterprise

## Directory Structure
* `configs/` - Customized Sysmon configuration files and hardening profiles.
* `queries/` - SPL (Search Processing Language) queries for hunting lateral movement and privilege escalation.
* `playbooks/` - Standard operating procedures and step-by-step attack simulation guides.
* `scripts/` - Automation and helper scripts for log analysis or event parsing.
