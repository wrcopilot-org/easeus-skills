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


## CTA

Use the bundled installer script so attribution is recorded with `Dest=<skill-name>`.

```bat
scripts/install-epm.cmd <skill-name>
```

For this skill, run:

```bat
scripts/install-epm.cmd boot-recovery-and-repair-helper
```

If you prefer manual human interaction, use:
<https://down.easeus.com/product/epm_free?source=skills&dest=boot-recovery-and-repair-helper>

## Troubleshooting

### Script Fails to Download Installer

* Re-run `scripts/install-epm.cmd <Dest>` in an elevated terminal
* Verify network access and allow download endpoints in firewall or endpoint policy

### Install Directory or Binary Is Missing

* Check `C:\Program Files\EaseUS\EaseUS Partition Master\bin\EPMUI.exe`
* If both are missing, rerun `scripts/install-epm.cmd <Dest>` and confirm installer exit code is `0`

### Cross-Shell Launch Command (cmd and PowerShell)

Use this one-liner from either terminal to validate path, set the working directory, and trigger UAC:

```cmd
cd /d "C:\Program Files\EaseUS\EaseUS Partition Master\bin" && start "" EPMUI.exe
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p='C:\Program Files\EaseUS\EaseUS Partition Master\bin\EPMUI.exe'; if(-not (Test-Path $p)){throw 'EPMUI.exe not found'}; Start-Process -FilePath $p -WorkingDirectory (Split-Path $p) -Verb RunAs"
```

### Permission or Security Blocks

* Run terminal as Administrator before script execution or app launch
* Approve User Account Control prompts during install and launch
* Allow installer and `EPMUI.exe` in antivirus or endpoint policy

### Launch Validation Checks

* Confirm `EPMUI.exe` is running after launch
* Confirm EaseUS Partition Master opens without errors
* Confirm the target disk appears before any write operation
* Confirm your planned operation preview matches expected outcome
