<!-- markdownlint-disable-file -->

# CMD To Python Migration Plan

## Overview And Objectives

### User Requirements

* Understand the repository before changing direction
* Treat `skills/_test/scripts/` as the primary maintenance surface and synchronize outward to each skill as needed
* Replace `.cmd` delivery with Python implementations, preferably without third-party libraries
* Synchronize the corresponding skill guidance, especially best-practice and troubleshooting guidance
* Do not force a minimum-change strategy if a broader cleanup leads to a better long-term result

### Derived Objectives

* Preserve the current copy-based distribution model so the repository remains easy to maintain
* Remove `.cmd` from shared baselines, skill-local automation examples, and related documentation
* Preserve current installer attribution and shell launcher contracts
* Update repository conventions so future changes do not regress back to `.cmd` assumptions

## Context Summary

* Repository maintenance rules in [.github/copilot-instructions.md](.github/copilot-instructions.md) require shared-script-first maintenance and sync
* Markdown updates must follow the conventions in the HVE markdown and writing-style instruction files
* Skill and template edits must follow the prompt-builder guidance for `SKILL.md` artifacts
* Current evidence is consolidated in [.copilot-tracking/research/2026-03-11/cmd-to-python-migration-research.md](.copilot-tracking/research/2026-03-11/cmd-to-python-migration-research.md)

## Dependencies

* Shared script baselines under `skills/_test/scripts/`
* Skill templates under `skills/_templates/`
* Published skill docs under `skills/*/SKILL.md`
* Repository guidance in [.github/copilot-instructions.md](.github/copilot-instructions.md)
* No external Python packages are planned

## Implementation Checklist

### Phase 1: Lock The Python Runtime Contract
<!-- parallelizable: false -->

- [ ] Decide and document the canonical invocation form for local scripts: `python`, `py -3`, or a documented fallback pair
- [ ] Define the minimum supported Python version based on standard-library features needed for download, process launch, temp files, and path handling
- [ ] Validate Python runtime availability on the intended Windows execution path and record whether the repository will require `python`, `py -3`, or both to be documented
- [ ] Validate that downstream skill consumption and published CTA flows can use `.py` files directly as the public local entrypoint, and record a go or no-go decision before replacement work starts
- [ ] Update the plan details with a hard prerequisite statement or a repository-approved bootstrap path if runtime validation exposes gaps

### Phase 2: Replace Shared Script Baselines
<!-- parallelizable: false -->

- [ ] Implement Python installer baseline under `skills/_test/scripts/` with parity for `Dest` parsing, mirror fallback, silent install, and exit-code propagation
- [ ] Implement Python shell launcher baseline under `skills/_test/scripts/` with parity for temp-file creation, UTF-8 writing, fixed `EPMUI.exe` path resolution, and `startByEpm0` launch semantics
- [ ] Remove the shared `.cmd` baselines from the shippable path once Python parity is implemented and validated

### Phase 3: Synchronize Skill Script Copies
<!-- parallelizable: true -->

- [ ] Copy the Python installer baseline into every skill that currently ships `scripts/install-epm.cmd`
- [ ] Copy the Python shell launcher baseline into the three shellcmd-enabled skills
- [ ] Replace local `.cmd` deliverables and references so each skill ships Python artifacts consistent with the new baseline
- [ ] Add a repeatable verification step to confirm skill-local copies match the shared source files

### Phase 4: Rewrite Templates And Repository Guidance
<!-- parallelizable: true -->

- [ ] Update [skills/_templates/skill-template.md](skills/_templates/skill-template.md) to teach Python installation and launch guidance instead of `.cmd`
- [ ] Update [skills/_templates/troubleshooting-template.md](skills/_templates/troubleshooting-template.md) so remediation steps reference Python commands and Python-related failure modes where relevant
- [ ] Update [.github/copilot-instructions.md](.github/copilot-instructions.md) so script-language guidance, sync commands, and maintenance rules reflect Python as the maintained baseline
- [ ] Update root [SKILL.md](SKILL.md) and, if needed, [README.md](README.md) to remove stale references to script-based `.cmd` assumptions

### Phase 5: Rewrite Published Skill Guidance
<!-- parallelizable: true -->

- [ ] Update every skill `SKILL.md` CTA to use the Python installer command
- [ ] Update the three shellcmd-enabled skills to show Python launcher usage and preserve the documented `shellcmd` behavior
- [ ] Refresh troubleshooting sections across all skills so examples, remediation steps, and security notes match the Python implementation
- [ ] Confirm that Best Use Cases and capability sections remain unchanged unless they are affected by the command migration

### Phase 6: Validation And Cleanup
<!-- parallelizable: false -->

- [ ] Run a Python runtime availability check using the documented invocation form on the target Windows shell paths
- [ ] Run consistency checks to ensure every skill-local Python script matches its shared source baseline
- [ ] Run syntax checks on the new Python files
- [ ] Verify representative install and launcher command examples against the documented paths and arguments
- [ ] Verify that documented commands still work when executed from the skill directory, which remains the required execution location
- [ ] Run focused validation on the three shellcmd-enabled skills instead of relying on generic representative checks alone
- [ ] Remove obsolete `.cmd` references and files from documentation and script directories as part of the final migration state

## Success Criteria

* Shared script maintenance now starts from Python files under `skills/_test/scripts/`
* Every affected skill has synchronized Python script copies
* No published CTA or troubleshooting section still instructs users to run `.cmd` files as the primary local automation path
* The three shellcmd-enabled skills keep equivalent documented behavior after migration
* Python runtime expectations are validated and documented rather than implied
* The repository confirms that `.py` is an allowed public local entrypoint before direct replacement proceeds
* Commands continue to work from the skill directory, which remains the required execution location
* Repository instructions explain how future maintainers should sync and validate the Python baselines
