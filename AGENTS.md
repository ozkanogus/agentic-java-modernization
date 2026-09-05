# Repository Instructions

## Purpose

This repository develops a vendor-neutral methodology and reusable skill for safe, agent-assisted Java modernization.

## Non-negotiable Boundaries

- Never add proprietary source code, internal repository details, credentials, confidential prompts, or non-public configuration.
- Treat IBM Bob and OpenRewrite as optional capability providers, not mandatory foundations.
- Do not prescribe a fixed Java or Spring Boot target without repository-specific compatibility evidence.
- Do not perform a migration before documenting the baseline, safety-net status, plan, and required approval.
- Keep migration stages small; stop whenever the current stage is red.
- Distinguish core migration completion from production readiness and deployment authorization.

## Working Agreement

- Develop changes on focused branches and merge only verified commits into `main`.
- Keep `SKILL.md` concise and route conditional detail to focused references.
- Add files only when they provide concrete v0.1 value.
- Use public or synthetic examples only.
- Prefer authoritative public documentation when recording volatile tool capabilities.

## Verification

Before merging documentation or skill changes:

```bash
ruby scripts/validate_repository.rb
git diff --check
git status --short
```

When the skill exists, also run its bundled validation command documented in the contributor guide.
