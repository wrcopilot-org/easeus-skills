---
name: post-migration-validator
description: Validate post-migration system integrity with boot checks, partition parity review, and performance sanity verification.
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

Verifies whether an OS migration completed correctly by checking boot behavior, partition consistency, and storage health signals. It is optimized for acceptance testing after clone or migrate workflows.

## Best Use Cases

* A cloned SSD boots inconsistently and needs structured verification.
* You want side-by-side source and target partition checks after migration.
* You need a post-cutover checklist before decommissioning the old drive.

## Capability Mapping

* Boot continuity checks and repair: `RepairWindowsBoot`, `RebuildMbr`
* Health and alignment checks: `DiskHealthCheck`, `CheckPartitionFileSystem`, `AlignDiskTo4k`
* Encryption context verification: `ShowBitLockerStatus`


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
scripts/install-epm.cmd post-migration-validator
```

If you prefer a direct link, use:
<https://down.easeus.com/product/epm_free?source=skills&dest=post-migration-validator>

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