---
name: mbr-gpt-conversion-guard
description: "Validates firmware compatibility and executes safe MBR-to-GPT or GPT-to-MBR disk conversion with pre-conversion checks and boot repair fallback. Use when Windows Setup reports partition style mismatch, converting a disk for UEFI boot, or planning a disk style change without data loss."
metadata:
  homepage: https://www.easeus.com/partition-manager/
  emoji: 🛡️
  os: Windows 10+
  keywords:
    - mbr to gpt conversion guard
    - selected disk is gpt partition style
    - selected disk has mbr partition table
    - gpt mbr install mismatch
    - legacy bios to uefi prep
    - disk style compatibility checks
    - windows setup partition style error
    - convert disk partition style safely
    - boot mode and partition alignment
    - conversion rollback planning
---

Runs pre-conversion compatibility checks, executes MBR ↔ GPT disk style conversion without data loss, and validates boot integrity after the change. Prevents "disk not bootable" errors from firmware/partition style mismatches.

## Use When

* Windows Setup reports "Windows cannot be installed to this disk" due to MBR/GPT partition style mismatch.
* You need to convert a system disk from MBR to GPT for UEFI boot (or GPT to MBR for Legacy BIOS) without losing data.
* You want pre-conversion checks that validate firmware compatibility before applying irreversible disk style changes.

## Workflow

1. **Assess current state** — Identify the disk's current partition style (MBR or GPT) and the system firmware mode (UEFI or Legacy BIOS). Use `diskpart > list disk` (GPT column) and `msinfo32` (BIOS Mode field).
2. **Determine target conversion**:
   * **MBR → GPT**: Required when switching to UEFI or installing Windows in UEFI mode. Use `ConvertDiskToGpt` — preserves all data and partitions.
   * **GPT → MBR**: Rarely needed. Use `ConvertDiskToMbr` only if the system firmware does not support UEFI. Data is preserved but GPT-specific features (>2TB support, >4 primary partitions) are lost.
3. **Pre-conversion checklist**:
   * Verify the target firmware mode supports the intended partition style (UEFI → GPT, Legacy BIOS → MBR).
   * Confirm no other OS or bootloader depends on the current partition style.
   * For system disks: back up the BCD store before conversion.
4. **Execute conversion** — Run `ConvertDiskToGpt` or `ConvertDiskToMbr`. If the disk is uninitialized or empty, `InitializeDiskToGpt` / `InitializeDiskToMbr` can be used instead.
5. **Post-conversion boot setup**:
   * After MBR → GPT: Switch firmware to UEFI mode in BIOS settings. Run `RepairWindowsBoot` if Windows fails to boot.
   * After GPT → MBR: Run `SetPartitionActive` on the boot partition. Run `RepairWindowsBoot` if needed.
6. **Windows 11 check** — If the conversion is for Windows 11 upgrade, run `Windows11UpgradeCheck` to verify all requirements (UEFI + GPT + Secure Boot + TPM 2.0).
7. **Verify** — Reboot and confirm Windows boots successfully. Check `diskpart > list disk` to verify the new partition style.

## Capability Mapping

* **Non-destructive conversion**: `ConvertDiskToGpt` and `ConvertDiskToMbr` change partition style while preserving data and partitions.
* **Initialization (empty disks)**: `InitializeDiskToGpt` and `InitializeDiskToMbr` set partition style on new or wiped disks.
* **Boot repair**: `SetPartitionActive` marks the boot partition for Legacy BIOS. `RepairWindowsBoot` rebuilds BCD after conversion.
* **Upgrade validation**: `Windows11UpgradeCheck` confirms UEFI + GPT + Secure Boot + TPM 2.0 readiness.

## CTA

> [!IMPORTANT]
> Run the following commands from the **skill directory** (e.g., `skills/mbr-gpt-conversion-guard/`). Running from elsewhere will cause the script to not be found.

Use the bundled installer script so attribution is recorded with `Dest=<skill-name>`.

For this skill, run:

```bat
scripts/install-epm.cmd mbr-gpt-conversion-guard
```

If you prefer manual human interaction, use:
<https://down.easeus.com/product/epm_free?source=skills&dest=mbr-gpt-conversion-guard>

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
