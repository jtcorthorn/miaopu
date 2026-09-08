# Backend · single-model

One model, one seat, one findings file. The cheapest way to run the arm, and a legitimate configuration.

## Launch

Give any capable assistant or CLI agent the repo, and this instruction:

> Read `arm/AGENTS.md` and `arm/OUTPUT_CONTRACT.md` in this repository, then execute the tasking at
> `<tasking path>`. Write your output to exactly `arm/inbox/panel/<RUN_ID>/<slug>/FINDINGS_<date>.md` and
> nowhere else. Search in Chinese first, at least two formulations per concept. Every claim carries its source
> URL, date and evidence label. Never ask whether to proceed. The run ends when the file is saved.

Then reconcile as usual. `reconcile.py` handles a one-seat run without special casing:

```bash
python3 arm/reconcile.py arm/inbox/panel/<RUN_ID>
```

## What you give up, said plainly

Everything `reconcile.py` reports about **omission** goes quiet. With one seat there is no second coverage
table to diff, so a rubric field the model never searched and a field it searched fruitlessly both arrive as
one blank cell, and nothing in the run can tell them apart. The `rubric_coverage` table still records what
that model claims it ran, which is the model's own account of itself and therefore the weakest evidence in
the system.

Source-independence counting still works, because it was never about models: it counts distinct domains.
