# Documentation Standard

Use this guide during Phase 2 and when finalizing a completed stage. Documentation should reduce rediscovery without duplicating the source tree.

## Responsibility Boundaries

| Artifact | Primary audience | Answers | Avoid |
| --- | --- | --- | --- |
| `README.md` | Developers and operators | What the application does, why it exists, how it works, and how to build, test, run, deploy, and operate it | Agent policy, exhaustive inventories, unsupported claims |
| `AGENTS.md` | Coding agents | Which commands, conventions, constraints, hazards, and checks govern repository work | General onboarding prose and duplicated architecture narrative |
| `.modernization/REPOSITORY_PROFILE.md` | Humans and agents | What the repository currently contains and which facts affect modernization | Instructions, target-state assumptions, and file-by-file catalogs |
| `.modernization/TEST_BASELINE.md` | Reviewers and agents | Which behaviors are protected, what passed or failed, and where gaps remain | Aspirational test plans presented as measured results |
| `.modernization/MIGRATION_PLAN.md` | Approvers and executors | Which target and stages are proposed, why, with what risks and gates | Treating a proposal as execution approval |
| `.modernization/MIGRATION_REPORT.md` | Maintainers and reviewers | What actually changed, what evidence passed, and what remains | Fabricated metrics or unexecuted work |
| `SKILL.md` | Coding agents | How to perform modernization across repositories | Facts about one application |

## README Guidance

Write for a developer encountering the application for the first time. Lead with purpose and business context, then explain only the architecture needed to work safely.

Include sections when supported and relevant:

- application purpose and business context;
- architecture overview and main business flows;
- technology stack and repository structure;
- external dependencies and configuration names;
- local development, database setup, tests, and build;
- deployment, monitoring, operations, and troubleshooting.

Use exact commands that were verified or clearly mark them as unverified. Do not publish secret values, private URLs, customer data, or internal operational details to a public repository.

Avoid:

- describing every package or class;
- repeating build files without interpretation;
- claiming support, behavior, or deployment paths that were not verified;
- preserving obsolete README sections merely because they already exist;
- deleting useful context when improving weak sections.

## AGENTS.md Guidance

Keep repository-level instructions short and actionable. Include:

- the repository purpose in a few lines;
- the directory from which commands must run;
- fast and full verification commands;
- non-obvious architecture and testing conventions;
- critical or dangerous areas and the checks protecting them;
- generated files and regeneration commands;
- integration or local-environment constraints;
- modernization-specific stop and verification rules.

Use nested `AGENTS.md` files only when a module genuinely requires different instructions. The closest applicable instructions should refine rather than unnecessarily duplicate root guidance.

Do not put volatile repository facts in both `AGENTS.md` and the repository profile. Prefer:

- operational rule → `AGENTS.md`;
- discovered fact → repository profile;
- human explanation → README.

## Repository Profile Guidance

The profile is a point-in-time snapshot. Include a last-verified date and evidence for facts that materially affect migration decisions.

Update the profile when a stage changes:

- Java, framework, build, or plugin versions;
- module structure or entry points;
- persistence, security, messaging, or integration architecture;
- test commands or coverage configuration;
- runtime, container, CI, or deployment requirements;
- previously unknown or blocked compatibility facts.

Do not update it for incidental implementation details with no modernization relevance.

Keep chronological stage evidence out of the current-state profile. Use the
migration report or focused result records for superseded checkpoints, and make
the report's current milestone/status visibly distinct from historical entries.

## Writing Rules

- Preserve established repository terminology.
- Separate confirmed facts from inference.
- Prefer short examples and tables when they reduce repetition.
- Keep commands copyable and state their working directory.
- Link to authoritative repository files instead of copying large content.
- Use diagrams only for relationships that prose cannot explain as clearly.
- Remove template sections that do not apply.
- Never leave placeholder text in completed artifacts.

## Review Checklist

- [ ] README explains purpose, critical flows, and verified developer operations.
- [ ] AGENTS.md contains exact operational instructions and constraints.
- [ ] Repository profile captures current modernization facts and unknowns.
- [ ] The three artifacts do not substantially duplicate each other.
- [ ] Commands, paths, and version claims are supported by evidence.
- [ ] No secret, proprietary, or unnecessary internal material was introduced.
- [ ] Documentation changed by the migration stage reflects the resulting state.
