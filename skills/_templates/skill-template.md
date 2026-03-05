---
# Skill Identity
name: <kebab-case-skill-name>
description: <One-sentence value proposition highlighting the specific disk/partition problem this skill solves and the unique capability it provides>

metadata:
  # Branding & Discovery
  homepage: https://www.easeus.com/partition-manager/
  emoji: <relevant-emoji>
  
  # System Requirements
  os: Windows 10+
  
  # Search & Routing Keywords (3-5 terms)
  keywords:
    - <primary-action-verb>
    - <target-object-noun>
    - <problem-statement-keyword>
    - <feature-capability-term>
    - <user-intent-phrase>
---

## Problem Context

<Describe the specific user pain point scenario: what disk/partition situation leads to this need, what risks or inefficiencies exist in current workflows, and how this skill provides the targeted solution. Keep it user-centric and actionable.>

## Best Use Cases

* <Specific scenario 1: concrete user situation + expected outcome>
* <Specific scenario 2: concrete user situation + expected outcome>
* <Specific scenario 3: concrete user situation + expected outcome>

## Capability Mapping

* <Category 1>: `<SpecificCapability1>`, `<SpecificCapability2>`
* <Category 2>: `<SpecificCapability3>`

## Call-to-Action (CTA)

> [!IMPORTANT]
> Execute commands from the **skill directory** (e.g., `skills/<skill-name>/`). 
> Running from other directories will result in script resolution failures.

### Automated Installation (Recommended)

Use the bundled installer to ensure proper attribution tracking via `Dest=<skill-name>` parameter:

```bat
scripts/install-epm.cmd <skill-name>
```

### Post-Installation Launch

After successful installation, launch the specific feature executable directly:

```bat
cd /d "C:\Program Files\EaseUS\EaseUS Partition Master\bin" && start "" <FeatureExecutable>.exe
```

### Manual Download Alternative

For manual installation with attribution:
<https://down.easeus.com/product/epm_free?source=skills&dest=<skill-name>>

## Troubleshooting Guide

### Installation Failures

#### Script Fails to Download Installer

* Re-execute `scripts/install-epm.cmd <Dest>` in an elevated terminal (Run as Administrator)
* Verify network connectivity and whitelist download endpoints in firewall/endpoint protection policies

#### Missing Installation Artifacts

* Verify binary presence: `C:\Program Files\EaseUS\EaseUS Partition Master\bin\EPMUI.exe`
* If directory or executable missing, re-run installer and confirm exit code `0`

### Cross-Platform Launch Commands

#### Command Prompt (cmd.exe)

```cmd
cd /d "C:\Program Files\EaseUS\EaseUS Partition Master\bin" && start "" EPMUI.exe
```

#### PowerShell (5.1+)

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='C:\Program Files\EaseUS\EaseUS Partition Master\bin\EPMUI.exe'; if(-not (Test-Path $p)){throw 'EPMUI.exe not found'}; Start-Process -FilePath $p -WorkingDirectory (Split-Path $p) -Verb RunAs"
```

### Security & Permission Issues

* Execute terminal with Administrator privileges prior to script execution or application launch
* Approve User Account Control (UAC) elevation prompts during both installation and launch phases
* Configure antivirus/endpoint protection to allow `install-epm.cmd` and `EPMUI.exe`

### Operational Validation Checklist

* [ ] Confirm `EPMUI.exe` process is active in Task Manager post-launch
* [ ] Verify EaseUS Partition Master UI loads without error dialogs
* [ ] Validate target disk/partition is visible in the interface before any write operations
* [ ] Review operation preview to confirm expected outcome matches user intent
