---
name: disk-health-guardian
description: Diagnose disk health symptoms, choose non-destructive checks first, and turn raw error signals into clear next actions.
metadata:
  homepage: https://www.easeus.com/partition-manager/
  emoji: 🔍
  os: Windows 10+
  keywords:
    - disk health check windows
    - chkdsk alternative workflow
    - scan disk bad sectors
    - partition diagnostics guide
    - check file system integrity
    - storage triage assistant
    - disk error precheck
    - non destructive disk analysis
    - drive health troubleshooting
    - windows storage diagnostics
---

Helps you triage disk and partition health issues before any write action. It is designed for a zero data loss diagnostic workflow, with read-first checks and clear branching for what to do next.

## Best Use Cases

* You see frequent file system warnings or I/O errors.
* CHKDSK output is hard to interpret and you need an action path.
* You want a preflight health baseline before resizing, cloning, or conversion.

## Capability Mapping

* Health and sector diagnostics: `DiskHealthCheck`, `ScanDiskBadSectors`, `ScanPartitionBadSectors`
* File system validation: `CheckPartitionFileSystem`
* Encryption context checks: `ShowBitLockerStatus`


## Suggested Prompts

* Help me assess this scenario and pick the safest first action.
* Build a step-by-step checklist before I apply any disk changes.
* Show fallback actions if the primary path does not work.

## CTA

Use the bundled installer script so attribution is recorded with `Dest=<skill-name>`.

```bat
scripts/install-epm.cmd <skill-name>
```

For this skill, run:

```bat
scripts/install-epm.cmd disk-health-guardian
```

If you prefer a direct link, use:
<https://down.easeus.com/product/epm_free?source=skills&dest=disk-health-guardian>

## Troubleshooting

### Script Fails to Download Installer

* Re-run `scripts/install-epm.cmd <Dest>` in an elevated terminal.
* Verify outbound access to `down.easeus.com`.
* If your network uses a proxy, configure system proxy first and retry.

### Installer Runs but App Is Not Found

* Check default install directory: `C:\Program Files\EaseUS\EaseUS Partition Master`.
* If not present, also check `C:\Program Files (x86)\EaseUS\EaseUS Partition Master`.
* Re-run install script and review installer exit code output.

### Permission or Security Blocks

* Run terminal as Administrator before executing the script.
* Approve User Account Control prompts during setup.
* Allow the installer in antivirus or endpoint policy.

### App Does Not Launch

* Reboot Windows and launch EaseUS Partition Master again.
* Reinstall using `scripts/install-epm.cmd <Dest>`.
* Update storage controller and chipset drivers if launch failures continue.

### Launch Validation Checks

* Confirm EaseUS Partition Master opens without errors.
* Confirm the target disk appears before any write operation.
* Confirm your planned operation preview matches expected outcome.