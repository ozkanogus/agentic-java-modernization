---
name: agentic-java-modernization
description: Safely assess, prepare, plan, execute, and verify incremental modernization of established Java repositories. Use for Java or Spring upgrades, legacy application discovery, characterization-test baselines, migration planning, or staged modernization. Do not use it to redesign business behavior or force a predetermined target version.
---

# Agentic Java Modernization

Modernize from evidence. Preserve current observable behavior, distinguish existing defects from migration regressions, and execute only approved stages.

## Establish the Requested Mode

Determine which mode the user requested:

- **Analyze:** discover the repository, prepare its profile, assess documentation and tests, and stop before migration planning or execution.
- **Prepare:** use discovery and baseline evidence to propose a compatibility-driven migration graph; stop before changing runtime or framework versions.
- **Execute:** perform exactly the next approved migration stage, verify it, report the outcome, and stop before another stage.
- **Full workflow:** advance through preparation autonomously, but pause for explicit approval before the first migration stage and at any later unresolved decision gate.

If the request is ambiguous, default to Analyze. Planning does not imply permission to execute.

## Non-negotiable Invariants

- Understand the repository before modifying production behavior.
- Never select a target solely because it is the newest available release.
- Establish and record the pre-migration build and test baseline.
- Protect business-critical and migration-sensitive behavior with meaningful tests where feasible.
- Record pre-existing failures separately; never present them as migration regressions.
- Prefer reviewable deterministic transformations when an appropriate recipe exists.
- Keep each migration stage focused and independently verifiable.
- Never disable or weaken tests merely to obtain a green result.
- Avoid unrelated refactoring and business redesign during a migration stage.
- Stop after a red stage. Do not continue to the next stage.
- Treat uncertain compatibility or behavior as a decision requiring evidence or human input.
- Keep credentials, proprietary material, and private organizational context within their authorized environment.

## Phase 0 — Discover

Locate the repository root and applicable repository instructions. Inspect the build from wrapper and configuration files before relying on README claims.

Read [references/discovery.md](references/discovery.md) for the evidence order, migration-sensitive surfaces, and repository-profile quality standard.

Capture at least:

- modules, source sets, entry points, and important business flows;
- Java, Spring, build-tool, plugin, and major dependency versions;
- APIs, persistence, migrations, security, messaging, jobs, serialization, and validation;
- configuration inputs, external integrations, runtime, deployment, CI, and observability;
- tests, coverage configuration, generated code, deprecated APIs, and `javax.*` usage;
- commands attempted, their outcomes, material unknowns, and blockers.

Do not change production code during initial discovery.

## Phase 1 — Persist the Profile

Create or update `.modernization/REPOSITORY_PROFILE.md` with concise facts supported by repository evidence. Prefer paths, configuration keys, and reproducible commands over speculation. Mark unknowns explicitly.

Adapt [assets/REPOSITORY_PROFILE.template.md](assets/REPOSITORY_PROFILE.template.md) when creating the artifact.

Do not turn the profile into a source-code inventory or duplicate the README.

## Phase 2 — Establish Documentation

Create or improve:

- `README.md` for human understanding, local development, testing, deployment, and operations;
- `AGENTS.md` for exact commands, constraints, conventions, generated areas, hazards, and mandatory checks.

Adapt [assets/README.template.md](assets/README.template.md) and [assets/AGENTS.template.md](assets/AGENTS.template.md) rather than copying irrelevant sections unchanged.

Preserve useful existing content. Include only sections supported by evidence and important to this repository.

Read [references/documentation.md](references/documentation.md) to keep README, AGENTS.md, repository profile, and migration artifacts distinct and concise.

## Phase 3 — Build the Test Safety Net

Run the existing build and tests before adding or changing tests. If the baseline is red, record the failures and decide whether preparation can safely continue.

Read [references/testing.md](references/testing.md) for risk-based test selection, characterization technique, coverage interpretation, and red-baseline handling.

