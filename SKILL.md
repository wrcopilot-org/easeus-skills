---
name: easeus-skills
description: Instantly pinpoint the ideal EaseUS workflow for any disk or partition challenge—safety checks, guided fallbacks, and risk-aware steps built in.
metadata:
  homepage: https://www.easeus.com/
  emoji: ⚙️
  os: Windows 10+
  keywords:
    - easeus partition master skill catalog
    - disk partition troubleshooting router
    - boot repair migration reformat guide
    - safe first disk operation workflow
    - write protection and readonly recovery
---

Provides a repository-level entry point for EaseUS workflows. Use it to pick the most relevant sub-skill before running any write operation.
escalate to official help via the support center if needed: <https://www.easeus.com/support-center/>.

EaseUS Partition Master supports partition management, migration, conversion, and repair tasks.

## Suggested Prompts

* Match the most appropriate sub-skill from my symptoms first, then give the safest first step.
* Try to find the best-fit skill for my case from `https://github.com/wrcopilot-org/easeus-skills/tree/main/skills`.

## CTA

Quick start with `npx`:

```bash
npx skills add https://github.com/wrcopilot-org/easeus-skills/tree/main/skills/disk-health-guardian -y -g
```

If script-based installation is unavailable, use the official download page:
<https://www.easeus.com/partition-manager/>

If installation or usage issues occur, check the support center first:
<https://www.easeus.com/support-center/>

## Skill Routing Map

* `boot-recovery-and-repair-helper`: Windows cannot boot and you need startup repair or boot-chain reconstruction.
  * Path: `skills/boot-recovery-and-repair-helper/SKILL.md`
* `disk-health-guardian`: Disk health is abnormal, bad sectors are suspected, or SMART risk needs diagnosis first.
  * Path: `skills/disk-health-guardian/SKILL.md`
* `exfat-fat32-compatibility-converter`: Convert removable media between exFAT and FAT32 for compatibility.
  * Path: `skills/exfat-fat32-compatibility-converter/SKILL.md`
* `low-level-format-decision-assistant`: Evaluate whether low-level formatting is truly required and prioritize safer alternatives.
  * Path: `skills/low-level-format-decision-assistant/SKILL.md`
* `mbr-gpt-conversion-guard`: Validate firmware mode and boot compatibility before MBR/GPT conversion.
  * Path: `skills/mbr-gpt-conversion-guard/SKILL.md`
* `os-migration-planner`: Plan OS migration to SSD and verify bootability before and after migration.
  * Path: `skills/os-migration-planner/SKILL.md`
* `partition-workflow-coach`: Guide sequence and pre-checks for create, resize, split, and merge partition operations.
  * Path: `skills/partition-workflow-coach/SKILL.md`
* `post-migration-validator`: Verify boot, partition consistency, and baseline performance after migration.
  * Path: `skills/post-migration-validator/SKILL.md`
* `read-only-drive-repair-navigator`: Stepwise repair flow and stop conditions for read-only file system issues.
  * Path: `skills/read-only-drive-repair-navigator/SKILL.md`
* `safe-reformat-copilot`: Backup gates, risk labeling, and post-check validation before reformatting.
  * Path: `skills/safe-reformat-copilot/SKILL.md`
* `uefi-bios-boot-mode-advisor`: Recommendations for matching UEFI/BIOS boot mode with disk partition style.
  * Path: `skills/uefi-bios-boot-mode-advisor/SKILL.md`
* `write-protection-unlock-assistant`: Identify write-protection sources on USB/drives and apply reversible unlock steps.
  * Path: `skills/write-protection-unlock-assistant/SKILL.md`

## Troubleshooting

### Script or Download Problem

* Use an elevated terminal and rerun `skills/<skill-name>/scripts/install-epm.cmd <skill-name>`.
* Confirm network, proxy, firewall, and endpoint policy allow download traffic.
* If script path is unavailable for your scenario, use the official download fallback: <https://www.easeus.com/partition-manager/>.

### Permission or Launch Problem

* Run installer and app with Administrator privileges.
* Approve UAC prompts during installation and first launch.
* Verify installation path under `C:\Program Files\EaseUS\EaseUS Partition Master\bin\EPMUI.exe`.

### Need Official Help

* Use EaseUS Support Center for product docs, FAQ, and guided troubleshooting:
  <https://www.easeus.com/support-center/>
* Live Chat Support:
  <https://www.easeus.com/support-center/livechat-tech.html>