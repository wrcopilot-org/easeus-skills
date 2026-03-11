---
title: CMD Script Distribution Research
description: Research notes for CMD script distribution, template sync, and documentation references in the easeus-skills repository
author: GitHub Copilot
ms.date: 2026-03-11
ms.topic: reference
keywords:
  - cmd scripts
  - easeus skills
  - install script
  - skill documentation
estimated_reading_time: 8
---

## Research Scope

* Confirm whether a repository-local researcher-subagent agent file exists
* Identify the role of each script under skills/_test/scripts
* Determine which skill scripts are synchronized from the default template and which are specialized
* Find SKILL.md and template sections that mention installation scripts, runtime launch, or best-practice guidance
* Estimate the document and script surface most likely affected by a future migration from CMD to Python

## Status

* State: Complete
* Repository-local researcher-subagent agent file: Not found under .github/agents/**/researcher-subagent.agent.md

## Findings

### Test Script Baseline

* skills/_test/scripts/install-epm-default.cmd is the shared installer baseline used to download the EaseUS installer from three mirrors, save it under %TEMP%\EuUpdater_EPM, and run a silent install with exit-code propagation.
* skills/_test/scripts/epm-shellcmd.cmd is the shared launcher baseline used to serialize the remaining CLI arguments into a temp file and call EPMUI.exe startByEpm0 with shellcmd and shellparam.

### Script Synchronization

* Every skill-local scripts/install-epm.cmd matched skills/_test/scripts/install-epm-default.cmd byte-for-byte during hash comparison.
* The repository currently has 15 skill-local install-epm.cmd files, and all 15 are synchronized copies of the default installer template.
* Only three skills contain scripts/epm-shellcmd.cmd: merge-partition-coach, resize-move-partition-coach, and split-drive-coach.
* All three skill-local epm-shellcmd.cmd files matched skills/_test/scripts/epm-shellcmd.cmd byte-for-byte during hash comparison.
* No skill-local CMD script currently contains per-skill code specialization. Current specialization lives in SKILL.md usage examples and argument strings rather than in script source.

### Documentation References

* Root SKILL.md references installation guidance in CTA and falls back to manual download when script-based installation is unavailable.
* All 15 skill SKILL.md files include a Best Use Cases section, a CTA section, and a Troubleshooting section.
* The common CTA pattern documents scripts/install-epm.cmd <skill-name> and warns users to run commands from the skill directory.
* The common Troubleshooting pattern documents installer download failures, missing install artifacts, cross-shell launch commands, permission or security blocks, and launch validation checks.
* Three skill SKILL.md files add shell launcher usage examples with scripts/epm-shellcmd.cmd and skill-specific shellcmd values:
  * split-drive-coach: Split Partition
  * resize-move-partition-coach: Resize Partition
  * merge-partition-coach: Merge with...
* skills/_templates/skill-template.md explicitly defines the future authoring pattern for Best Use Cases, Call-to-Action, Automated Installation, Post-Installation Launch, and Troubleshooting Guide.
* skills/_templates/troubleshooting-template.md defines reusable troubleshooting coverage for installer download failures, missing installation artifacts, cross-shell launch procedures, permission restrictions, and pre-operation validation.
* skills/_templates/naming-and-copy-guidelines.md does not provide operational script instructions; it only mentions troubleshooting as a keyword category example.

### Migration Impact Surface

* Highest-impact scripts: skills/_test/scripts/install-epm-default.cmd and skills/_test/scripts/epm-shellcmd.cmd, because they are the effective source baselines copied into skill directories.
* Highest-impact duplicated script surface: all 15 skill-local scripts/install-epm.cmd files and the 3 skill-local scripts/epm-shellcmd.cmd files.
* Highest-impact documentation surface: skills/_templates/skill-template.md and skills/_templates/troubleshooting-template.md, because they define the wording and command examples new or refreshed skills inherit.
* Highest-impact published skill docs: every skills/*/SKILL.md CTA and Troubleshooting section, plus the three shellcmd-enabled skill docs that include launcher examples.
* Root-level messaging likely affected: the repository SKILL.md CTA text about script-based installation fallback.

## Evidence

* Repository-local researcher-subagent agent file search returned no match under .github/agents/**/researcher-subagent.agent.md.
* Hash comparison confirmed all skill-local install-epm.cmd files match the default installer baseline.
* Hash comparison confirmed all existing skill-local epm-shellcmd.cmd files match the shared shell launcher baseline.
* Grep results confirmed repeated section headings across all skill SKILL.md files: Best Use Cases, CTA, Troubleshooting, Script Fails to Download Installer, Install Directory or Binary Is Missing, Cross-Shell Launch Command (cmd and PowerShell), Permission or Security Blocks, and Launch Validation Checks.
* Grep results confirmed template section headings in skill-template.md and troubleshooting-template.md.

## Next Research

* None required for the requested scope

## Open Questions

* None at this stage