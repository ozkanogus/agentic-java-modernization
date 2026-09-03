# Compatibility-Driven Migration Planning

Use this guide during Phases 4 and 5. Its purpose is to select a defensible target and a sequence of independently verifiable stages—not to justify a predetermined upgrade.

## Inputs Required

Begin planning only when these inputs are current enough to support decisions:

- `.modernization/REPOSITORY_PROFILE.md`
- `.modernization/TEST_BASELINE.md`
- build and dependency evidence
- delivery/runtime constraints
- critical business flows and contracts
- known pre-existing failures and accepted gaps
- current authoritative compatibility documentation

If an input is missing, identify the smallest safe action needed to obtain it. Do not fill evidence gaps with assumed compatibility.

## Separate Four Kinds of Information

For each compatibility claim, label it as:

- **Confirmed:** directly supported by current authoritative documentation or reproducible repository evidence.
- **Inference:** a reasoned conclusion that still needs validation.
- **Unknown:** evidence has not been located or cannot be accessed.
- **Blocked:** a required dependency, decision, platform, or capability prevents progress.

Record source URLs and access dates for volatile external claims. Prefer primary documentation, release notes, compatibility matrices, and maintained project repositories.

## Assess the Whole Runtime Stack

A viable target must satisfy more than Java and Spring Boot requirements.

### Language and runtime

- candidate JDK support and maintenance window
- compiler configuration and bytecode target
- removed JDK modules, APIs, JVM flags, and garbage collectors
- runtime images used by developers, CI, containers, and deployment platforms

### Framework ecosystem

- Spring Boot, Framework, Security, Data, Batch, Integration, Cloud, and related release trains
- Jakarta namespace transitions and servlet/container requirements
- configuration property, actuator, observability, and test infrastructure changes

### Build and engineering tools

- Maven/Gradle wrapper compatibility with current and target JDKs
- compiler, test, coverage, packaging, code-generation, quality, and release plugins
- annotation processors such as Lombok or MapStruct
- artifact repositories, BOMs, convention plugins, and private parent builds

### Application dependencies

- database drivers and dialects
- schema migration tools
- serialization and API documentation libraries
- messaging clients and brokers
- authentication/authorization integrations
- HTTP clients, cloud SDKs, vendor starters, and abandoned libraries
- internal dependencies whose source or compatibility evidence is unavailable

### Delivery and operations

- CI runner images and required checks
- container base images and buildpacks
- deployment platform runtime support
- health/readiness behavior, metrics, tracing, and log integration
- rollback and backward-compatibility constraints

## Select Candidate Targets

For each candidate target, answer:

1. Is it supported by the application's required dependencies and platform?
2. Does it provide a meaningful support, security, or maintainability benefit?
3. Can the repository reach it through verifiable intermediate states?
4. Can critical behavior be tested at each risky boundary?
5. Which unknowns could invalidate the path?
6. Is a nearer stopping point safer or more valuable?

Present at least the recommended target and any materially viable stopping point. Reject or defer candidates with explicit reasons.

Do not treat “latest” as a benefit by itself. A lower supported target can be correct when a critical library, platform, or delivery constraint blocks further movement.

## Build a Migration Graph

Model migration stages as nodes with prerequisites rather than a fixed list of version jumps.

```text
Current state
    |
    +--> remove deprecations on current platform
    |         |
    |         v
    +--> update build tool/plugin prerequisites
              |
              v
         candidate runtime
              |
              v
       candidate framework
```

The actual graph may branch around optional components, blocked dependencies, deployment work, or separately owned systems. Merge branches only after their prerequisites and verification evidence agree.

Useful stage boundaries often align with one of these concerns:

- restore or strengthen the baseline;
- remove deprecations while still on the current platform;
- update a build wrapper or incompatible plugin;
- move to a required intermediate runtime;
- align to the latest compatible release within the current major line;
- perform a namespace or specification transition;
- upgrade one framework major version;
- replace or isolate one blocking dependency;
- update CI/container/deployment runtime;
- adapt observability or operational contracts.

These are candidates, not mandatory stages.

## Define Every Stage as a Contract

Each stage in `MIGRATION_PLAN.md` must state:

- **Purpose:** the single modernization outcome.
- **Rationale:** why it belongs at this point in the graph.
- **In scope:** exact dependency, build, source, configuration, test, and delivery areas.
- **Out of scope:** adjacent work intentionally deferred.
- **Entry criteria:** baseline, toolchain, approvals, and prerequisite stages.
- **Execution approach:** deterministic recipes and anticipated repository-specific work.
- **Verification:** exact commands and observable behavioral checks.
- **Rollback:** commit, branch, configuration, database, or deployment recovery method.
- **Risks/unknowns:** including ownership and evidence needed.
- **Approval:** status, owner, and date.

A stage that cannot be verified independently is probably too broad or missing a prerequisite.

## Deterministic Versus Agent-Assisted Work

Prefer deterministic tooling for repetitive, well-defined source or configuration transformations when:

- an applicable maintained recipe exists;
- prerequisites and license are understood;
- a dry run or reviewable patch is available;
- the resulting diff can be tested meaningfully.

Use agent-assisted reasoning for:

- application-specific compatibility analysis;
- business and architecture interpretation;
- long-tail dependencies and custom integrations;
- diagnosing residual build or test failures;
- adapting behavior-preserving tests and documentation.

Neither method removes the approval or verification gates.

## Change Isolation

Keep the following separate unless evidence shows they must move together:

- behavior changes and framework migration;
- broad refactoring and version upgrades;
- test expectation changes and test-framework API changes;
- database schema changes and persistence-provider upgrades;
- operational redesign and runtime compatibility work;
- unrelated dependency refreshes.

Smaller stages improve diagnosis and rollback only when each leaves the repository in a coherent, supportable state.

## Approval Rules

Planning artifacts may be created or revised without authorizing migration execution.

Require explicit approval before:

- the first runtime/framework migration stage;
- choosing among materially different targets;
- replacing a business-critical or privately maintained dependency;
- accepting a red or materially incomplete baseline;
- intentionally changing observable behavior;
- making irreversible data, deployment, or external-contract changes.

Approval applies to the documented stage scope. Discovering adjacent work does not expand it.

## Stop Conditions

Stop planning or execution when:

- a critical compatibility claim remains unresolved;
- authoritative sources conflict and the decision is material;
- a required private dependency cannot be assessed;
- the baseline cannot distinguish regressions reliably;
- the planned stage lacks a realistic rollback or verification path;
- execution would cross an authorization or confidentiality boundary;
- the current stage is red or inconclusive.

State what evidence or decision would unblock progress.

## Plan Review Checklist

- [ ] Recommended target follows from evidence, not recency alone.
- [ ] Viable stopping points and rejected targets are explained.
- [ ] Runtime, framework, build, dependencies, delivery, and operations were assessed.
- [ ] Confirmed facts, inferences, unknowns, and blockers are distinct.
- [ ] The migration graph reflects real prerequisites.
- [ ] Every stage has scope, entry criteria, verification, rollback, risks, and approval status.
- [ ] Business redesign and unrelated refactoring are excluded.
- [ ] Deterministic tools are proposed only where applicable and reviewable.
- [ ] No stage is represented as approved without explicit authorization.
