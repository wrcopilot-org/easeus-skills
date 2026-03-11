<!-- markdownlint-disable-file -->

# CMD To Python Migration Planning Log

## Discrepancy Log

* Current repository instructions still describe allowed script types as `.cmd` or `.ps1`. The migration plan intentionally expands that convention to Python and therefore requires an instructions update as part of the implementation.
* Current templates assume `.cmd` command examples everywhere. The plan treats template rewrites as a first-class task rather than a follow-up cleanup item.
* The exact Python invocation contract is not yet fixed. The plan isolates that decision in Phase 1 so the remaining work can stay consistent.
* The final migration state must not keep `.cmd` as a publishable primary path. The plan now treats removal of legacy `.cmd` deliverables and references as required work, not an optional cleanup.
* Python runtime availability must be verified in practice on the target Windows shell paths. The plan now treats runtime validation as a required execution and review step.
* Direct `.py` replacement depends on downstream skill consumption accepting Python files as the public local entrypoint. The plan now treats that as an explicit Phase 1 go or no-go gate.

## Implementation Paths Considered

### Selected Path

Move the shared script source of truth from CMD to Python while preserving the existing copy-based distribution model.

Why this path was selected:

* It respects the repository rule that `skills/_test/scripts/` is maintained first
* It removes `.cmd` from the deliverable surface instead of hiding Python behind a wrapper forever
* It keeps the skill-level layout familiar for maintainers and downstream users

### Alternative Paths

* Keep `.cmd` entrypoints and call Python internally. Useful only as a temporary bridge, but not aligned with the target end state.
* Centralize all logic into a shared Python package. Cleaner long term, but too large a first migration for a repository that currently relies on file-copy synchronization.

## Suggested Follow-On Work

* Add an automated sync or verification helper for Python script copies after the migration lands
* Consider whether launcher behavior should eventually move to a single reusable Python module instead of full-file copies
* Define a repository-wide Windows Python prerequisite statement so future skills do not reintroduce ambiguity
