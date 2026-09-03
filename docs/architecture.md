# Architecture

## Purpose

Agentic Java Modernization is a reusable methodology for understanding, protecting, planning, and incrementally modernizing established Java applications with coding agents and deterministic tools.

The project is not a migration engine. It defines the decisions, evidence, artifacts, approval gates, and verification rules that govern a modernization effort.

## Goals

- Build a concise, persistent understanding of each target repository.
- Improve human documentation and operational context for coding agents.
- Protect current observable behavior before framework or runtime changes.
- Choose migration targets and intermediate stages from compatibility evidence.
- Combine deterministic transformations with repository-specific reasoning.
- Make failures, risks, approvals, and verification results visible.
- Remain portable across coding agents and capability providers.

## Non-goals

The initial version does not:

- implement a custom source transformation engine;
- prescribe the newest Java or Spring Boot release as a universal target;
- replace Maven, Gradle, JUnit, JaCoCo, OpenRewrite, CI, or vendor tooling;
- orchestrate multiple specialized agents;
- redesign mature business behavior during framework migration;
- contain employer, customer, or other proprietary repository material;
- automate repository creation, pull requests, deployment, or production rollout.

## Conceptual Model

```text
Repository
    |
    v
Discovery -----> Documentation baseline
    |                     |
    v                     v
Repository profile   README + AGENTS.md
    |                     |
    +----------+----------+
               |
               v
       Test safety net
               |
               v
        Baseline evidence
               |
               v
   Compatibility assessment
               |
               v
        Migration graph
               |
               v
        Human approval
               |
               v
    One migration stage
       /             \
      v               v
Deterministic      AI-assisted
transformation     repository fixes
      \               /
       v             v
       Build + test + inspect
               |
          Green stage?
          /         \
        no           yes
        |             |
       stop       next approval
```

## Workflow Phases

### Phase 0 — Discover

Identify the repository root, modules, build system, Java and framework versions, entry points, business flows, persistence, security, integrations, runtime configuration, delivery model, observability, dependencies, tests, and known failures.

Exit condition: the repository can be described accurately enough to plan documentation and testing work without modifying production behavior.

### Phase 1 — Persist the Repository Profile

Record concise, evidence-based facts in `.modernization/REPOSITORY_PROFILE.md`. Mark unknowns explicitly and cite repository paths or commands where useful.

Exit condition: future sessions can recover the important modernization context without repeating full discovery.

### Phase 2 — Documentation Baseline

Create or improve the human-facing `README.md` and operational `AGENTS.md`. Avoid duplicating the profile or generating encyclopedic documentation.

Exit condition: a developer can understand, build, test, and operate the application, while an agent can follow repository-specific constraints and verification commands.

### Phase 3 — Test Safety Net

Inventory existing tests and prioritize characterization tests around business-critical and migration-sensitive observable behavior. Generate coverage evidence without gaming the metric.

Exit condition: `.modernization/TEST_BASELINE.md` records test types, critical flows, commands, results, coverage, gaps, and accepted exceptions.

### Phase 4 — Migration Assessment

Evaluate supported Java, framework, build-tool, plugin, third-party, runtime, deployment, and CI combinations. Consult current authoritative documentation for volatile compatibility facts.

Exit condition: viable targets, blocked targets, uncertainties, and required human decisions are explicit.

### Phase 5 — Migration Plan

Produce `.modernization/MIGRATION_PLAN.md` containing a dependency-aware migration graph. Each stage must have a purpose, scope, entry criteria, verification commands, rollback approach, and approval state.

Exit condition: the next stage is approved. Planning alone does not authorize execution.

### Phase 6 — Incremental Migration

Execute exactly one approved stage. Prefer a deterministic transformation where an appropriate, reviewable recipe exists. Keep unrelated refactoring out of the stage.

Exit condition: the planned changes are applied and ready for verification.

### Phase 7 — Verification

Review the diff and run the stage-specific build, tests, coverage, contract, startup, integration, and operational checks that are relevant to the repository.

Exit condition: the stage is green, or execution stops with failures documented. A red stage never advances automatically.

### Phase 8 — Finalize Documentation

Update affected documentation and write `.modernization/MIGRATION_REPORT.md` with completed stages, evidence, deviations, remaining risks, and follow-up work.

Exit condition: the modernization outcome is reproducible and reviewable.

## Quality Gates

