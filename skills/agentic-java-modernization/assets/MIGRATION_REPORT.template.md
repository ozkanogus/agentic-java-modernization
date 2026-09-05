# Migration Report

Updated: [YYYY-MM-DD]

## Outcome

- Starting state:
- Resulting state:
- Core migration status: `COMPLETE`, `PARTIAL`, `BLOCKED`, or `ROLLED BACK`
- Production-readiness status: `READY`, `NOT READY`, or `NOT ASSESSED`
- Deployment/regression/UAT status:
- Production integration: `APPROVED`, `PENDING`, or `OUT OF SCOPE`
- Business behavior outcome:
- Remaining recommended target, if any:

## Executed Stages

| Stage | Scope | Result | Commit/PR | Verification evidence |
| --- | --- | --- | --- | --- |
| | | | | |

## Verification Summary

| Check | Before | After | Command/evidence |
| --- | --- | --- | --- |
| Build | | | |
| Tests | | | |
| Meaningful line coverage | | | |
| Critical-flow checks | | | |
| Startup/smoke | | | |
| Packaging/deployment validation | | | |

Report measured values only. Use `Not measured` or `Not applicable` rather than estimating.

## Production Readiness Findings

| Finding | Classification | Evidence | Action/owner |
| --- | --- | --- | --- |
| | `BLOCKER`, `REQUIRED BEFORE PROD`, `RECOMMENDED`, `DEFERRED`, or `NOT APPLICABLE` | | |

Record secret names or locations only; never reproduce values. State whether a
potentially exposed credential requires rotation. Externalization alone is not rotation.

## Deployment, Regression, and UAT

| Environment/check | Result | Evidence | Limitation or owner |
| --- | --- | --- | --- |
| | `PASS`, `FAIL`, `NOT RUN`, or `NOT APPLICABLE` | | |

## Production Synchronization

- Production-truth revision last synchronized:
- Synchronization method:
- Conflict decisions:
- Verification rerun after synchronization:

## Important Changes

- [Runtime, framework, API, configuration, dependency, test, or operational change.]

## Behavioral Compatibility

- Protected behaviors:
- Intentional behavior changes and approvals:
- Unverified behavior:

## Deviations From Plan

| Deviation | Reason | Impact | Approval/reference |
| --- | --- | --- | --- |
| | | | |

## Failures and Resolutions

| Failure | Pre-existing or introduced | Resolution/status | Evidence |
| --- | --- | --- | --- |
| | | | |

## Remaining Risks and Follow-up

| Item | Risk | Recommended action | Owner |
| --- | --- | --- | --- |
| | | | |

## Documentation Updated

- [ ] `README.md`
- [ ] `AGENTS.md`
- [ ] `.modernization/REPOSITORY_PROFILE.md`
- [ ] `.modernization/TEST_BASELINE.md`
- [ ] `.modernization/MIGRATION_PLAN.md`
- [ ] Production-readiness and deployment evidence
