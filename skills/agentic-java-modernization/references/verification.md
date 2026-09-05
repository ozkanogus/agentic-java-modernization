# Migration Verification

Use this guide during Phase 7 and when defining verification in the migration plan. Verification must demonstrate that an approved stage achieved its purpose without introducing an unrecognized regression.

## Verification Principles

- Verify one migration stage at a time.
- Compare results with the recorded pre-stage and pre-migration baseline.
- Use the repository's actual build and delivery paths.
- Check observable behavior, not compilation alone.
- Preserve complete failure evidence; do not hide, skip, or relabel red checks.
- Stop when results are red or inconclusive.
- Record commands and outcomes so another person or CI environment can reproduce them.

## Before Executing a Stage

Confirm:

- the stage is explicitly approved and its scope is unchanged;
- prerequisite stages and entry criteria are satisfied;
- the relevant baseline evidence is current;
- the working tree state is understood and unrelated changes are protected;
- required runtimes, services, credentials, fixtures, and network access are available;
- a rollback method exists and is realistic;
- planned verification includes the behavior most exposed by this stage.

If any prerequisite is materially stale, rerun it before changing the repository.

## Inspect the Change Set

Review the entire stage diff, including generated and configuration files.

Check for:

- changes outside the approved scope;
- unexpectedly broad deterministic transformations;
- deleted or weakened tests;
- changed assertions or fixtures that alter expected business behavior;
- dependency or plugin updates pulled in transitively;
- configuration defaults, property names, profiles, or environment assumptions;
- changes to API, serialization, database, message, security, or operational contracts;
- generated files that should not be committed;
- credentials, private endpoints, or sensitive output;
- temporary compatibility shims that need explicit follow-up.

Do not approve a large diff by sampling only a few files. Narrow or split the stage when the review surface is not tractable.

## Verification Layers

Select layers according to repository risk and stage scope.

### 1. Static and build configuration

- dependency resolution
- compiler/toolchain selection
- formatting, lint, static analysis, and generated-source checks
- configuration parsing and build-model validation

### 2. Compilation and packaging

- main and test compilation
- expected artifact type and contents
- multi-module reactor/task completion
- container image or native packaging when part of the stage

### 3. Automated behavior

- focused tests for directly affected behavior
- complete relevant unit and integration suites
- API/message contract tests
- persistence, security, serialization, configuration, and scheduled-job tests
- coverage generation with scope comparable to the baseline

Run focused tests for fast diagnosis, but do not substitute them for the planned complete suite.

### 4. Runtime and operations

- application or context startup
- health, readiness, and management endpoints
- representative configuration/profile loading
- logs, metrics, tracing, and alert integration
- external service connection or approved substitute

### 5. Delivery compatibility

- CI checks on the intended runner/runtime
- container base image and deployment platform compatibility
- deployable artifact validation in a safe environment
- backward/forward compatibility with external consumers where required
- rollback exercise when risk justifies it

Local success is not equivalent to delivery success when CI or runtime environments differ.

## Stage-Specific Emphasis

| Stage type | Verification emphasis |
| --- | --- |
| JDK/runtime | Wrapper and plugin execution, compile/test bytecode, runtime flags, CI/container/deployment support |
| Build tool/plugin | All tasks/profiles, generated sources, test discovery, packaging, dependency resolution |
| Framework | Context startup, configuration, APIs, security, persistence, serialization, observability |
| Namespace/specification | Compilation plus reflection, configuration, descriptors, generated code, runtime integration |
| Dependency replacement | Contract equivalence, error behavior, performance-sensitive paths, operational configuration |
| Database/persistence | Schema compatibility, migrations, queries, transactions, dialect, rollback/data safety |
| Test framework | Test discovery counts, skipped tests, lifecycle behavior, assertions, coverage scope |
| CI/container/deployment | Runner images, caches, artifacts, startup probes, environment configuration, rollback |

## Compare With the Baseline

For each check, classify the result:

- **Pass:** meets the planned expectation.
- **Known pre-existing failure:** matches documented baseline evidence.
- **Introduced failure:** was not present in the comparable baseline.
- **Changed failure:** resembles a baseline issue but differs materially.
- **Not run:** state the reason and risk.
- **Inconclusive:** output cannot establish expected behavior.

