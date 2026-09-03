# IBM Bob Integration

Use this guide when IBM Bob is available and the user chooses it as a capability provider for a Java modernization workflow.

IBM Bob is optional. The methodology, artifacts, quality gates, and approval rules remain vendor-neutral and must also work with other capable coding agents and tools.

## Public Sources

Verify current capabilities and prerequisites before use:

- [IBM Bob Java modernization](https://www.ibm.com/products/ai-coding-agent/java-modernization)
- [IBM Bob Java modernization prerequisites](https://bob.ibm.com/docs/ide/premium-packages/java-modernization/prerequisites)
- [IBM Bob documentation](https://bob.ibm.com/docs/)
- [IBM Bob changelog](https://bob.ibm.com/docs/ide/changelog)

This guide describes only public capabilities. Product behavior, package contents, supported targets, commands, licensing, and prerequisites can change.

## Publicly Documented Capability Map

Current public IBM material describes Java modernization support that can include application and dependency analysis, Java upgrades, unit-test generation, iterative build-test-diagnose-fix loops, validation checkpoints, documentation, approvals, traceable changes, and security/CVE awareness.

Map those capabilities to this methodology as follows:

| Methodology phase | Potential Bob contribution | Required vendor-neutral output or gate |
| --- | --- | --- |
| Discover/profile | Application, architecture, build, and dependency analysis | Evidence recorded in `REPOSITORY_PROFILE.md` |
| Documentation | Generated or updated technical documentation | Human-reviewed README/profile content with no confidential leakage |
| Test safety net | Unit-test generation and iterative test improvement | Behavior-focused tests and `TEST_BASELINE.md`; coverage alone is insufficient |
| Assessment/planning | Compatibility findings and guided upgrade planning | Repository-specific migration graph, risks, stopping points, and approval |
| Execute | Java, dependency, configuration, or supported modernization changes | Exactly one approved stage with reviewable diff |
| Verify | Build-test-diagnose-fix and validation checkpoints | Independent planned checks and baseline comparison |
| Report/govern | Traceable changes, documentation, and approval evidence | Updated repository artifacts and `MIGRATION_REPORT.md` |

The mapping indicates where Bob may help; it does not assert that every installation, license, or package exposes every capability.

## Boundary of Responsibility

### This skill owns

- phase ordering and entry/exit gates;
- repository artifact formats;
- characterization-first testing policy;
- compatibility-driven target selection;
- explicit approval boundaries;
- stage isolation and stop conditions;
- independent verification and evidence requirements;
- separation of public and private material.

### IBM Bob may provide

- specialized discovery and modernization workflows;
- dependency and compatibility analysis;
- test generation or maintenance;
- deterministic or AI-assisted code/configuration changes;
- iterative diagnosis and validation;
- platform-specific guidance when licensed and available.

### Bob does not automatically prove

- that a selected target is correct for this repository;
- that generated tests protect critical observable behavior;
- that private dependencies support the target;
- that local success reproduces CI or deployment behavior;
- that a stage is approved;
- that confidential output is safe to publish;
- that business behavior remained unchanged.

## Prerequisite Check

Use current IBM documentation rather than copying static product requirements into a migration plan.

Confirm at least:

- installed/authenticated IBM Bob version;
- entitlement to the required Java modernization package or capability;
- supported operating system, JDK, and package-management prerequisites;
- correct project root, Maven/Gradle build, and module layout;
- resolved dependencies and known baseline compilation state;
- clean or otherwise protected Git working state;
- terminal and authorized network access;
- target runtime availability where required;
- repository-specific workflow prerequisites.

If the existing application does not meet a documented prerequisite, record that as a planning constraint. Do not modify the repository merely to satisfy Bob without placing that work in an approved stage.

## Protect Sensitive Material

Before Bob analyzes a repository:

1. Identify credentials, private keys, production data, sensitive test fixtures, large generated artifacts, and irrelevant private content.
2. Configure the documented `.bob/.bobignore` mechanism where appropriate.
3. Verify exclusions rather than assuming ignore patterns are correct.
4. Keep credentials in approved external stores; never place secret values in prompts, profiles, logs, or migration reports.
5. Confirm generated documentation and reports are suitable for their destination before committing or publishing them.

`.bobignore` is one control, not a substitute for repository access controls, data classification, human review, or public/private separation.

## Public Versus Internal Context

The public `agentic-java-modernization` project may contain:

- links to public IBM documentation;
- vendor-neutral capability mappings;
- public prerequisites and safe integration principles;
- synthetic or public examples;
- references to IBM Bob as an optional provider.

It must not contain:

- IBM-internal repositories, source, prompts, modes, skills, or configurations;
- internal URLs, issue references, organization names, or architecture details;
- credentials, entitlements, tokens, or private dependency information;
- customer information or proprietary migration results;
- claims about undocumented Bob behavior.

Repository-specific IBM context belongs only in its authorized private environment. When provenance or publication rights are uncertain, do not transfer the material.

## Workflow Pattern

### 1. Prepare outside Bob

- Establish requested mode and authorization scope.
- Read repository instructions and confidentiality boundaries.
- Confirm working-tree state and protect unrelated changes.
- Review the current public Bob prerequisites.

### 2. Use Bob for an explicit phase outcome

Give Bob a bounded request tied to a methodology artifact or approved stage. Examples:

- analyze repository structure and dependencies without changing files;
- help generate behavior-focused tests for named critical classes or flows;
- assess a defined Java target and list compatibility evidence;
- execute only a documented, approved migration stage;
- diagnose a specific build or test failure without expanding scope.

Do not ask Bob to “modernize everything” without the baseline, migration graph, and stage approval.

### 3. Normalize the output

Translate useful findings into the vendor-neutral repository artifacts. Mark Bob-generated claims as unverified until supported by repository evidence, commands, or authoritative documentation.

Avoid copying verbose transcripts into the repository. Capture concise decisions and evidence.

### 4. Review changes and evidence

- inspect the complete diff;
- confirm only the requested phase or approved stage changed;
- review generated tests for behavioral value;
- review dependencies/configuration for unintended updates;
- remove or ignore temporary artifacts appropriately;
- scan outputs for confidential or private material.

### 5. Verify independently

Run the commands and checks specified by `AGENTS.md`, `MIGRATION_PLAN.md`, and [verification.md](verification.md). CI remains an independent verifier when available.

Do not accept a Bob success message as a substitute for reproducible results.

### 6. Stop at the gate

After one stage, record green, red, inconclusive, or rolled-back status. Do not continue to the next migration stage without its approval.

## Test Generation Rules

When using Bob to generate or update tests:

- select targets from business criticality and migration sensitivity;
- describe the observable behavior and boundary to protect;
- inspect assertions, fixtures, mocks, and test naming;
- confirm tests execute through the intended production path;
- reject trivial getter/setter tests and mocks that merely restate implementation calls;
- verify test discovery and demonstrate that the test can detect a relevant perturbation where safe;
- run the relevant suite and update measured coverage;
- record protected flows and gaps in `TEST_BASELINE.md`.

Generated test count and coverage increases are not proof of regression protection.

## Build-Test-Diagnose-Fix Loop

Use iterative fixing within the approved stage:

```text
Build/test
    |
    v
Classify failure against baseline
    |
    v
Apply smallest in-scope fix
    |
    v
Run focused check
    |
    v
Run complete planned verification
```

Stop when a fix would:

- change observable business behavior;
- broaden the approved stage;
- replace a critical dependency;
- weaken a test or quality gate;
- require unapproved credentials, environments, or external changes;
- expose confidential context;
- leave the result red or inconclusive.

## Integration Checklist

- [ ] Bob use was explicitly selected and its current public capabilities were checked.
- [ ] Required installation, authentication, entitlement, and project prerequisites are satisfied.
- [ ] Repository access and confidentiality boundaries are understood.
- [ ] `.bob/.bobignore` and other protections exclude sensitive or irrelevant material where needed.
- [ ] The request is bounded to one phase outcome or approved stage.
- [ ] Findings are normalized into vendor-neutral artifacts and independently verified.
- [ ] Generated tests protect observable behavior rather than metrics alone.
- [ ] The complete diff and outputs were reviewed for scope and confidentiality.
- [ ] Build, tests, and relevant runtime/delivery checks are reproducible.
- [ ] Stage status and evidence are recorded.
- [ ] No IBM-internal material entered the public project.
- [ ] No next stage began without approval.
