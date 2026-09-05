# Modernization Branching and Production Synchronization

Use this model for modernization that spans multiple independently reviewed
stages. Adapt names and review mechanics to the repository's Git policy.

```text
main/master (current production truth)
    |                         \
normal product work       modernization/integration
                                  |
                         modernization/<stage>
                                  |
                         review + stage gates
                                  |
                         modernization/integration
                                  |
                   deployment/regression/UAT gates
                                  |
                  final production integration review
                                  |
                             main/master
```

- Keep long-running modernization off `main`/`master`.
- Use `modernization/integration` as the future production candidate when the
  effort needs an integration line; a short migration may use the repository's
  normal PR model instead.
- Derive short-lived stage branches from the approved migration graph; names such
  as `modernization/java-21` are examples, not a prescribed stage sequence.
- Keep the integration line buildable, testable, and deployable where practical.
- Do not prescribe merge or rebase globally. Preserve published history and
  follow repository policy.

## Production Drift

A candidate that passes against an old production snapshot is not current.
During a long migration, regularly bring the latest production truth into the
integration line through a controlled synchronization, resolve conflicts with
both product and migration context, then rerun all affected build, behavioral,
schema, and deployment checks. Record the synchronized revision and results.

Do not defer months of divergence until final integration. Conversely, do not
synchronize during an active red stage without first preserving its diagnostic
state and agreeing on scope.

## Final Integration Gate

Before proposing integration into production truth, confirm:

- all intended migration stages and integration-line CI are green;
- the production revision used for final synchronization is recorded;
- applicable production-readiness requirements are resolved or accepted;
- representative deployment, regression, and UAT evidence is recorded;
- rollback and database rollout responsibilities are explicit;
- the repository's normal human review and release authorization are satisfied.

No branching model grants permission to push, merge, deploy, or release.
