# Contributing

Contributions should improve the safety, clarity, portability, or evidence base of the modernization workflow.

## Development Workflow

1. Create a focused branch from `main`.
2. Keep the change limited to one coherent concern.
3. Update relevant documentation with the implementation.
4. Run the documented verification checks.
5. Use a descriptive commit message.

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
skills-ref validate ./skills/agentic-java-modernization
git diff --check
```

`skills-ref` is the validator documented by the Agent Skills specification and must be installed separately. If it is unavailable, validation is not complete merely because the Markdown renders.

Also verify:

- every local link resolves relative to the file containing it;
- `SKILL.md` contains no unfinished scaffold markers;
- referenced files are loaded only for the phases that need them;
- templates contain no repository-specific or confidential content;
- volatile compatibility claims point to current authoritative sources;
- the working tree is clean before merging.
