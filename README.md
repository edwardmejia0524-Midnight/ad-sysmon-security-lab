# Active Directory Attack Simulation & Sysmon Telemetry Lab

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
```

2. Configured registry-level auditing keys directly through PowerShell to enable full process command-line logging (EventCode 4688):

```powershell
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit" -Name "ProcessCreationIncludeCmdLine_Enabled" -Value 1
```

3. Verified active logging policies and tested local network loopback authentication failure tracking:

```powershell
auditpol /get /category:*
```

## 3. Core Security Telemetry & SPL Queries

### Account Lifecycle Management (EventCode 4720)

**Purpose:** Tracks the creation of new user accounts, assisting SOC analysts in identifying unauthorized persistence mechanisms or shadow administrative accounts.

**SPL Query:**

```spl
host=DC-Core EventCode=4720
```

### Authentication & Brute-Force Indicators (EventCode 4625)

**Purpose:** Captures failed logon attempts and unauthorized access loops. Validated via loopback testing (127.0.0.1) using incorrect credentials.

**SPL Query:**

```spl
host=DC-Core EventCode=4625
```

### Privilege Escalation (EventCode 4728)

**Purpose:** Monitors high-risk modifications to privileged security groups. Triggered by adding test accounts (e.g., `TestSecUser`) to the Domain Admins group.

**SPL Query:**

```spl
host=DC-Core EventCode=4728
```

### Endpoint Telemetry & Command-Line Auditing (EventCode 4688)

**Purpose:** Tracks adversary execution patterns, binaries, and command-line arguments using advanced process creation auditing.

**SPL Query:**

```spl
host=DC-Core EventCode=4688
```

## 4. Detection Engineering & Real-Time Alerting

To bridge the gap between raw log collection and proactive defense, a production-grade correlation search was configured directly within Splunk Enterprise:

**Alert Title:** High-Risk Security Alert - User Added to Domain Admins

**Description:** Detects when a security-enabled high-privilege group like Domain Admins is modified, flagging potential privilege escalation or persistence activity.

**Configuration Parameters:**

| Parameter | Value |
|---|---|
| Alert Type | Real-time |
| Trigger Condition | Number of results is Greater than 0 |
| Permissions | Shared in App |

## 5. Simulation & Verification Evidence

**PowerShell Execution Proofs:**

- Local network loopback authentication tests returning authentication failure codes for event logging.
- Group modification execution via `Add-ADGroupMember`.
- Advanced auditing policies enabled via `auditpol` and registry updates for command-line logging.

**Splunk SIEM Validation:**

- Confirmed indexing and field extraction across all tracked event codes (4720, 4625, 4728, and 4688) originating from `host=DC-Core`.

## 6. Repository Structure & Version Control Setup Steps

### Repository Initialization and Remote Push Steps Performed

1. Created project directory layout:

```bash
mkdir -p ~/ad-sysmon-security-lab/{configs,playbooks,queries,scripts}
cd ~/ad-sysmon-security-lab
git init
```

2. Staged and committed initial project files to local version control:

```bash
git add .
git commit -m "Initial commit of Active Directory attack simulation and telemetry lab"
```

3. Configured remote repository tracking and pushed to the main branch:

```bash
git remote add origin https://github.com/edwardmejia0524-Midnight/ad-sysmon-security-lab.git
git branch -M main
git push -u origin main
```

### File & Directory Descriptions

| Path | Description |
|---|---|
| `README.md` | Comprehensive technical project documentation, architectural overview, and lab implementation steps. |
| `configs/` | Group policy and audit configuration templates. |
| `playbooks/` | Step-by-step incident response and simulation runbooks. |
| `queries/` | Reusable Search Processing Language (`.spl`) files. |
| `scripts/` | PowerShell helper scripts for testing and telemetry validation. |
Displaying README.md.
