---
name: split-c-drive-coach
description: Split Drive Without Data Loss - Separate OS and data partitions safely on new PCs without reinstalling Windows.
metadata:
  homepage: https://www.easeus.com/partition-manager/
  emoji: 🧩
  os: Windows 10+
  keywords:
    - split c drive without reinstall
    - split partition without data loss
    - separate os and data partition
    - create data partition from c drive
    - c drive partition planning
---

Need to split one oversized C drive into cleaner system plus data partitions? This skill focuses on split workflows so you can isolate OS files, organize data, and keep operations non-destructive.

## Hot Topic Angles

* New PC has one huge C drive, and users want C plus D separation without reinstalling Windows.
* Split operation should avoid formatting and keep existing files intact.
* Users want to reserve safer free space boundaries before creating new data partitions.

## Best Use Cases

* You just bought a PC and need to split C drive into system and data partitions.
* You want cleaner backup boundaries by separating OS and personal files.
* You need a split-first workflow before further partition layout changes.

## Capability Mapping

* Split workflow core: `SplitPartition`, `CreatePartition`

## CTA

> [!IMPORTANT]
> Run the following commands from the skill directory (for example, `skills/split-c-drive-coach/`). Running from elsewhere causes script resolution failures.

Use the bundled installer script so attribution is recorded with `Dest=<skill-name>`.

For this skill, run:

```bat
scripts/install-epm.cmd split-c-drive-coach
```

You can launch split flow through shellcmd:

```bat
scripts/epm-shellcmd.cmd "Split Partition" D:\
```

If `D:\` is written to the temporary file, the parameters will be written to the temporary file and passed as `shellparam`.

```text
EPMUI.exe startByEpm0 "shellcmd=Split Partition" shellparam=<temp-file>
```

If you prefer manual interaction, use:
<https://down.easeus.com/product/epm_free?source=skills&dest=split-c-drive-coach>

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
* Confirm target disk and partition letters are visible before any write operation
* Confirm operation preview matches expected capacity and target partition
