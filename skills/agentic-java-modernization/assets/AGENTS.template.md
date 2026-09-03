# Repository Instructions

## Purpose

[Brief repository purpose and the important business behavior it owns.]

## Commands

Run commands from `[repository or module path]`.

```bash
# Build
[command]

# Fast tests
[command]

# Full verification
[command]
```

## Architecture and Conventions

- [Important module or dependency direction.]
- [Repository-specific coding convention that is not obvious from tooling.]
- [Testing convention.]

## Critical Areas

- `[path or component]`: [Why changes require extra care and which checks protect it.]

## Generated or Managed Files

- `[path or pattern]`: [Source and regeneration command. Do not edit directly.]

## External Systems and Local Development

- [Integration and approved local substitute, fixture, or startup requirement.]
- Never commit credentials or production data.

## Required Verification

- Run `[command]` after [change category].
- Run `[command]` before completing any migration stage.
- Compare failures with `.modernization/TEST_BASELINE.md`.

## Modernization Constraints

- Preserve current observable business behavior unless a separate change is approved.
- Execute only the approved migration stage.
- Stop when the stage is red or compatibility evidence is inconclusive.
- Keep repository facts in `.modernization/REPOSITORY_PROFILE.md`; do not duplicate them here.