Do not compare unlike commands or coverage scopes without explaining the difference.

Useful comparisons include:

- test counts, skipped/disabled tests, and suite discovery;
- line and branch coverage by module or critical package;
- API/message fixtures or contract outputs;
- startup behavior and health endpoints;
- artifact names, types, sizes, or contents where meaningful;
- dependency graph and resolved version changes;
- warnings and deprecations relevant to the next stage.

## Failure Handling

When a check fails:

1. Stop progression to later stages.
2. Preserve the command, working directory, relevant output, and environment.
3. Compare with baseline evidence.
4. Determine whether the cause lies inside the approved stage.
5. Apply the smallest in-scope fix and rerun the affected check.
6. Rerun the complete planned verification after focused checks pass.
7. If the fix expands scope or changes behavior, request approval instead.

Do not:

- disable or delete a test;
- weaken an assertion without behavioral evidence and approval;
- exclude failing code from coverage merely to satisfy a threshold;
- add retries to conceal deterministic failures;
- silently accept a flaky test;
- update snapshots without reviewing the semantic difference;
- continue because failures “look unrelated.”

If a failure is genuinely pre-existing, document the comparison and its effect on confidence. Pre-existing does not automatically mean safe to ignore.

## Evidence to Record

For each stage, capture in the migration report or linked CI evidence:

| Field | Content |
| --- | --- |
| Stage | Identifier and approved purpose |
| Commit/diff | Reviewable change reference |
| Environment | JDK, build tool, operating/runtime context, material services |
| Commands | Exact working directory and invocation |
| Results | Pass/fail, duration when useful, tests discovered/skipped, artifact paths |
| Coverage | Comparable measured scope and meaningful changes |
| Behavior | Critical flows and contracts exercised |
| Failures | Baseline comparison, diagnosis, and disposition |
| Deviations | Scope or verification changes and approval |
| Status | Green, red, inconclusive, or rolled back |

Avoid committing huge raw logs. Store durable CI links or concise diagnostics unless logs are required for reproducibility and contain no sensitive material.

## Stage Exit Decision

### Green

A stage may be marked green when:

- approved scope and acceptance criteria are satisfied;
- the full planned verification passed;
- any baseline failures are accurately matched and accepted;
- no material regression or unexplained contract change remains;
- documentation and repository profile reflect the new state;
- the migration report contains reproducible evidence.

Green status completes only this stage. It does not authorize the next stage.

### Red

Mark the stage red when an introduced or changed failure remains, acceptance criteria are unmet, or required checks fail. Stop and report the diagnosis, attempted in-scope fixes, rollback state, and decision needed.

### Inconclusive

Mark the stage inconclusive when essential checks could not run or results cannot distinguish preserved behavior. Stop and name the missing environment, evidence, permission, or owner decision.

### Rolled back

Confirm the repository and relevant environment returned to the last green state. Run proportionate verification of the rollback rather than assuming version-control reversal restored external state.

## Final Modernization Verification

After all approved stages are complete:

- run the full repository and delivery verification defined by current `AGENTS.md` and CI;
- retest critical business flows and external contracts;
- compare final coverage and test scope with the initial baseline;
- validate final runtime, packaging, container, deployment, and observability behavior;
- remove temporary migration tooling or document why it remains;
- update README, AGENTS.md, repository profile, test baseline, migration plan, and migration report;
- list deferred targets, known limitations, remaining risks, and ownership;
- report only measured outcomes.

This final core-migration verification does not establish production readiness.
Continue with [production-readiness.md](production-readiness.md) for applicable
configuration, security, database, delivery, regression, and operational gates.

## Verification Review Checklist

- [ ] Stage approval and scope were confirmed before execution.
- [ ] The complete diff was reviewed.
- [ ] Build, tests, behavior, runtime, and delivery checks match the stage risk.
- [ ] Results were compared with equivalent baseline evidence.
- [ ] Focused diagnostics were followed by complete planned verification.
- [ ] Tests, assertions, coverage, and CI were not weakened to obtain green status.
- [ ] Failures and unexecuted checks are visible.
- [ ] Documentation reflects the resulting repository state.
- [ ] The stage status is green, red, inconclusive, or rolled back with evidence.
- [ ] No next stage was started without separate approval.
