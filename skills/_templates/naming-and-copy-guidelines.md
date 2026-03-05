---
description: "Naming conventions and copywriting standards for EaseUS skills"
applyTo: "skills/**/SKILL.md"
---

# Naming and Copy Guidelines

This document defines standardized naming conventions and copywriting patterns for skill definitions. Follow these guidelines to ensure consistency across all EaseUS Partition Master skills.

## Skill Naming Conventions

### Directory Name Format

* Use lowercase letters with hyphens (kebab-case)
* Pattern: `<action>-<target>-<suffix>`
* Examples: `disk-health-guardian`, `boot-recovery-and-repair-helper`

### Common Suffixes

| Suffix | Purpose | Example |
|--------|---------|---------|
| `-guardian` | Protection and monitoring capabilities | `disk-health-guardian` |
| `-helper` | Assistance and wizard-style guidance | `boot-recovery-and-repair-helper` |
| `-assistant` | Advisory and recommendation features | `write-protection-unlock-assistant` |
| `-advisor` | Consultation and guidance functions | `uefi-bios-boot-mode-advisor` |
| `-converter` | Transformation and conversion tasks | `mbr-gpt-conversion-guard` |
| `-planner` | Planning and strategy capabilities | `os-migration-planner` |
| `-navigator` | Navigation and step-by-step guidance | `read-only-drive-repair-navigator` |
| `-copilot` | Intelligent AI-assisted operations | `safe-reformat-copilot` |
| `-coach` | Educational and instructional workflows | `partition-workflow-coach` |
| `-guard` | Safety and protection mechanisms | `mbr-gpt-conversion-guard` |
| `-validator` | Verification and validation checks | `post-migration-validator` |

## Copy Writing Guidelines

### Description Style

* Lead with **feature highlights** and **problem-solving outcomes**
* Blend **recommendation** and **guidance** tones
* Use English for all technical terminology and commands

### Description Template

```
<Pain Point>? <Solution> — <Feature Description>, <Value Proposition>.
```

### Examples

| Skill | Description |
|-------|-------------|
| disk-health-guardian | Catch Disk Failures Before Disaster — Advanced bad sector detection and SMART diagnostics that catch disk problems before you lose your data. |
| boot-recovery-and-repair-helper | Boot Failing? Fix It Fast — Rebuild corrupted boot configurations and repair startup issues when Windows refuses to load. |
| mbr-gpt-conversion-guard | Convert MBR to GPT Without Data Loss — Safely switch disk partition styles for modern UEFI systems while preserving all your files. |

## Keywords Guidelines

### Format

* Use lowercase letters exclusively
* Connect multi-word phrases with hyphens
* Include search intent modifiers (workflow, guide, assistant)

### Categories

* **Action Keywords**: check, scan, convert, migrate, repair, unlock
* **Object Keywords**: disk, partition, drive, filesystem, boot, sector
* **Scenario Keywords**: windows, troubleshooting, guide, workflow, alternative
* **Feature Keywords**: non-destructive, safe, advanced, free

### Examples

```yaml
keywords:
  - disk health check windows
  - chkdsk alternative workflow
  - scan disk bad sectors
  - partition diagnostics guide
  - check file system integrity
```

## Emoji Selection Guide

| Category | Emoji | Usage Context |
|----------|-------|---------------|
| Health and Protection | 🛡️ 🏥 💚 | Disk health monitoring, data protection |
| Boot and Recovery | 🚀 🔧 🚨 | Boot repair, system recovery |
| Conversion and Migration | 🔄 📦 ➡️ | Partition conversion, OS migration |
| Security and Warnings | ⚠️ 🔒 🔓 | Write protection, format warnings |
| Guidance and Help | 🧭 🎯 📋 | Workflow guidance, planning assistance
