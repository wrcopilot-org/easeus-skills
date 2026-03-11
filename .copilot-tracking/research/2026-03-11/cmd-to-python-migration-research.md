<!-- markdownlint-disable-file -->

# CMD To Python Migration Research

## Scope

* Understand the repository structure and the real source of skill-local script delivery
* Confirm how `skills/_test/scripts/` propagates into `skills/*/scripts/`
* Identify the documentation surface that embeds `.cmd` guidance today
* Produce a migration direction for replacing `.cmd` with Python implementations, prioritizing no third-party dependencies

## Assumptions

* The requested outcome is a Python-based delivery model, not a long-term `.cmd` shim model
* `skills/_test/scripts/` remains the canonical source of shared operational scripts
* Existing attribution behavior through `Dest=<skill-name>` must be preserved
* Current Windows-only scope remains unchanged
* We can broaden change scope beyond the smallest possible patch when that reduces long-term maintenance cost

## Success Criteria

* Shared script baselines move from `.cmd` to Python under `skills/_test/scripts/`
* Per-skill script copies are synchronized from those Python baselines
* Skill templates and published skill guidance stop teaching `.cmd` as the primary local automation path
* Shell-launching skills preserve the current `shellcmd` and `shellparam` contract
* The migration plan includes validation for Python runtime availability and post-sync consistency

## Evidence Log

* [README.md](README.md) and [SKILL.md](SKILL.md) position this repository as a routing and documentation entry point, with script-based install as a secondary local path
* [skills/_test/scripts/install-epm-default.cmd](skills/_test/scripts/install-epm-default.cmd) is the canonical installer baseline copied into all skill folders
* [skills/_test/scripts/epm-shellcmd.cmd](skills/_test/scripts/epm-shellcmd.cmd) is the canonical shell launcher baseline copied into three shellcmd-enabled skills
* [skills/_templates/skill-template.md](skills/_templates/skill-template.md) hardcodes `.cmd` commands in CTA and troubleshooting guidance
* [skills/_templates/troubleshooting-template.md](skills/_templates/troubleshooting-template.md) standardizes install and launch troubleshooting around `.cmd` plus PowerShell
* [.github/copilot-instructions.md](.github/copilot-instructions.md) explicitly states that shared scripts under `skills/_test/scripts/` should be maintained first and then synchronized to each skill
* The subagent findings in [.copilot-tracking/research/subagents/2026-03-11/cmd-script-distribution.md](.copilot-tracking/research/subagents/2026-03-11/cmd-script-distribution.md) and [.copilot-tracking/research/subagents/2026-03-11/python-migration-patterns.md](.copilot-tracking/research/subagents/2026-03-11/python-migration-patterns.md) confirm there is no Python precedent in the repository today

## Alternatives Evaluated

### Option 1

Keep `.cmd` as the public interface and hide Python behind wrappers.

Rejected as the target state. This is useful only as a temporary compatibility bridge. It conflicts with the stated requirement that `.cmd` cannot remain the shippable form.

### Option 2

Replace the shared baselines and per-skill copies with Python scripts while keeping the existing per-skill copy model.

Selected. This preserves the repository's current distribution pattern, keeps `skills/_test/scripts/` as the source of truth, and minimizes conceptual change while still removing `.cmd` as the primary deliverable.

### Option 3

Introduce a shared Python package or central module and make skill directories reference it indirectly.

Not selected for the first migration. It reduces duplication, but it also introduces a new packaging contract and a larger operational change than the repository currently uses.

## Selected Approach

Adopt a Python-first copy-based distribution model.

The shared source of truth stays in `skills/_test/scripts/`, but the canonical files become Python implementations such as `install-epm-default.py` and `epm-shellcmd.py`. Each skill then receives synchronized Python copies in its own `scripts/` folder. Documentation is updated in three layers at the same time: root entry guidance, skill templates, and every published skill `SKILL.md` that references local scripts.

This approach is better aligned with the repository's maintenance rules than a partial shim strategy. It keeps the current sync workflow intuitive, preserves attribution and launcher behavior, and avoids inventing a new packaging mechanism before the repository proves it needs one.

## Design Constraints

* Prefer Python standard library only
* Preserve `Dest=<skill-name>` parsing and normalization behavior
* Preserve multi-mirror download behavior and a clear non-zero exit code on failure
* Preserve silent-install flags and exit-code propagation
* Preserve `shellcmd` plus temp-file `shellparam` launch semantics for the three launcher skills
* Keep commands runnable from the skill directory
* Update repository instructions to acknowledge Python as an allowed script implementation language

## Recommended Migration Shape

1. Validate runtime assumptions before implementation: decide whether the documented command should be `python`, `py -3`, or a dual-form fallback.
2. Build Python baselines first in `skills/_test/scripts/`.
3. Synchronize Python copies into affected skills.
4. Rewrite CTA, troubleshooting, and launch guidance in templates first.
5. Rewrite all published skill docs from the templates and skill-specific behavior.
6. Add a repository-level sync and verification step so future script changes remain centralized.

## Actionable Next Steps

* Create a formal implementation plan covering shared scripts, per-skill sync, template rewrites, and published skill updates
* Include one phase dedicated to runtime-command selection and compatibility validation
* Treat the three shellcmd-enabled skills as a separate validation lane because they have a stricter behavior contract
