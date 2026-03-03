---
name: boot-recovery-and-repair-helper
description: Recover non-booting Windows systems with staged boot repair, media creation, and partition recovery decision paths.
metadata:
  homepage: https://www.easeus.com/partition-manager/
  emoji: ⚙️
  os: Windows 10+
  keywords:
    - windows boot recovery helper
    - computer will not boot fix
    - rebuild mbr workflow
    - repair windows boot records
    - create bootable usb recovery
    - preos repair environment
    - lost partition boot recovery
    - startup black screen triage
    - no boot troubleshooting plan
    - emergency boot repair steps
---

Provides a staged no-boot recovery flow, from diagnostics to boot repair and media-assisted recovery. It emphasizes risk-aware sequencing and explicit stop points when full restoration is uncertain.

## Best Use Cases

* Windows fails to boot after partition or update changes.
* You need bootable media to access repair tools.
* MBR damage or lost partition symptoms block startup.

## Capability Mapping

* Core repair actions: `RepairWindowsBoot`, `RebuildMbr`, `RecoverLostPartition`
* Recovery environment setup: `CreateBootableISO`, `CreateBootableUsbByDriveLetter`, `CreateBootableUsbByDisk`
* Offline workflow controls: `InstallAndEnablePreOS`, `DisablePreOS`


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
scripts/install-epm.cmd boot-recovery-and-repair-helper
```

If you prefer a direct link, use:
<https://down.easeus.com/product/epm_free?source=skills&dest=boot-recovery-and-repair-helper>

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