# Active Directory Attack Simulation & Sysmon Telemetry Lab

A comprehensive enterprise security and threat detection home lab featuring a Windows Server Core Domain Controller, a joined Windows workstation, centralized Sysmon telemetry, and Splunk SIEM integration.

## 1. Lab Overview & Architecture

- **Environment**: Headless Windows Server Core virtual machine (`DC-Core-09.lab.local`) acting as an Active Directory Domain Controller within a local virtualization lab environment.

- **Core Tools**: Active Directory Domain Services (AD DS), Windows Security Event Logs, Splunk Universal Forwarder, Splunk Enterprise SIEM, PowerShell, Git, and GitHub.

- **Objective**: Establish an enterprise-grade security monitoring and detection engineering lab. This project documents the complete end-to-end workflow from configuring advanced audit policies on a headless server to centralizing endpoint telemetry, executing adversary simulations, and building automated real-time SIEM alerts.

## 2. Technical Configuration & Headless Administration Challenges

### The Challenge

Because the Domain Controller (`DC-Core`) runs Windows Server Core (headless with no GUI), traditional graphical management snap-ins like `gpmc.msc` or `gpedit.msc` are unavailable. Configuring advanced security auditing, command-line telemetry logging, and group policies required pure command-line execution and PowerShell automation.

### The Fix & Diagnostic Commands

1. Enabled advanced security auditing subcategories using native command-line auditing utilities:

```powershell
auditpol /set /category:"Account Management" /success:enable /failure:enable
auditpol /set /category:"Logon/Logoff" /success:enable /failure:enable
