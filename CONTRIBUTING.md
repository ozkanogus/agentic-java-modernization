# Contributing

Contributions should improve the safety, clarity, portability, or evidence base of the modernization workflow.

## Development Workflow

1. Create a focused branch from `main`.
2. Keep the change limited to one coherent concern.
3. Update relevant documentation with the implementation.
4. Run the documented verification checks.
5. Use a descriptive commit message.

Pull requests are preferred for normal changes where practical. The repository
currently has one maintainer, so v1 does not require an approval from a second
person. Required CI must pass before merge; never bypass or weaken checks merely
to merge a change.

Suggested commit prefixes include `docs:`, `feat:`, `fix:`, `test:`, and `chore:`.

## Content Requirements

- Use vendor-neutral language in the core methodology.
- Cite authoritative public sources for time-sensitive compatibility claims.
- Do not copy third-party instructions or recipes without checking their license.
- Do not include confidential, proprietary, customer, employer, or credential material.
- Use only public or synthetic repositories in examples and case studies.

## Skill Validation

From the repository root, run:

```bash
ruby scripts/validate_repository.rb
git diff --check
```

The repository validator parses YAML, checks required skill/package structure,
verifies local Markdown links, and enforces the required sections in the shipped
templates. Also run a current validator supplied by your skill-aware product or
the Agent Skills project when available.

Also verify:

- every local link resolves relative to the file containing it;
- `SKILL.md` contains no unfinished scaffold markers;
- referenced files are loaded only for the phases that need them;
- templates contain no repository-specific or confidential content;
- volatile compatibility claims point to current authoritative sources;
- the working tree is clean before merging.

## Branch and Release Governance

- Do not force-push or delete the default branch.
- Keep branch rules practical for the current single maintainer: meaningful CI,
  PRs where practical, and no impossible second-person approval requirement.
- Tags, releases, publishing, deployment, and repository-setting changes require
  explicit maintainer authorization.
- If the project gains multiple maintainers, consider required approval, stale
  approval dismissal, CODEOWNERS review for the skill and validation workflow,
  and stronger default-branch protection.

CODEOWNERS is intentionally deferred while there is one maintainer because it
would identify the same person without adding independent review. Re-evaluate it
when ownership is shared.
