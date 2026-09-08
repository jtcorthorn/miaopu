# Backend · openrouter-panel (opt-in)

Runs the panel as several **Chinese-hosted models in isolation** through one OpenRouter account. This is the
highest-recall backend on Chinese primary sources and the only one that costs metered money. Use it once you
have decided the system earns a budget.

## What you need

- Your own OpenRouter account and `OPENROUTER_API_KEY` in `.env` at the repo root. **Your key, your bill.**
- A CLI agent runner that accepts `run --agent <name> --model <slug> --dir <path>`. The reference runtime is
  the OpenCode CLI; set `PANEL_CLI` if yours is named differently.
- A websearch tool enabled for the runner. On OpenCode that is `OPENCODE_ENABLE_EXA=1`, already exported by
  the script. **Without a websearch tool the models will confabulate instead of sweeping**, which is the
  single most expensive failure mode of this backend.

## Setup

1. Copy `opencode.json` to `arm/` and replace `{{PANEL_MODEL_1}}` and `{{VERIFIER_MODEL}}` with real slugs.
2. Set `PANEL_MODELS` in `.env` as a space-separated list.
3. Verify every slug against OpenRouter's live model list before the first run. Slugs are renamed and retired
   without notice, and a bad slug fails the run silently on that seat.

## Launch

```bash
MODELS="$PANEL_MODELS" arm/backends/openrouter-panel/run_panel.sh arm/taskings/TASKING_weekly_<date>.md
python3 arm/reconcile.py arm/inbox/panel/<RUN_ID>
```

`SERIAL=1` runs the seats one at a time. `TIMEOUT_MIN` defaults to 30.

## Composing the roster

- Three panelists is the tested size. Seats are **independent sweepers running the identical tasking**.
- The verifier **never sits as a panelist**. A model that judges its own sweep is judge and party, and the
  contract forbids self-verification anywhere in this system.
- More seats is not more corroboration. `reconcile.py` counts distinct source domains, so five models quoting
  one press release still scores as one source. Add a seat to widen search behaviour, not to raise confidence.

## Status

**Not walk-tested in this repository.** The launcher is carried over from a working runtime and adapted to
relative paths, but it cannot be exercised without a metered key, so it ships unverified on purpose rather
than with a green check it did not earn. Run it serially with one seat first and confirm a file lands before
running a full panel.