| Gate | Required evidence |
| --- | --- |
| Discovery | Current-state facts, important unknowns, business flows, and dependency inventory |
| Documentation | Useful README, actionable AGENTS.md, and concise repository profile |
| Safety net | Test inventory, behavior-focused coverage, commands, results, and documented gaps |
| Baseline | Pre-existing failures separated from modernization failures |
| Planning | Compatibility evidence, staged graph, risks, rollback, and explicit approval |
| Stage | Reviewed diff and all relevant checks green |
| Completion | Full verification, updated documentation, and migration report |

Coverage is supporting evidence, not the primary objective. An approximate 80% meaningful line-coverage target may guide test investment when realistic, but it cannot replace protection of critical observable behavior.

## Artifact Responsibilities

### Target repository artifacts

| Artifact | Audience | Responsibility |
| --- | --- | --- |
| `README.md` | Humans | Purpose, business context, architecture, development, testing, deployment, and operations |
| `AGENTS.md` | Coding agents | Commands, conventions, constraints, generated areas, hazards, and required checks |
| `.modernization/REPOSITORY_PROFILE.md` | Humans and agents | Concise current-state architecture and modernization facts |
| `.modernization/TEST_BASELINE.md` | Humans and agents | Test inventory, critical behaviors, coverage evidence, failures, and gaps |
| `.modernization/MIGRATION_PLAN.md` | Reviewers and executors | Targets, stages, dependencies, risks, verification, rollback, and approvals |
| `.modernization/MIGRATION_REPORT.md` | Maintainers and reviewers | Executed work, results, deviations, remaining risks, and recommendations |

### Methodology repository artifacts

| Artifact | Responsibility |
| --- | --- |
| `skills/agentic-java-modernization/SKILL.md` | Workflow orchestration, phase transitions, invariants, stop rules, and reference routing |
| `skills/agentic-java-modernization/references/` | Focused guidance loaded only for the relevant phase or provider |
| `skills/agentic-java-modernization/assets/` | Templates adapted into target repositories |

## Capability Boundaries

### Coding agent

The coding agent gathers evidence, applies the methodology, proposes decisions, invokes tools, handles repository-specific reasoning, and reports uncertainty. It must not treat its own confidence as approval for risky migration execution.

### Deterministic tools

Build tools, test frameworks, coverage tools, dependency analyzers, OpenRewrite, source control, and CI provide repeatable operations and evidence. Passing a tool does not prove preserved business behavior unless the relevant tests and checks exist.

### CI

CI is an independent verification mechanism. It should reproduce required stage gates and must not be weakened merely to make a migration pass.

## OpenRewrite Integration Boundary

OpenRewrite is an optional deterministic transformation provider.

The workflow must determine the repository state and migration path before selecting recipes. Recipe identifiers, versions, prerequisites, and licenses must be checked against current authoritative sources. A recipe should first run in dry-run mode when supported; its diff must be reviewed before application. Compilation, tests, and repository-specific verification remain mandatory afterward.

OpenRewrite does not decide the business-safe target, approve a stage, validate proprietary dependencies, or replace characterization tests.

## IBM Bob Integration Boundary

IBM Bob is an optional capability provider. Based only on public product documentation, it may support assessment, dependency analysis, Java upgrades, unit-test generation, iterative build-test-diagnose-fix workflows, and validation checkpoints.

The public project must not require Bob, reproduce undocumented Bob behavior, or contain IBM-internal repositories, prompts, configuration, credentials, or conventions. A Bob-backed execution must produce the same vendor-neutral artifacts and satisfy the same independent gates as another agent or tool.

## Public and Internal Separation

Only public documentation, public or synthetic examples, and vendor-neutral methodology belong in this repository. Organization-specific profiles, proprietary code, private dependency information, internal prompts, and confidential configuration must remain in their owning private environments.

When provenance is uncertain, do not copy the material into this project.

## v0.1 Scope

v0.1 will contain:

- one portable modernization skill;
- focused references for discovery, documentation, testing, planning, verification, OpenRewrite, and IBM Bob;
- templates for all target-repository artifacts;
- concise installation and usage examples;
- explicit approval, privacy, baseline, and verification rules.

The following remain future work pending pilot evidence:

- custom OpenRewrite recipes;
- automation scripts and schemas;
- example applications and public case studies;
- CI workflow packages;
- multi-repository governance;
- multi-agent orchestration;
- quantitative quality scoring.

## Pilot Strategy

Validate v0.1 against one representative public or synthetic Java/Spring repository. Choose a repository with meaningful business behavior, realistic dependencies, an executable build, and enough legacy characteristics to exercise discovery and testing decisions.

Pilot failures should improve the reusable method. They must not result in hardcoded repository-specific rules in the skill.
