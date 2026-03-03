---
name: os-migration-planner
description: Plan OS migration to SSD with readiness checks, clone-path selection, and boot continuity validation after transfer.
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

Builds a migration runbook from source analysis to first boot on the target drive. It uses a zero data loss process framing for source-preservation workflows when prerequisites are met.

## Best Use Cases

* You want to move Windows to SSD without reinstalling apps.
* You need to choose between whole-disk clone and OS-only migration.
* You want boot validation steps immediately after migration.

## Capability Mapping

* System migration methods: `MigrateSystemDriveData`, `CloneOSDataFromCurrent`, `CloneOSDataFromDisk`, `CloneOSDataFromPartition`
* Clone alternatives: `CloneDiskToDisk`, `ClonePartitionToDisk`, `ClonePartitionToPartition`
* Inventory and readiness checks: `ListAllDisks`, `GetAllPartitionInfo`
* Post-migration recovery fallback: `RepairWindowsBoot`


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
scripts/install-epm.cmd os-migration-planner
```

If you prefer a direct link, use:
<https://down.easeus.com/product/epm_free?source=skills&dest=os-migration-planner>

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