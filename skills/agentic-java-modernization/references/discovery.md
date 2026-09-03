# Repository Discovery

Use this guide during Phases 0 and 1. The objective is a reliable modernization snapshot, not an exhaustive code catalog.

## Discovery Order

### 1. Establish scope and instructions

- Confirm the repository root and current working state.
- Read applicable `AGENTS.md` or equivalent repository instructions.
- Identify modules, nested builds, submodules, and generated areas.
- Record whether the worktree is clean; do not discard existing changes.
- Identify confidentiality boundaries before persisting discovered information.

### 2. Inspect build truth

Prefer wrapper and build configuration evidence over prose documentation.

Inspect as applicable:

- `pom.xml`, parent POMs, Maven wrapper, profiles, plugins, and toolchains;
- `settings.gradle*`, `build.gradle*`, Gradle wrapper, convention plugins, and version catalogs;
- compiler source/target or release configuration;
- Spring Boot and Spring dependency management;
- test, coverage, static-analysis, packaging, and code-generation plugins.

Record declared and effective versions separately when inheritance or dependency management makes them differ.

### 3. Map application behavior

Trace representative critical flows from trigger to observable result:

```text
HTTP/message/job trigger
    → validation/security
    → application service
    → domain behavior
    → persistence or external integration
    → response/event/side effect
```

Use entry points and framework configuration to guide the trace. Do not infer business importance solely from class names or code size.

### 4. Inventory migration-sensitive surfaces

Inspect the categories that exist in the repository:

| Surface | Evidence to find |
| --- | --- |
| Web/API | Controllers, filters, advice, media types, route matching, API specifications |
| Security | Filter chains, method security, identity provider integration, authorization tests |
| Persistence | JPA/JDBC clients, entities, repositories, transactions, dialects, schema behavior |
| Database migration | Flyway/Liquibase configuration, migration locations, startup ordering |
| Messaging | Producers, consumers, acknowledgement, retry, ordering, serialization |
| Scheduled work | Schedulers, locks, idempotency, retry, timing assumptions |
| Serialization | Object mapper configuration, custom serializers, stored or published payloads |
| Validation | Bean validation annotations, custom validators, error response mapping |
| Configuration | Property binding, profiles, environment variables, secret names, defaults |
| Integrations | Clients, protocols, timeouts, retries, circuit breakers, test substitutes |
| Operations | Health checks, metrics, tracing, logging, management endpoints |

### 5. Inventory dependencies and compatibility signals

- Capture direct dependencies, BOMs/platforms, plugins, annotation processors, and major transitive constraints.
- Identify deprecated, abandoned, pinned, excluded, shaded, or privately published dependencies.
- Search for migration-sensitive namespaces and APIs, including `javax.*` when relevant.
- Record repositories, mirrors, proxies, or credentials by purpose and name only; never copy secret values.
- Treat generated dependency reports as evidence, not as proof of runtime compatibility.

### 6. Inspect delivery and runtime

- CI workflows and required checks
- Containerfiles, base images, and buildpacks
- deployment descriptors, manifests, and platform runtime versions
- environment-specific profiles and configuration sources
- startup, readiness, liveness, smoke, and rollback procedures

Framework compatibility is insufficient when the delivery platform cannot run the candidate JDK or artifact.

### 7. Establish test visibility

Identify:

- test frameworks and source sets;
- unit, integration, contract, smoke, and end-to-end suites;
- skipped, quarantined, profile-gated, or separately invoked tests;
- coverage tools, exclusions, thresholds, and report paths;
- containers, test data, external services, and nondeterministic dependencies.

Do not silently assume the default `test` task executes every relevant suite.

## Command Discipline

- Prefer repository wrappers such as `./mvnw` and `./gradlew` when present.
- Start with read-only inspection and focused commands.
- Record the exact directory and command for meaningful results.
- Distinguish a failed command from an incompatible repository.
- Do not install runtimes, change dependencies, start infrastructure, or modify production files merely to complete discovery without authorization.
- Do not expose credentials or secret values in logs or persisted artifacts.

## Evidence Labels

Use these labels when clarity matters:

- **Confirmed:** directly supported by repository content or a reproducible command.
- **Inference:** strongly suggested but not directly verified.
- **Unknown:** evidence has not been found or access is unavailable.
- **Blocked:** verification cannot proceed without a decision, dependency, permission, or environment change.

## Repository Profile Quality

A useful profile:

- emphasizes facts that affect documentation, testing, or migration decisions;
- names important business flows and their observable outcomes;
- provides paths and commands selectively;
- surfaces unknowns and risks rather than hiding them;
- remains concise enough to review and update;
- avoids repeating file-by-file inventories or README prose.

Before completing discovery, confirm another session could answer:

1. What does this application do?
2. How is it built and run?
3. Which behaviors and contracts are most important?
4. Which technologies and integrations constrain modernization?
5. What is known, inferred, unknown, or currently broken?
6. Which evidence should be established next?
