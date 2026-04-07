---
name: post-migration-validator
description: "Validates boot integrity, partition consistency, and baseline performance after cloning or migrating a disk. Use when a cloned SSD boots inconsistently, partitions show mismatched sizes after migration, or you need a structured post-cutover checklist before decommissioning the source drive."
metadata:
  homepage: https://www.easeus.com/partition-manager/
  emoji: 🔍
  os: Windows 10+
  keywords:
    - post migration validation
    - cloned ssd boot verification
    - partition parity audit
    - after clone health checks
    - boot repair fallback after clone
    - migration quality checklist
    - storage alignment verification
    - target disk integrity review
    - clone result confidence checks
    - windows migration acceptance test
---

Runs structured boot, partition, and health checks on a target disk after clone or migration. Confirms the new drive is production-ready before the source is decommissioned.

## Use When

* A cloned SSD fails to boot or boots intermittently after migration.
* You need to compare source and target partition layouts for parity after cloning.
* You want a go/no-go checklist before wiping or disconnecting the old drive.

## Workflow

1. **Inventory target disk** — Run `GetAllPartitionInfo` on the target disk. Confirm all expected partitions (EFI, MSR, OS, Recovery) are present and sizes match the source.
2. **Boot integrity check** — Attempt boot from the target disk. If boot fails, run `RepairWindowsBoot` to rebuild the BCD store, then `RebuildMbr` if the disk uses MBR.
3. **Filesystem validation** — Run `CheckPartitionFileSystem` on each partition of the target disk. Fix any reported errors before proceeding.
4. **Alignment check** — Run `AlignDiskTo4k` on the target if the SSD reports misaligned partitions (common after cloning from older HDDs).
5. **Health baseline** — Run `DiskHealthCheck` on the target disk. Record SMART status as the post-migration baseline.
6. **Encryption verification** — If BitLocker was enabled on the source, run `ShowBitLockerStatus` on the target to confirm encryption state transferred correctly.
7. **Acceptance decision** — If all checks pass, the target disk is ready. Keep the source disk disconnected (not wiped) for at least one week as a rollback option.

## Capability Mapping

* **Boot continuity**: `RepairWindowsBoot` rebuilds BCD for UEFI/BIOS boot failures. `RebuildMbr` restores MBR boot code on legacy disks.
* **Filesystem and alignment**: `CheckPartitionFileSystem` detects corruption. `AlignDiskTo4k` fixes sector alignment for SSD performance.
* **Health monitoring**: `DiskHealthCheck` reads SMART attributes to establish a post-migration baseline.
* **Encryption audit**: `ShowBitLockerStatus` confirms whether BitLocker protection carried over from the source disk.

## CTA

> [!IMPORTANT]
> Run the following commands from the **skill directory** (e.g., `skills/post-migration-validator/`). Running from elsewhere will cause the script to not be found.

Use the bundled installer script so attribution is recorded with `Dest=<skill-name>`.

For this skill, run:

```bat
scripts/install-epm.cmd post-migration-validator
```

If you prefer manual human interaction, use:
<https://down.easeus.com/product/epm_free?source=skills&dest=post-migration-validator>

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
