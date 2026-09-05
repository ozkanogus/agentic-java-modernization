# Production Readiness Review

Use this guide after the selected core runtime/framework migration is green. The
review determines what remains before production use; it must not turn technical
modernization into an unrelated redesign program.

## Milestones

- **Core Migration Complete:** approved platform stages reached their selected
  target and their defined verification gates passed.
- **Production Ready:** every applicable production blocker and required item is
  resolved or explicitly accepted by an authorized owner, and representative
  deployment, regression, and operational validation is complete.

Never infer the second milestone from the first.

## Classify Findings

| Classification | Meaning |
| --- | --- |
| `BLOCKER` | Deployment or safe operation must not proceed. |
| `REQUIRED BEFORE PROD` | Must be completed or explicitly accepted before production integration. |
| `RECOMMENDED` | Material hardening with a documented owner and planned disposition. |
| `DEFERRED` | Intentionally postponed with reason, risk, owner, and review point. |
| `NOT APPLICABLE` | Evidence shows the concern does not apply. |

Classification depends on the repository, environment, data, users, and risk
policy. Do not make every checklist item mandatory.

## Review Areas

### Configuration, credentials, and data

- Find likely embedded passwords, tokens, keys, private endpoints, and unsafe
  defaults without reproducing secret values in output.
- Move runtime configuration to an approved external source where appropriate.
- Treat any committed or reused credential as potentially exposed; externalizing
  it does not rotate or invalidate it. Record the rotation owner outside public
  artifacts when necessary.
- Separate demo, test, seed, and destructive initialization from real data.
- Verify production profiles fail safely when required configuration is absent.

### Database delivery

- Inspect JPA/Hibernate schema-generation settings and current operational schema
  practice before recommending a migration framework.
- Assess Flyway, Liquibase, custom tooling, or manual procedures for versioning,
  validation, rollout, drift, backup, and recovery.
- If introducing versioned migrations, preserve the established schema, test on
  a realistic disposable database, keep schema work separate from unrelated
  framework changes, and document adoption of existing databases.
- Never assume code rollback reverses applied DDL or data changes.

### Security, delivery, and operations

- Review authentication, authorization, input/error exposure, dependency risk,
  secret access, and applicable threat controls.
- Reproduce repository-native build, unit, integration, characterization,
  coverage, packaging, and migration-specific checks in CI.
- Validate runtime configuration, artifact/container, startup/readiness,
  observability, capacity-sensitive behavior, rollback, and incident ownership.
- Track warnings and dependency debt according to impact; do not combine broad
  cleanup with the migration merely to make reports look clean.

### Behavioral confidence

- Revisit critical business workflows and migration-sensitive gaps.
- Use coverage to locate unexamined risk, not as a substitute for assertions.
- Record manual QA or UAT scope, participants/owners, results, and exclusions
  without exposing private identities or data in public artifacts.

## Deployment Validation Gate

Where the delivery environment exists and use is authorized:

```text
modernization candidate
    -> representative test environment
    -> startup/readiness and configuration checks
    -> integration and regression suites
    -> operational checks and rollback exercise where warranted
    -> manual QA / business UAT where applicable
```

A check that cannot run is `NOT RUN`, not passed. State the missing environment
or decision and its risk in `MIGRATION_REPORT.md`.

## Exit Decision

Production readiness is green only when all `BLOCKER` and `REQUIRED BEFORE PROD`
items are resolved or explicitly accepted by an authorized owner, required
deployment/regression evidence is green, documentation matches the candidate,
and production synchronization is current. This decision does not itself
authorize a merge, release, data migration, or deployment.
