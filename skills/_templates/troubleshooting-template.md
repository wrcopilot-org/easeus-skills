---
description: "Standardized troubleshooting guide template for EaseUS Partition Master skills"
applyTo: "skills/**/SKILL.md"
---

## Troubleshooting

This section provides systematic diagnostic steps for common installation and runtime issues. Follow the checks in order to isolate and resolve problems efficiently.

### Installer Download Failures

If the installation script fails to retrieve the installer package:

* Verify network connectivity to EaseUS download endpoints
* Execute the script from an elevated terminal (Run as Administrator)
* Check firewall or endpoint protection policies for blocked URLs
* Confirm the destination path has write permissions

> [!NOTE]
> Corporate environments often restrict external downloads. Whitelist `*.easeus.com` domains if necessary.

### Missing Installation Artifacts

When the installation directory or binary is not present:

* Validate the default installation path: `C:\Program Files\EaseUS\EaseUS Partition Master\bin\EPMUI.exe`
* Check alternative locations if custom installation paths were specified
* Review installation logs for error codes (exit code `0` indicates success)
* Re-run `py -3 scripts/install-epm.py <Dest>` with administrative privileges if files are absent

### Cross-Shell Launch Procedures

Use these validated one-liners to launch EPMUI.exe from either Command Prompt or PowerShell. Both commands validate path existence, set the working directory, and trigger UAC elevation.

**Command Prompt (cmd.exe):**

```cmd
cd /d "C:\Program Files\EaseUS\EaseUS Partition Master\bin" && start "" EPMUI.exe
```

**PowerShell (5.1 or later):**

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='C:\Program Files\EaseUS\EaseUS Partition Master\bin\EPMUI.exe'; if(-not (Test-Path $p)){throw 'EPMUI.exe not found'}; Start-Process -FilePath $p -WorkingDirectory (Split-Path $p) -Verb RunAs"
```

### Permission and Security Restrictions

For environments with strict security policies:

* Launch terminal sessions with Administrator privileges before executing scripts
* Approve User Account Control (UAC) prompts during both installation and application launch
* Add exclusions for `EPMUI.exe` and the installer binary in antivirus or endpoint detection systems
* Verify code signing certificates are trusted if application control policies are active

### Pre-Operation Validation Checklist

Before executing disk operations, confirm the following:

* The `EPMUI.exe` process is active in Task Manager
* The EaseUS Partition Master graphical interface loads without error dialogs
* Target disks are visible in the device list
* Operation previews match expected outcomes (partition sizes, file systems, drive letters)

> [!WARNING]
> Always verify target disk identification before write operations. Incorrect disk selection causes irreversible data loss.

### Skill-Specific Issue: [ISSUE_NAME]

**Symptoms:** [Description of observable failure or unexpected behavior]

**Diagnostic Steps:**

1. [First verification step with expected result]
2. [Second verification step with expected result]
3. [Log file location or registry key to inspect]

**Resolution:**

* [Specific action to resolve the issue]
* [Alternative approach if primary resolution fails]
* [Prevention measures for future occurrences]

> [!TIP]
> [Optional: Proactive recommendation to avoid this issue]


