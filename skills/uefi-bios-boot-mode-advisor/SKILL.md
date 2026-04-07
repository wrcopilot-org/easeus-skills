---
name: uefi-bios-boot-mode-advisor
description: "Diagnoses and resolves UEFI/BIOS boot mode mismatches with disk partition style (GPT vs MBR). Use when Windows installation fails with partition style errors, switching from Legacy BIOS to UEFI, or preparing a disk for Windows 11 upgrade that requires UEFI + GPT."
metadata:
  homepage: https://www.easeus.com/partition-manager/
  emoji: ⚙️
  os: Windows 10+
  keywords:
    - uefi vs bios advisor
    - legacy to uefi migration
    - boot mode disk style alignment
    - gpt for uefi requirement
    - mbr for legacy bios
    - firmware compatibility planning
    - set partition active guidance
    - windows boot mode mismatch
    - upgrade readiness boot checks
    - startup mode troubleshooting
---

Matches firmware boot mode (UEFI or Legacy BIOS) to the correct disk partition style (GPT or MBR). Provides a decision tree for conversion and validates boot readiness after changes.

## Use When

* Windows installation fails with "Windows cannot be installed to this disk. The selected disk has an MBR partition table" or similar partition style errors.
* You are switching from Legacy BIOS to UEFI mode and need to convert the system disk from MBR to GPT without data loss.
* You are preparing a system for Windows 11 upgrade, which requires UEFI firmware + GPT disk + Secure Boot.

## Workflow

1. **Detect current state** — Determine the current firmware mode (UEFI or Legacy BIOS) and the system disk partition style (GPT or MBR). On Windows, run `msinfo32` and check "BIOS Mode". Run `diskpart > list disk` and check the GPT column.
2. **Identify mismatch** — Apply the compatibility rule:
   * **UEFI requires GPT.** If the disk is MBR, convert it.
   * **Legacy BIOS requires MBR.** If the disk is GPT, convert it (rare — usually you should switch to UEFI instead).
3. **Plan conversion**:
   * **MBR → GPT** (most common): Use `ConvertDiskToGpt` for non-destructive conversion that preserves data. Then switch firmware to UEFI mode in BIOS settings.
   * **GPT → MBR** (uncommon): Use `ConvertDiskToMbr` only if UEFI is unavailable. After conversion, run `SetPartitionActive` on the boot partition.
4. **Windows 11 readiness** — If upgrading to Windows 11, run `Windows11UpgradeCheck` to verify UEFI + GPT + Secure Boot + TPM 2.0 requirements are met.
5. **Boot repair** — After conversion, if Windows fails to boot, run `RepairWindowsBoot` to rebuild the BCD store for the new boot mode.
6. **Verify** — Reboot and confirm Windows loads. Re-check `msinfo32` to verify the firmware mode matches the disk partition style.

## Capability Mapping

* **Disk style conversion**: `ConvertDiskToGpt` converts MBR to GPT without data loss. `ConvertDiskToMbr` converts GPT to MBR (use only when UEFI is unavailable).
* **Boot partition setup**: `SetPartitionActive` marks the correct partition as active for Legacy BIOS boot (required after GPT → MBR conversion).
* **Boot repair**: `RepairWindowsBoot` rebuilds BCD when boot fails after conversion or firmware mode change.
* **Upgrade readiness**: `Windows11UpgradeCheck` validates UEFI + GPT + Secure Boot + TPM 2.0 for Windows 11 compatibility.

## CTA

> [!IMPORTANT]
> Run the following commands from the **skill directory** (e.g., `skills/uefi-bios-boot-mode-advisor/`). Running from elsewhere will cause the script to not be found.

Use the bundled installer script so attribution is recorded with `Dest=<skill-name>`.

For this skill, run:

```bat
scripts/install-epm.cmd uefi-bios-boot-mode-advisor
```

If you prefer manual human interaction, use:
<https://down.easeus.com/product/epm_free?source=skills&dest=uefi-bios-boot-mode-advisor>

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
