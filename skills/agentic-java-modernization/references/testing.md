# Test Safety-Net Strategy

Use this guide during Phase 3 and when selecting verification for later migration stages. The objective is confidence in observable behavior, not a cosmetically high coverage number.

## Core Rule

Capture the application's current externally observable behavior before changing the platform beneath it.

Legacy behavior may be surprising and still be relied upon. Do not “correct” it during characterization unless a separate behavior change is explicitly approved.

## Establish the Existing Baseline First

Before adding tests or changing build configuration:

1. Identify all relevant test tasks, profiles, source sets, and CI-only suites.
2. Run the least invasive existing compile/build command.
3. Run existing tests using repository wrappers when available.
4. Generate the existing coverage report if already configured.
5. Record environment requirements and exact failures.

Classify every result:

- **Green:** the command completed successfully.
- **Pre-existing red:** failure reproduced before modernization work.
- **Environment-blocked:** the required runtime, service, permission, credential, or network access is unavailable.
- **Inconclusive:** the command does not exercise the behavior it appears to cover, or evidence is insufficient.

Never erase baseline evidence by mixing test-infrastructure repairs with a migration stage.

## Choose Tests by Risk

Prioritize behavior using business criticality, migration sensitivity, and current protection.

| Priority | Typical targets | Useful evidence |
| --- | --- | --- |
| Highest | Money, entitlements, state transitions, compliance, irreversible side effects | Service characterization, transaction tests, API or message contracts |
| High | Authentication/authorization, persistence mappings, serialization, validation, exception handling | Focused integration or slice tests |
| Medium | Configuration binding, external-client adapters, scheduled jobs, retry/idempotency | Binding, adapter contract, clock-controlled, or fixture-backed tests |
| Contextual | Framework wiring and startup | Context or smoke tests with meaningful assertions |
| Low | Trivial accessors, generated code, framework internals | Usually omit or justify exclusion |

Do not infer business criticality from technical complexity alone. Use repository evidence and user/domain input.

## Test Types and Their Roles

### Characterization tests

Record what the application currently does at a stable boundary. Good assertions focus on outputs, persisted state, emitted messages, response status/body/headers, validation results, or authorized side effects.

Characterization tests are especially useful when requirements are incomplete but production behavior is trusted.

### Unit tests

Use for deterministic domain or service behavior with small dependency surfaces. Mock only true boundaries; avoid tests that merely restate implementation calls.

### Integration tests

Use when framework configuration, persistence mapping, transactions, serialization, security filters, or component collaboration is part of the behavior at risk.

Prefer realistic infrastructure when it materially affects behavior and can run reliably. Document containers, schemas, fixtures, and cleanup requirements.

### Contract tests

Protect externally consumed HTTP, event, message, or client-adapter contracts. Include compatibility-sensitive details such as media types, field names, null handling, error structures, headers, and serialization formats.

### Smoke and startup tests

Use to confirm that the application context or deployable artifact starts with representative configuration. Startup success complements but does not replace behavioral tests.

## Characterization Workflow

For each selected behavior:

1. Identify a stable entry boundary and observable result.
2. Build the smallest realistic fixture that reaches that boundary.
3. Control nondeterminism such as time, random values, concurrency, and external systems.
4. Observe the current result before finalizing the assertion.
5. Confirm the test fails when the protected behavior is intentionally perturbed, where safe and practical.
6. Restore the implementation and confirm the test passes.
7. Record the protected flow and remaining gap in `TEST_BASELINE.md`.

Avoid broad snapshots that obscure meaningful changes. When snapshots are appropriate, review and constrain their stable fields.

## Migration-Sensitive Test Checklist

Select only categories present in the application:

- API routing, status codes, content types, request validation, and error payloads
- authentication, authorization, CSRF/CORS, and method security
- entity mappings, queries, transactions, lazy loading, and database constraints
- JSON/XML field names, formats, null/default behavior, and custom serializers
- configuration properties, profiles, default values, and environment overrides
- message payloads, headers, ordering, acknowledgement, retry, and idempotency
- scheduled timing, distributed locks, duplicate prevention, and failure recovery
- external-client request/response translation, timeout, retry, and fallback behavior
- application startup, health endpoints, metrics, and packaging

## Coverage Policy

Generate line and branch coverage where tooling and repository constraints permit. Use coverage to find unexamined risk, not to define correctness.

An approximate 80% meaningful line-coverage target may be useful when realistically achievable, but it is not a universal gate. A lower percentage with critical workflows protected can be safer than a higher percentage dominated by trivial assertions.

Review:

- critical packages with little or no coverage;
- branch-heavy business logic;
- exclusions and their rationale;
- tests that execute code without checking outcomes;
- modules missing from aggregate reports;
- integration suites excluded from the measured task.

Never add getters/setters tests, framework-internal tests, or excessive mocks solely to move the percentage.

## Handling a Red Baseline

Do not silently repair, suppress, or reclassify failures.

For each failure, record:

- exact reproduction command and working directory;
- observed error and relevant evidence location;
- whether it is deterministic;
- required environment or external dependency;
- impact on migration confidence;
- proposed disposition and approver.

Preparation may continue when discovery remains safe, but migration execution should stop unless the risk is understood and explicitly accepted. Prefer a separate baseline-repair change before migration.

## Test Change Boundaries

Before migration:

- add tests that protect current behavior;
- make the minimum build changes required to run and measure them;
- avoid production refactors merely to simplify testing unless separately approved.

During migration:

- change test APIs or fixtures only as required by the approved platform stage;
- distinguish test-framework adaptation from changed business expectations;
- do not update expected results simply because a migrated implementation differs.

After migration:

- run all relevant suites, not just newly added tests;
- compare coverage scope and exclusions with the baseline;
- document intentional, approved behavior changes separately.

## Safety-Net Exit Gate

The phase is ready to close only when:

- [ ] Existing commands and results are recorded.
- [ ] Relevant test suites and omitted suites are understood.
- [ ] Critical business and migration-sensitive flows are protected or identified as accepted gaps.
- [ ] Coverage was measured where feasible and interpreted meaningfully.
- [ ] Pre-existing failures are separate from later regressions.
- [ ] Environment dependencies and nondeterminism are documented.
- [ ] `TEST_BASELINE.md` is current and reviewable.
- [ ] The authorized reviewer accepts any residual risk before migration execution.
