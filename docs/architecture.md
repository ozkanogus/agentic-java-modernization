# Architecture

## Purpose

Agentic Java Modernization is a reusable methodology for understanding,
protecting, planning, incrementally modernizing, and assessing the production
readiness of established Java applications. It defines decisions, evidence,
artifacts, approval gates, and verification rules; it is not a migration engine.

## v1 System Model

```text
one target repository
        +
one capable coding agent
        +
one reusable modernization skill
        +
deterministic tools and CI
        +
human approval gates
```

The agent analyzes, proposes, and implements bounded work. Repository-native
builds, tests, static checks, migration tools, and CI produce repeatable evidence.
Humans approve risky transitions. v1 deliberately avoids multi-agent orchestration.

## Goals and Non-goals

The method aims to preserve observable behavior, reduce repeated discovery,
select targets from compatibility evidence, isolate failures to reviewable
stages, and make readiness risks visible. It remains portable across capable
coding agents and optional tooling.

It does not prescribe the newest Java or Spring release, guarantee compatibility,
redesign business behavior, replace repository-native tools, automate production
rollout, or make a deployment decision on behalf of an owner.

## Lifecycle

```text
Repository
    |
    v
Discovery -> Repository Profile
    |              |
    +-----> Documentation Baseline (README / AGENTS)
    |              |
    +-----> Test Safety Net (characterization / coverage baseline)
                   |
                   v
              Green Baseline
                   |
                   v
        Compatibility Assessment
                   |
                   v
            Migration Plan
                   |
                   v
          Human Approval Gate
                   |
                   v
       Incremental Migration Stage
                   |
                   v
         Deterministic Verification
                   |
              green? -- no --> stop
                   |
                  yes
                   v
       Core Migration Complete
                   |
                   v
       Production Readiness Review
                   |
                   v
       Deployment Validation Gate
                   |
                   v
          Regression / QA / UAT
                   |
                   v
          Final Verification
                   |
                   v
           Migration Report
                   |
                   v
       Human-approved Production Integration
```

Discovery, documentation, and the test safety net may iterate, but production
behavior is not changed during initial discovery. Every migration stage returns
through its own verification gate. A red or inconclusive stage stops progression.

## Milestones

### Core Migration Complete

The selected runtime/framework target has been reached through approved stages,
and each stage's planned gates passed. This is a technical milestone.

### Production Ready

Applicable production blockers and required items are resolved or explicitly
accepted, the candidate is synchronized with production truth, and representative
deployment, regression, operational, and UAT evidence is complete. This is a
separate operational decision. Neither milestone alone authorizes a merge,
release, data migration, or deployment.

## Phase Gates

| Phase | Exit evidence |
| --- | --- |
| Discovery/profile | Current facts, important unknowns, critical flows, dependencies, delivery constraints, reproducible evidence |
| Documentation | Concise human README, actionable AGENTS.md, current profile without stale history |
| Test safety net | Existing and characterization tests, critical-flow protection, measured coverage or `Not measured`, explicit gaps |
| Green baseline | Comparable build/test commands pass, or residual failures are recorded and explicitly accepted |
| Assessment/plan | Repository-specific target and migration graph, risks, rollback, branch/synchronization plan, approvals |
| Stage execution | One approved scope only; full diff reviewed |
| Stage verification | Relevant build, tests, contracts, runtime, schema, packaging, and delivery checks are green |
| Core completion | All intended technical stages green; current artifacts synchronized |
| Production readiness | Applicable findings classified and owned; blockers and required items resolved or accepted |
| Deployment/regression | Representative environment evidence, operational checks, QA/UAT where applicable |
| Final integration | Current production revision synchronized, final gates green, normal human release policy satisfied |

Coverage is a quality signal, not the objective. Approximately 80% meaningful
line coverage can guide investment where realistic, but protected critical
behavior and strong assertions matter more than a percentage.

## Artifact Responsibilities

| Artifact | Responsibility |
| --- | --- |
| `README.md` | Purpose, business context, architecture, setup, configuration, tests, build, deployment, and evidenced operations for humans |
| `AGENTS.md` | Exact commands, conventions, hazards, sensitive/generated areas, and mandatory repository checks for coding agents |
| `.modernization/REPOSITORY_PROFILE.md` | Concise current-state facts that reduce rediscovery; not a chronological log |
| `.modernization/TEST_BASELINE.md` | Existing/added tests, meaningful behavior protection, results, measured coverage, gaps, and baseline failures |
| `.modernization/MIGRATION_PLAN.md` | Compatibility-derived target, stages, gates, approvals, stopping rules, branching, and production synchronization |
| `.modernization/MIGRATION_REPORT.md` | What occurred: original/final state, deviations, evidence, readiness, deployment validation, risks, and deferred work |
| `SKILL.md` | Portable orchestration, invariants, phase transitions, stop rules, and focused reference routing |
| `references/` | Conditional guidance for one phase or optional provider |
| `assets/` | Adaptable target-repository templates |

The profile represents the current snapshot. The report and focused result
records carry chronological evidence. This prevents historical “latest” sections
from being mistaken for the current state.

## Migration Graph and Branching

Targets and intermediate checkpoints come from the repository's runtime,
framework, dependency, build, delivery, and operational constraints. A path such
as Boot 2 to 3 to 4 is not universal, and a supported nearer target is a valid
stopping point.

For a long-running effort:

```text
main/master (production truth)
       |
       +---- normal product work
       |
       +---- modernization/integration (future candidate)
                         |
                 modernization/<stage>
                         |
                    review + CI
                         |
                 modernization/integration
                         |
              deployment / regression / UAT
                         |
                 final integration review
                         |
                    main/master
```

Stage names follow the migration plan. Teams choose merge or rebase according to
their policy. The integration line is synchronized regularly with production
truth and reverified; a candidate passing against an old snapshot is not current.
A short migration may use the repository's normal PR workflow without inventing
a long-lived branch.

## Capability Boundaries

The core is agent- and vendor-neutral. OpenRewrite can provide optional,
reviewable deterministic transformations after target selection and approval.
IBM Bob can provide optional publicly documented analysis, testing, migration,
and verification capabilities. Neither is required, and neither replaces tests,
CI, repository-specific reasoning, approvals, or licensing review.

The public project contains only public documentation, original methodology,
and public or synthetic evidence. Proprietary repositories, internal prompts,
credentials, customer data, private dependency details, and non-public IBM
configuration remain in their authorized environments. Stop for human review
when provenance or publication rights are uncertain.

## Production Readiness

After core migration, assess applicable configuration/secrets, database rollout,
CI, authentication/authorization, dependency and warning debt, deployment,
observability, rollback, and residual business-flow tests. Classify findings as
`BLOCKER`, `REQUIRED BEFORE PROD`, `RECOMMENDED`, `DEFERRED`, or
`NOT APPLICABLE`. Do not make all categories mandatory for every application.

Externalizing a secret does not rotate it. Adding versioned database migrations
does not make legacy-schema adoption automatic. Code rollback does not reverse
DDL. These require explicit ownership and environment-specific evidence.

## Pilot Feedback Applied to v1

The public WholesaleFlow ERP pilot showed that profiles and working agreements
reduced rediscovery, characterization tests exposed behavioral defects before
framework changes, focused branches made migration failures attributable, and
human gates contained scope. It also showed that chronological updates can make
profile/plan artifacts stale, coverage can remain unmeasured despite growing test
counts, and a green Java/framework migration can precede configuration, schema,
CI, security, and deployment readiness. v1 addresses those observed gaps without
adding multi-agent or speculative automation complexity.
