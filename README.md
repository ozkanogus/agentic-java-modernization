# Agentic Java Modernization

A vendor-neutral, agent-assisted methodology for modernizing established Java applications safely.

The project helps a coding agent understand an application, improve its documentation, establish a behavioral test safety net, assess compatibility, and execute one approved migration stage at a time. It does not assume every repository should reach the newest Java or Spring Boot release.

## Status

v0.1 is under development. The repository currently contains the core skill, its focused reference guides, reusable artifact templates, and the project architecture.

## Why This Project Exists

Long-lived Java applications often combine valuable production behavior with old runtimes, incomplete documentation, uneven tests, and dependency constraints. A framework upgrade that only makes the code compile can still change API contracts, persistence, security, serialization, configuration, or operational behavior.

This project treats modernization as an evidence-driven lifecycle:

```text
Discover → Profile → Document → Protect behavior → Assess compatibility
    → Plan a migration graph → Approve one stage → Execute → Verify → Report
```

## Principles

- Understand the repository before changing it.
- Preserve current observable business behavior.
- Separate pre-existing failures from migration regressions.
- Let compatibility analysis determine targets and intermediate stages.
- Prefer reviewable deterministic transformations where suitable.
- Require human approval before migration execution.
- Build and test after every migration stage.
- Stop when a stage is red or evidence is inconclusive.
- Keep the public project free of proprietary or confidential material.

## What v0.1 Provides

- Repository discovery and concise profiling
- README and `AGENTS.md` responsibility boundaries
- Characterization-test and meaningful-coverage strategy
- Compatibility-driven target selection and migration graphs
- Incremental execution and verification gates
- Optional OpenRewrite integration guidance
- Optional IBM Bob integration using public capabilities only
- Templates for repository profile, test baseline, migration plan, and report

The project deliberately does not include custom migration code, custom OpenRewrite recipes, multi-agent orchestration, example applications, or CI packages yet. Those require evidence from a pilot repository.

## Repository Structure

```text
.
├── README.md
├── AGENTS.md
├── CONTRIBUTING.md
├── LICENSE
├── docs/
│   └── architecture.md
└── skills/
    └── agentic-java-modernization/
        ├── SKILL.md
        ├── agents/
        │   └── openai.yaml
        ├── references/
        │   ├── discovery.md
        │   ├── documentation.md
        │   ├── testing.md
        │   ├── migration-planning.md
        │   ├── verification.md
        │   ├── openrewrite.md
        │   └── ibm-bob.md
        └── assets/
            └── *.template.md
```

See [docs/architecture.md](docs/architecture.md) for phase gates, artifact responsibilities, integration boundaries, and v0.1 scope.

## Install or Load the Skill

The package follows the public [Agent Skills specification](https://agentskills.io/specification). The portable skill directory is:

```text
skills/agentic-java-modernization/
```

How a skill is registered varies by coding-agent product and version. Use the product's current skill-management workflow to add that entire directory; do not copy only `SKILL.md`, because the references and templates are part of the package.

For local Codex development, a typical source checkout can be linked into the personal skill directory:

```bash
mkdir -p ~/.codex/skills
ln -s "$(pwd)/skills/agentic-java-modernization" ~/.codex/skills/agentic-java-modernization
```

Run that command from this repository root. If the destination already exists, inspect it instead of overwriting it. Restart or reload the coding agent if its current version does not detect newly added skills automatically.

For Claude Code, Cursor, IBM Bob, or another skill-aware agent, use its current documented import/location mechanism. If the product does not support Agent Skills directly, provide `SKILL.md` and only the referenced guide needed for the current phase as explicit context. Keep approval gates intact.

## Usage

The skill supports four modes: Analyze, Prepare, Execute, and Full Workflow. If the request does not clearly authorize planning or execution, it defaults to Analyze.

### Analyze Only

```text
Use the agentic-java-modernization skill to analyze this repository.

Complete repository discovery, create or update the repository profile,
assess the documentation, and evaluate the current test safety net.
Do not plan or perform a migration.
```

Expected outputs include an evidence-based `.modernization/REPOSITORY_PROFILE.md`, documentation findings, and test-baseline assessment. Production code should not change during initial discovery.

### Prepare a Migration

```text
Use the agentic-java-modernization skill and the current repository profile
and test baseline to determine the safest modernization path.

Produce a compatibility assessment and staged migration graph.
Recommend a target and viable stopping points, but do not execute a stage.
```

Expected output: `.modernization/MIGRATION_PLAN.md` with evidence, risks, prerequisites, rollback, verification, and approval state for every proposed stage.

### Execute the Next Approved Stage

```text
Use the agentic-java-modernization skill to execute only the next approved
migration stage in .modernization/MIGRATION_PLAN.md.

Review deterministic options, apply only the approved scope, run the complete
planned verification, update the migration report, and stop before another stage.
```

A green result completes only that stage. A red or inconclusive result stops progression.

### Full Preparation Workflow

```text
Use the agentic-java-modernization skill to prepare this repository for safe
modernization. Complete discovery, documentation, the test safety net,
compatibility assessment, and migration planning.

Pause for my explicit approval before changing runtime or framework versions.
```

## Tool Integrations

### OpenRewrite

OpenRewrite can perform deterministic transformations after the skill identifies an appropriate migration stage. Recipe applicability, composition, artifact coordinates, distribution, and license must be checked against current documentation. Preview and review the complete change before application, then run repository-specific verification.

See [the OpenRewrite integration guide](skills/agentic-java-modernization/references/openrewrite.md).

### IBM Bob

IBM Bob can be selected as an optional capability provider for publicly documented analysis, Java modernization, unit-test generation, iterative build/test/fix work, and validation. Bob output must still satisfy the same vendor-neutral artifacts and independent gates.

IBM-specific private configuration and repository context must remain outside this public project. See [the IBM Bob integration guide](skills/agentic-java-modernization/references/ibm-bob.md).

## Generated Repository Artifacts

When applied to a target application, the skill keeps human and agent documentation at the repository root and groups modernization evidence under `.modernization/`:

```text
README.md
AGENTS.md
.modernization/
├── REPOSITORY_PROFILE.md
├── TEST_BASELINE.md
├── MIGRATION_PLAN.md
└── MIGRATION_REPORT.md
```

Templates are under [`skills/agentic-java-modernization/assets/`](skills/agentic-java-modernization/assets/). Remove irrelevant sections instead of leaving empty boilerplate.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Changes should remain focused, vendor-neutral, evidence-based, and free of confidential material.

## License

Licensed under the [Apache License 2.0](LICENSE).
