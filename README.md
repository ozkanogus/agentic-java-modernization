# Agentic Java Modernization

A vendor-neutral, agent-assisted methodology for modernizing established Java applications safely.

The project focuses on understanding a repository, documenting its current state, establishing a behavioral test safety net, assessing compatibility, and executing approved migration stages with verification after every change.

## Status

This project is in early v0.1 development. The initial deliverable is a reusable coding-agent skill supported by focused reference guides and templates.

## Principles

- Understand the repository before changing it.
- Preserve observable business behavior.
- Separate pre-existing failures from migration failures.
- Let compatibility analysis determine the target and intermediate stages.
- Prefer deterministic transformations where suitable.
- Require human approval before migration execution.
- Build and test after every migration stage.
- Keep the public project free of proprietary or confidential material.

## Planned v0.1 Scope

- Repository discovery and profiling
- Documentation baseline
- Characterization-test strategy
- Migration assessment and planning
- Incremental execution and verification gates
- OpenRewrite guidance
- Optional IBM Bob integration using public capabilities only
- Reusable repository artifact templates

Implementation documentation will be added incrementally on focused feature branches.

## License

Licensed under the Apache License 2.0. See [LICENSE](LICENSE).
