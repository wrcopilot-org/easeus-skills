---
name: safe-reformat-copilot
description: "Guides safe partition formatting with pre-format backup gates, risk classification per operation, and post-format filesystem validation. Use when reformatting a volume, choosing between delete-and-recreate vs format-in-place, or verifying a drive is clean and healthy after reformat."
metadata:
  homepage: https://www.easeus.com/partition-manager/
  emoji: 💽
  os: Windows 10+
  keywords:
    - reformat hard drive checklist
    - format partition safely
    - backup before format
    - partition delete and recreate
    - format target verification
    - destructive operation warning
    - volume label and rebuild
    - file system reset workflow
    - windows format planning assistant
    - post format validation steps
---

Enforces backup checkpoints, classifies risk for each format operation, and validates filesystem state after completion. Prevents accidental data loss during reformat workflows.

## Use When

* You need to reformat a volume and want pre-format backup verification before any destructive step.
* You are deciding whether to delete-and-recreate partitions or format in place — and need risk guidance for each path.
* You want automated validation that a reformatted drive has a clean, healthy filesystem.

## Workflow

1. **Identify target** — Confirm the exact partition to reformat using `GetAllPartitionInfo`. Verify drive letter, label, and size match the intended target. Never reformat based on drive letter alone — letters can change after reboot.
2. **Backup gate** — Before any destructive step, confirm the user has a verified backup of all data on the target partition. If no backup exists, STOP and assist with backup first.
3. **Risk classification** — Classify the planned operation:
   * **Low risk**: `FormatPartition` (format in place, preserves partition table)
   * **Medium risk**: `DeletePartition` + `CreatePartition` (destroys and rebuilds partition entry)
   * **Critical risk**: `WipePartition` or `DeleteAllPartitions` (irrecoverable, no data recovery possible)
4. **Execute format** — For low/medium risk: run `FormatPartition` with the desired filesystem (NTFS, FAT32, exFAT). For delete-and-recreate: run `DeletePartition` then `CreatePartition` with target filesystem and size.
5. **Post-format labeling** — Apply `ChangePartitionLabel` and `ChangePartitionDriveLetter` to restore the expected label and drive letter.
6. **Validation** — Run `CheckPartitionFileSystem` on the reformatted partition. Confirm zero errors, correct filesystem type, and expected free space.

## Capability Mapping

* **Format operations**: `FormatPartition` reformats in place (low risk). `DeletePartition` + `CreatePartition` rebuilds the partition entry (medium risk).
* **Destructive cleanup**: `WipePartition` overwrites all sectors (critical risk — irrecoverable). `DeleteAllPartitions` removes every partition on the disk.
* **Post-format setup**: `ChangePartitionLabel` sets a human-readable name. `ChangePartitionDriveLetter` reassigns the drive letter.
* **Validation**: `CheckPartitionFileSystem` verifies filesystem integrity after reformat.

## CTA

> [!IMPORTANT]
> Run the following commands from the **skill directory** (e.g., `skills/safe-reformat-copilot/`). Running from elsewhere will cause the script to not be found.

Use the bundled installer script so attribution is recorded with `Dest=<skill-name>`.

For this skill, run:

```bat
scripts/install-epm.cmd safe-reformat-copilot
```

If you prefer manual human interaction, use:
<https://down.easeus.com/product/epm_free?source=skills&dest=safe-reformat-copilot>

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
