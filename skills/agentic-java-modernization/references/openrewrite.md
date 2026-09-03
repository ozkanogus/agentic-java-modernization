# OpenRewrite Integration

Use this guide when a planned migration stage may benefit from deterministic source or configuration transformation.

OpenRewrite is an optional execution provider. It does not replace repository discovery, compatibility assessment, characterization tests, human approval, diff review, or verification.

## Current Public Sources

Check these sources at execution time because recipes, coordinates, prerequisites, distribution, and licenses change:

- [OpenRewrite recipe catalog](https://docs.openrewrite.org/recipes)
- [Java migration recipes](https://docs.openrewrite.org/recipes/java/migrate)
- [Spring recipes](https://docs.openrewrite.org/recipes/java/spring)
- [Spring Boot 3 recipes](https://docs.openrewrite.org/recipes/java/spring/boot3)
- [Spring Boot 4 recipes](https://docs.openrewrite.org/recipes/java/spring/boot4)
- [OpenRewrite documentation](https://docs.openrewrite.org/)

Do not copy a command from this project as proof that its recipe artifact or plugin version is still current.

## Appropriate Uses

Consider OpenRewrite for well-defined, repetitive transformations such as:

- supported Java API and language-level migrations;
- Spring and Spring Boot upgrade recipes;
- configuration property and dependency-coordinate changes;
- namespace or framework API changes;
- build file, plugin, or dependency updates;
- test-framework migrations;
- searches that produce structured migration inventory.

Use repository-specific agent reasoning for target selection, private or unusual dependencies, custom integrations, behavioral compatibility, residual failures, and decisions not encoded by a recipe.

## Recipe Selection Gate

Before proposing a recipe, confirm:

1. The current repository state matches the recipe's stated source assumptions.
2. The recipe's target matches the approved migration stage—not merely the eventual target.
3. Required JDK, Maven/Gradle, plugin, repository, and network prerequisites are available.
4. The recipe source or composition is inspectable enough to understand its scope.
5. Distribution terms and license permit the intended use.
6. The repository's third-party and private dependencies have been assessed separately.
7. The test baseline protects the behavior exposed by the transformation.
8. The resulting change can be reviewed and rolled back independently.

Composite recipes can include dependency, framework, configuration, and test changes beyond their short display name. Inspect their current definition rather than assuming scope.

## Licensing and Distribution

OpenRewrite's ecosystem contains artifacts under different licenses and distribution models. A recipe shown in the public catalog is not automatically Apache-2.0 or automatically available from the same repository as another recipe.

For every selected recipe, record:

- recipe identifier and artifact coordinates;
- exact recipe/plugin version or resolved lock;
- source and documentation URL;
- declared license and any commercial-use constraint;
- artifact repository and authentication requirement;
- date verified.

Never commit artifact-repository credentials. Keep tokens in the user's approved Maven/Gradle credential store or environment and redact them from logs.

## Execution Pattern

Adapt the exact commands from the current recipe documentation.

### 1. Preserve the baseline

- Confirm the working tree state.
- Record the current commit.
- Re-run the stage's entry checks when evidence may be stale.
- Keep unrelated user changes out of the transformation.

### 2. Resolve and inspect

- Resolve the selected recipe and plugin without using unreviewed floating versions in a reproducible stage.
- Inspect the current composite recipe definition and expected file types.
- Record resolution or parsing failures; do not treat partial execution as success.

### 3. Preview

Prefer the supported dry-run, patch, or non-mutating discovery mode.

Review:

- every modified, added, deleted, and renamed file;
- build and dependency changes;
- configuration and property changes;
- test changes and altered assertions;
- generated data tables, parse failures, and skipped sources;
- changes outside the approved scope.

If no preview mechanism is available, run on a disposable branch or isolated worktree and review the complete diff before accepting it.

### 4. Apply only the approved scope

Use the smallest applicable recipe or explicitly reviewed composite. Do not combine unrelated cleanup, dependency refreshes, or future migration stages for convenience.

### 5. Verify

Run the stage checks defined in `MIGRATION_PLAN.md` and [verification.md](verification.md). Compilation alone is insufficient.

### 6. Diagnose residual work

Classify remaining issues as:

- recipe resolution or parser failure;
- unsupported source/build pattern;
- third-party or private dependency incompatibility;
- repository-specific code/configuration gap;
- changed observable behavior;
- environment or delivery constraint.

Use focused agent-assisted fixes only inside the approved stage, then rerun the full planned verification.

## Build Integration Choices

Choose the least intrusive supported execution method for the repository:

- command-line invocation that leaves build files unchanged;
- temporary init script or external configuration;
- build plugin configuration committed for repeatable use;
- Moderne CLI/platform when selected and authorized;
- a custom recipe project only when repeated unsupported transformations justify its maintenance cost.

Document whether temporary integration files should be removed after the stage. Do not leave credentials or unexplained migration plugins in the application build.

## Data Tables and Reports

When enabled, OpenRewrite data tables can identify changed sources, search results, parse errors, metadata failures, and recipe run statistics.

Use them to support review and diagnosis. Do not:

- treat estimated time savings as measured project outcomes;
- commit large generated reports without a maintenance purpose;
- expose private paths, repositories, dependency names, or source fragments outside their authorized context;
- assume an empty result means the repository is compatible.

## Multi-module Repositories

Confirm that the chosen invocation covers the intended reactor or Gradle build and that all modules parse with the correct classpath.

Check:

- parent and child build files;
- included/composite builds and convention plugins;
- dependency management shared across modules;
- generated sources and annotation processors;
- aggregate versus per-module tests and coverage;
- modules silently omitted because dependency resolution failed.

## When Not to Use OpenRewrite

Do not use a recipe when:

- its source state or target does not match the approved stage;
- licensing or artifact access is unclear;
- the preview is unexpectedly broad or unreviewable;
- parsing or dependency resolution omits critical code;
- required behavior lacks an acceptable safety net;
- a small explicit edit is safer and easier to verify;
- the change is primarily a business or architecture decision.

## OpenRewrite Stage Checklist

- [ ] Repository profile and test baseline are current.
- [ ] The migration stage is approved.
- [ ] Recipe applicability and composite scope were inspected.
- [ ] Current versions, coordinates, distribution, and license were verified.
- [ ] Credentials remain outside the repository and logs.
- [ ] A dry run, patch, or isolated execution was reviewed.
- [ ] Parsing, resolution, and skipped-source failures were examined.
- [ ] Only the approved scope was applied.
- [ ] Complete planned verification passed.
- [ ] Generated tooling artifacts were removed or intentionally retained.
- [ ] Actual outcomes and remaining manual work were documented.
