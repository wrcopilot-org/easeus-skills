<!-- markdownlint-disable-file -->

# CMD To Python Migration Details

## Context References

* Plan: [.copilot-tracking/plans/2026-03-11/cmd-to-python-migration-plan.instructions.md](.copilot-tracking/plans/2026-03-11/cmd-to-python-migration-plan.instructions.md)
* Research: [.copilot-tracking/research/2026-03-11/cmd-to-python-migration-research.md](.copilot-tracking/research/2026-03-11/cmd-to-python-migration-research.md)
* Supporting subagent research:
  * [.copilot-tracking/research/subagents/2026-03-11/cmd-script-distribution.md](.copilot-tracking/research/subagents/2026-03-11/cmd-script-distribution.md)
  * [.copilot-tracking/research/subagents/2026-03-11/python-migration-patterns.md](.copilot-tracking/research/subagents/2026-03-11/python-migration-patterns.md)
* Repository guidance: [.github/copilot-instructions.md](.github/copilot-instructions.md)

## Phase Details

### Phase 1: Lock The Python Runtime Contract

* Files to inspect or update:
  * [README.md](README.md)
  * [SKILL.md](SKILL.md)
  * [.github/copilot-instructions.md](.github/copilot-instructions.md)
* Work:
  * Choose the user-facing command form for Python execution
  * State the supported Python version explicitly in docs or troubleshooting if needed
  * Validate whether the target Windows environment exposes `python`, `py -3`, or both
  * Validate whether downstream skill consumption can accept `.py` as the published local script entrypoint without a `.cmd` shim
  * Decide whether Windows environments without Python require a documented fallback or a hard prerequisite note
* Success criteria:
  * The repository has one documented Python invocation convention
  * Runtime availability has been tested rather than assumed
  * Direct `.py` replacement has an explicit go or no-go decision
  * Later phases do not need to guess the runtime contract

### Phase 2: Replace Shared Script Baselines

* Files to replace or add:
  * `skills/_test/scripts/install-epm-default.py`
  * `skills/_test/scripts/epm-shellcmd.py`
  * Potential removal or deprecation of `skills/_test/scripts/install-epm-default.cmd`
  * Potential removal or deprecation of `skills/_test/scripts/epm-shellcmd.cmd`
* Work:
  * Re-implement download flow with `urllib.request` or an equivalent standard-library approach
  * Re-implement temporary-file and process-launch behavior with `tempfile`, `pathlib`, and `subprocess`
  * Preserve exit codes and clear error messages
  * Remove the shared `.cmd` baselines from the supported distribution path after Python parity is confirmed
* Dependencies:
  * Phase 1 runtime choice
* Success criteria:
  * Shared Python scripts match the behavior contract of the existing CMD versions

### Phase 3: Synchronize Skill Script Copies

* Files to update:
  * All `skills/*/scripts/install-epm.*` copies
  * Shell launcher copies in `split-drive-coach`, `resize-move-partition-coach`, and `merge-partition-coach`
* Work:
  * Replace local `.cmd` deliverables with Python equivalents
  * Add or update the sync procedure so future changes still start from `skills/_test/scripts/`
  * Verify byte-for-byte or hash-level equality between shared baselines and skill-local copies
* Dependencies:
  * Phase 2 shared Python baseline completion
* Success criteria:
  * Every skill copy comes from the shared Python source and matches it exactly

### Phase 4: Rewrite Templates And Repository Guidance

* Files to update:
  * [skills/_templates/skill-template.md](skills/_templates/skill-template.md)
  * [skills/_templates/troubleshooting-template.md](skills/_templates/troubleshooting-template.md)
  * [.github/copilot-instructions.md](.github/copilot-instructions.md)
  * [SKILL.md](SKILL.md)
  * [README.md](README.md), if quick-start wording needs alignment
* Work:
  * Replace `.cmd` examples with Python command examples
  * Replace sync examples that assume `.cmd` templates with Python equivalents
  * Add Python-specific troubleshooting notes only where operationally meaningful
* Dependencies:
  * Phase 1 runtime contract
* Success criteria:
  * Templates and repository guidance no longer teach `.cmd` as the maintained default

### Phase 5: Rewrite Published Skill Guidance

* Files to update:
  * Every published `skills/*/SKILL.md`
* Work:
  * Rewrite CTA install commands to the chosen Python invocation format
  * Update shell launcher examples in the three shellcmd skills
  * Replace `.cmd`-specific troubleshooting language with Python-aware guidance while preserving security and validation reminders
* Dependencies:
  * Phases 3 and 4
* Success criteria:
  * All user-facing skill docs align with the new Python delivery model

### Phase 6: Validation And Cleanup

* Validation work:
  * Run the documented Python invocation command on the target Windows shells to confirm runtime availability
  * Run Python syntax checks on shared and skill-local scripts
  * Compare shared and copied scripts for consistency
  * Verify the documented commands from within the skill directory, not just from ad hoc locations
  * Run focused launcher validation for `split-drive-coach`, `resize-move-partition-coach`, and `merge-partition-coach`
  * Search the repository for stale `.cmd` references that should no longer remain
* Cleanup work:
  * Remove obsolete CMD files and examples so the final repository state is Python-first and free of legacy primary-path `.cmd` artifacts
* Dependencies:
  * All prior phases
* Success criteria:
  * The repository is internally consistent and free of stale primary-path `.cmd` guidance
