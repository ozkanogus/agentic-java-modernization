# Migration Plan

Prepared: [YYYY-MM-DD]

Planning does not authorize execution. Record explicit approval per stage.

## Current State

- Repository profile: `.modernization/REPOSITORY_PROFILE.md`
- Test baseline: `.modernization/TEST_BASELINE.md`
- Current Java/framework/build state:
- Baseline status:

## Recommended Target

- Target state:
- Why this target is appropriate:
- Evidence consulted:
- Viable stopping points:
- Targets rejected or deferred and why:

## Compatibility Assessment

| Area | Current | Candidate target | Status | Evidence or action |
| --- | --- | --- | --- | --- |
| Java/runtime | | | | |
| Framework | | | | |
| Build tool/plugins | | | | |
| Persistence/database | | | | |
| Security | | | | |
| Messaging/integrations | | | | |
| Testing/coverage | | | | |
| CI/container/deployment | | | | |

Use `Confirmed`, `Inference`, `Unknown`, or `Blocked` for status.

## Migration Graph

```text
[Current state]
    |
    v
[Stage 1] ----blocked by----> [Decision or compatibility evidence]
    |
    v
[Stage 2]
```

## Branching and Production Synchronization

- Production-truth branch:
- Modernization integration branch, if needed:
- Stage branch convention:
- Merge/rebase policy source:
- Production synchronization cadence or trigger:
- Revision last synchronized:
- Verification required after synchronization:

## Stages

### Stage [N] — [Name]

- Status: `PROPOSED`, `APPROVED`, `IN PROGRESS`, `GREEN`, `RED`, or `DEFERRED`
- Purpose:
- Compatibility rationale:
- In scope:
- Explicitly out of scope:
- Prerequisites/entry criteria:
- Planned deterministic transformations:
- Planned repository-specific changes:
- Verification commands and behavioral checks:
- Risks:
- Rollback approach:
- Approval owner/date:

## Cross-stage Risks and Decisions

| Risk or decision | Affected stages | Mitigation/owner | Status |
| --- | --- | --- | --- |
| | | | |

## Production Readiness and Deployment Plan

- Core migration completion criteria:
- Production-readiness review owner:
- Representative deployment environment:
- Required startup/smoke, regression, operational, QA, or UAT checks:
- Database rollout and recovery owner:
- Production integration approval authority:

## Execution Rule

Execute only the next approved stage. Stop after verification and do not begin another stage while the current stage is red or inconclusive.

Core migration completion does not authorize production integration. Keep the
modernization candidate synchronized with production truth and complete the
applicable readiness and deployment gates before final integration.