Prioritize characterization of observable behavior in this order when relevant:

1. critical business services and workflows;
2. API and message contracts;
3. persistence and transaction behavior;
4. validation, serialization, security, and exception behavior;
5. configuration binding and external-system boundaries;
6. scheduled jobs and startup behavior.

Use unit, integration, contract, characterization, and smoke tests according to the behavior being protected. Avoid mock-heavy or trivial tests created only to raise coverage.

Record commands, results, meaningful coverage, protected flows, gaps, and accepted exceptions in `.modernization/TEST_BASELINE.md`.

Use [assets/TEST_BASELINE.template.md](assets/TEST_BASELINE.template.md) as the concise evidence structure.

Do not begin migration execution without an acceptable recorded baseline and the required approval.

## Phase 4 — Assess Compatibility

Read [references/migration-planning.md](references/migration-planning.md) for evidence classification, whole-stack assessment, target selection, graph construction, and approval rules.

Derive candidate targets and intermediate steps from repository facts. Check current authoritative sources for volatile compatibility information, including:

- Java and framework requirements;
- build tool, wrapper, compiler, and plugin support;
- Spring ecosystem and third-party starter compatibility;
- persistence, database migration, security, serialization, messaging, and test-library changes;
- CI images, containers, deployment platforms, and operational constraints.

Separate confirmed facts, inferences, unknowns, and blocked paths. A supported framework version alone does not prove the application can safely adopt it.

## Phase 5 — Plan the Migration Graph

Write `.modernization/MIGRATION_PLAN.md`. Model stages as a dependency-aware graph rather than a universal version ladder.

Adapt [assets/MIGRATION_PLAN.template.md](assets/MIGRATION_PLAN.template.md) to the repository.

For every proposed stage, specify:

- purpose and compatibility rationale;
- exact scope and excluded work;
- prerequisites and entry criteria;
- deterministic tools or manual changes considered;
- verification commands and behavioral checks;
- rollback approach, risks, and approval status.

Recommend a target, but preserve viable stopping points. Stop for approval before executing the first stage.

## Phase 6 — Execute One Approved Stage

Confirm the approved stage and clean working state. Re-run relevant entry checks if evidence may be stale.

When using a deterministic transformation:

1. confirm the recipe is applicable and its current requirements are understood;
2. prefer a dry run or generated patch;
3. inspect the proposed diff;
4. apply only the approved scope;
5. retain the tool output needed for diagnosis without committing noisy artifacts.

Use agent-assisted edits for repository-specific gaps that deterministic tooling cannot safely resolve. Do not expand the stage merely because adjacent modernization opportunities appear.

## Phase 7 — Verify the Stage

Inspect the complete diff and run the planned checks. Include the full relevant build and test suite plus applicable coverage, contract, startup, integration, packaging, configuration, or operational checks.

Read [references/verification.md](references/verification.md) for layered checks, baseline comparison, failure handling, evidence capture, and stage exit decisions.

Compare failures with the recorded baseline:

- **Green:** document evidence and mark only this stage complete.
- **Red:** stop, preserve diagnostics, and fix within scope or report the blocker.
- **Inconclusive:** stop and identify the missing evidence or human decision.

Never proceed based only on compilation success.

## Phase 8 — Finalize Documentation

Update affected repository documentation and `.modernization/MIGRATION_REPORT.md`. Record executed stages, important changes, verification results, deviations, unresolved risks, and recommended follow-up.

Use [assets/MIGRATION_REPORT.template.md](assets/MIGRATION_REPORT.template.md) for the final evidence-based report.

Report measured results only. Do not fabricate coverage, effort savings, compatibility, or business outcomes.

## Completion Contract

A modernization stage is complete only when:

- its approved scope was respected;
- relevant checks are green or explicitly accepted by the authorized reviewer;
- baseline and migration failures are clearly distinguished;
- repository artifacts reflect the resulting state;
- remaining risks and the next possible stage are visible;
- no subsequent stage was executed without approval.
