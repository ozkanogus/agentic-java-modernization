# Pilot Case Study: WholesaleFlow ERP

[`ozkanogus/WholesaleFlowERP`](https://github.com/ozkanogus/WholesaleFlowERP)
is an unfinished wholesale operations backend originally developed for a real
wholesale grocery market.
It was never deployed and contained no production data. The public repository
provided a realistic pilot for this methodology: old framework dependencies,
limited tests, no README, an incomplete wrapper, embedded database credentials,
demo initialization, and no CI.

## Verified Starting Point

At the original public revision, the Maven build declared Java 17 and Spring Boot
2.6.3. Four test classes contained nine tests. The repository had no README.
Initial execution was environment-blocked and then exposed incomplete Maven
wrapper metadata and a Lombok annotation-processor configuration failure. These
baseline issues were repaired separately before framework migration.

Coverage was not configured or measured. Test counts below must not be read as a
coverage percentage.

## Core Migration Outcome

The locally verified candidate reached:

- Temurin Java 21.0.12.1 with compiler release 21;
- Spring Boot 4.0.8, including Spring Framework 7;
- the Jakarta namespace transition, Hibernate 7, and Jackson 3 for application MVC;
- Modernizer Maven Plugin 2.7.0 with no rule exclusions;
- 44 passing default-build tests and 60 passing PostgreSQL-profile tests, with
  zero failures, errors, or skips in the recorded final builds;
- packaged startup and API smoke checks;
- equal OpenAPI paths/component schemas and equal normalized PostgreSQL schema
  comparisons across the recorded migration checkpoints.

Java 25 was assessed and intentionally deferred. This is evidence that the
repository reached its selected core target, not a recommendation that every
application follow the same version path.

## Behavior Protected

The safety net grew around stock-movement signs and replacement order, grocery
HTTP responses, missing-resource behavior, packaged entry point, persistence
mappings, PostgreSQL report ordering/month boundaries, purchase and sale
transactions, rollback on foreign-key failures, error payloads, real Tomcat
startup, and Jackson/Hibernate wiring. A reported missing-resource mismatch and
packaged start-class mismatch were reproduced by tests before separate fixes.

The pilot also retained explicit gaps: multi-line aggregate edits, some successful
HTTP writes, broader failure modes, security expectations, performance, and
several operational paths. No coverage percentage was fabricated.

## Production-Readiness Work

Core migration completion did not make the application production ready.
Subsequent isolated stages:

- externalized runtime database settings;
- made random demo-data initialization explicit and disabled by default;
- introduced a verified Flyway V1 schema baseline with Hibernate validation,
  checksum rejection, safe defaults, and a documented existing-schema adoption
  process;
- added a Java 21 GitHub Actions workflow for default and PostgreSQL builds.

Those changes retained 44 default and 60 PostgreSQL-profile passing tests. The CI
workflow and its exact commands were validated locally. After the product-identity
rename, both the hosted Java 21 default build and PostgreSQL 18 build passed.

Authentication/authorization, deployment configuration, observability,
dependency/build warnings, broader business-workflow coverage, and rotation of
any historically reused credential remain unresolved or require
an owner decision. No production deployment or existing-database adoption was
performed.

## Lessons Applied to v1

- A concise profile and AGENTS.md reduced repeated discovery, but snapshot facts
  and chronological history must be separated to prevent stale “current” claims.
- Characterization tests were most valuable at observable service, API,
  persistence, error, and packaging boundaries; test count alone was not useful.
- Focused stages made Jakarta, server, error handling, Boot 4, Java 21, config,
  and Flyway failures attributable and recoverable.
- Human approval mattered when a failed Java 21 attempt required expanding scope
  to Modernizer 2.7.0, when an ambiguous report tie-break became behavior, and
  when database adoption carried data risk.
- Deterministic build/test/schema/OpenAPI comparisons provided stronger evidence
  than an agent success statement.
- Core migration and production readiness require separate milestones and reports.

All results above come from the local pilot repository and its committed
modernization records. Local filesystem paths, credentials, and private runtime
values are intentionally omitted.
