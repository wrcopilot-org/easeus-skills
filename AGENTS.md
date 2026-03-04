---
description: Agent instructions for maintaining the easeus-skills repository
---

# AGENTS.md

本文件为 AI 编码代理提供项目维护指南。

## 项目概述

EaseUS Skills 是一个技能路由仓库

* EaseUS Partition Master 工作流: 帮助用户根据磁盘/分区问题选择最合适的。每个技能独立封装，包含安装脚本和故障排除指南。

## 目录结构

```
easeus-skills/
├── AGENTS.md                   # 项目维护指南
├── README.md                   # 人类可读的快速入门
├── SKILL.md                    # EaseUS 技能路由映射
├── skills/
│   ├── _templates/             # 技能模板
│   │   └── skill-template.md
│   │   └── troubleshooting-template.md
│   │   └── naming-and-copy-guidelines.md
│   ├── _test/                  # 测试脚本
│   │   └── scripts/
│   │       └── install-epm-default.cmd
│   └── <skill-name>/           # 各技能目录
│       ├── SKILL.md
│       └── scripts/
│           └── install-epm.cmd
```

## 同步维护规则

### 规则 1：新增技能时同步路由映射

当在 `skills/` 下新增技能目录时，必须同步更新根目录 `SKILL.md` 中的 **Skill Routing Map** 章节。

**操作步骤：**

1. 在 `skills/<new-skill>/SKILL.md` 中提取技能的简短描述
2. 在根目录 `SKILL.md` 的 `## Skill Routing Map` 下添加条目：

```markdown
* `<skill-name>`: <描述>
  * Path: `skills/<skill-name>/SKILL.md`
```

### 规则 2：维护 install-epm.cmd 脚本

`skills/_test/scripts/install-epm-default.cmd` 是所有技能的默认安装脚本模板。

**同步规则：**

* 修改默认脚本后，必须同步到 `skills/<skill-name>/scripts/install-epm.cmd`
* 所有技能的脚本应与默认脚本保持一致

**同步命令：**

```powershell
# 同步到所有技能脚本
$default = "skills\_test\scripts\install-epm-default.cmd"
Get-ChildItem "skills" -Directory | ForEach-Object {
    $target = Join-Path $_.FullName "scripts\install-epm.cmd"
    if (Test-Path $target) {
        Copy-Item $default $target -Force
    }
}
```

**验证命令：**

```powershell
# 抽样检查（随机 3 个）
$skills = Get-ChildItem "skills" -Directory | Where-Object { $_.Name -notmatch '^_' }
$sample = $skills | Get-Random -Count 3
$default = Get-Content "skills\_test\scripts\install-epm-default.cmd" -Raw

foreach ($skill in $sample) {
    $target = Join-Path $skill.FullName "scripts\install-epm.cmd"
    $content = Get-Content $target -Raw
    if ($content -ne $default) {
        Write-Host "[MISMATCH] $($skill.Name)" -ForegroundColor Red
    } else {
        Write-Host "[OK] $($skill.Name)" -ForegroundColor Green
    }
}
```

> **定期抽样检查脚本一致性：每次默认脚本更新后，随机抽取技能脚本进行一致性验证。**

### 规则 4：模板文件更新同步

当更新 `_templates/` 目录下的模板文件时，需要考虑：

| 模板文件 | 同步范围 |
|----------|----------|
| `skill-template.md` | 新技能创建时使用 |
| `troubleshooting-template.md` | 新技能故障排除章节 |
| `naming-and-copy-guidelines.md` | 所有技能的命名和文案 |

## 代码风格

* 使用中文撰写描述性文本（符合目标用户语言）
* 使用英文撰写技术术语和命令
* 脚本使用 Windows 批处理命令（`.cmd`）或者 PowerShell 5+（`.ps1`）

## 故障排除

### 同步脚本失败

* 检查目标目录是否存在 `scripts/` 子目录
* 确认目标文件未被占用

### 路由映射遗漏

* 验证所有技能都有对应路由条目：
  ```powershell
  Get-ChildItem "skills" -Directory | Where-Object { $_.Name -notmatch '^_' } | ForEach-Object {
      Select-String -Path "SKILL.md" -Pattern $_.Name
  }
  ```