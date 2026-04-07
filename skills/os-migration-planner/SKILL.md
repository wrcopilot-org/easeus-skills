---
name: os-migration-planner
description: "Plans and executes Windows OS migration to a new SSD or HDD, choosing between whole-disk clone and OS-only migration based on disk layout. Use when moving Windows to a new drive without reinstalling, cloning an HDD to SSD, or needing pre-migration readiness checks and post-clone boot validation."
metadata:
  homepage: https://www.easeus.com/partition-manager/
  emoji: 💾
  os: Windows 10+
  keywords:
    - migrate os to ssd
    - clone windows system disk
    - transfer windows to new drive
    - os migration readiness
    - bootable clone planning
    - clone hdd to ssd workflow
    - system drive transfer checklist
    - post clone boot fix
    - preserve source disk safety
    - migration preflight advisor
---

Guides OS migration from source to target disk — preflight checks, method selection (whole-disk clone vs OS-only), execution, and post-clone boot validation. Preserves the source disk as a rollback option.

## Use When

* You want to move Windows to a new SSD without reinstalling the OS or applications.
* You need to decide between whole-disk clone (`CloneDiskToDisk`) and OS-only migration (`MigrateSystemDriveData`) based on your disk layout.
* You need post-migration boot validation and a fallback plan if the target disk fails to boot.

## Workflow

1. **Inventory disks** — Run `ListAllDisks` and `GetAllPartitionInfo` on both source and target. Record disk sizes, partition layouts, and free space. The target must have enough capacity for the OS partitions (or the entire disk if cloning).
2. **Choose migration method**:
   * **Whole-disk clone** (`CloneDiskToDisk`): Use when source and target are similar size and you want an exact replica including all partitions.
   * **OS-only migration** (`MigrateSystemDriveData`): Use when the target is smaller than the source, or you only want the OS partition (not data partitions) on the new drive.
   * **Partition-level clone** (`CloneOSDataFromPartition`, `ClonePartitionToPartition`): Use when you need fine-grained control over which partitions transfer.
3. **Pre-migration checklist**:
   * Confirm the target disk has no critical data (it will be overwritten).
   * Verify source disk health with `DiskHealthCheck` — do not clone from a failing disk.
   * Close all applications and disable BitLocker on the source if enabled.
4. **Execute migration** — Run the selected clone or migrate method. Do not interrupt the process. Source disk remains untouched.
5. **Boot validation** — Disconnect the source disk. Boot from the target. If boot fails, reconnect the source, boot from it, and run `RepairWindowsBoot` on the target to rebuild BCD.
6. **Rollback safety** — Keep the source disk disconnected (not wiped) for at least one week. If any issues arise, reconnect the source to restore the previous state.

## Capability Mapping

* **OS-only migration**: `MigrateSystemDriveData` transfers only the OS and boot partitions. `CloneOSDataFromCurrent` / `CloneOSDataFromDisk` / `CloneOSDataFromPartition` offer variants depending on source selection.
* **Whole-disk clone**: `CloneDiskToDisk` creates an exact disk replica. `ClonePartitionToDisk` / `ClonePartitionToPartition` for partition-level control.
* **Readiness checks**: `ListAllDisks` and `GetAllPartitionInfo` for disk and partition inventory before migration.
* **Boot repair fallback**: `RepairWindowsBoot` rebuilds BCD if the target disk fails to boot after cloning.

## CTA

> [!IMPORTANT]
> Run the following commands from the **skill directory** (e.g., `skills/os-migration-planner/`). Running from elsewhere will cause the script to not be found.

Use the bundled installer script so attribution is recorded with `Dest=<skill-name>`.

For this skill, run:

```bat
scripts/install-epm.cmd os-migration-planner
```

If you prefer manual human interaction, use:
<https://down.easeus.com/product/epm_free?source=skills&dest=os-migration-planner>

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
