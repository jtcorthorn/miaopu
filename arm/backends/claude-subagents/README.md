# Backend · claude-subagents (default)

Runs the panel as parallel subagents inside the assistant you already use. No extra account, no API key, no
per-run bill beyond your existing quota. This is the backend `INSTALL.md` sets up, and the one to use for
your first runs.

## Launch

From a session with this repo mounted, say:

> Run the Miaopu deep sweep from tasking `arm/taskings/TASKING_weekly_<date>.md`, three panelists in parallel.

The assistant should:

1. Read `arm/AGENTS.md`, `arm/OUTPUT_CONTRACT.md`, the tasking, and `arm/exports/PIPELINE.md`.
2. Pick `RUN_ID` = `weekly_YYYY-MM-DD` (or `YYYY-MM-DD_HHMM` for an ad hoc run).
3. Launch **three** general-purpose subagents in a single message so they run concurrently, each with the
   panelist prompt below and its own `<slug>`: `panelist-a`, `panelist-b`, `panelist-c`.
4. Launch a **fourth** subagent as verifier only after the three have returned, with the verifier prompt.
5. Run `python3 arm/reconcile.py arm/inbox/panel/<RUN_ID>`.
6. Hand the operator `COMPARISON.md` and stop. Intake is a separate, operator-approved step.

## Panelist prompt

> You are a PANELIST sweeper for Miaopu. Read and follow `arm/AGENTS.md` and `arm/OUTPUT_CONTRACT.md` in this
> repository before doing anything. Your tasking is `<tasking path>`.
>
> Optimize for recall over precision. Search in Chinese first, at least two distinct formulations per concept,
> and treat the six client-rubric fields as fields to be searched rather than awaited: a blank because nobody
> looked and a blank after two primary searches are different objects, and only the second is a finding.
> Every claim carries its source URL and date and an evidence label.
>
> You are one of several agents running the identical tasking in isolation. Do not speculate about what other
> runs found, do not delegate the sweep to further subagents, and save partial work to your output file as you
> go. Write your output ONLY to `arm/inbox/panel/<RUN_ID>/<slug>/FINDINGS_<date>.md`. Never ask whether to
> proceed. Never report verification of your own writes.

## Verifier prompt

> You are the VERIFIER for Miaopu run `<RUN_ID>`. Read `arm/AGENTS.md` and `arm/OUTPUT_CONTRACT.md`. Consume
> every `FINDINGS_*.md` under `arm/inbox/panel/<RUN_ID>/`. Separate registered capital from raised capital,
> announced capacity from operating capacity, and check what any cited standard actually says. Assign an
> evidence label to every factual field you confirm or dispute. Write to
> `arm/inbox/panel/<RUN_ID>/VERIFIED_<date>.md`. You did not produce the findings, so you may verify them;
> never verify your own output.

## Known limitation, stated plainly

A Western-hosted model reaches Chinese primary sources less reliably than a Chinese-hosted one: some `.cn`
domains, WeChat article bodies and 互动易 term search may return nothing where a Chinese model returns a
result. That gap shows up honestly in the `COVERAGE` section as unreachable sources, which is the correct
behaviour. If the coverage tables keep coming back thin on Chinese primaries, that is the signal to move to
`openrouter-panel`, not a reason to accept a thinner sweep quietly.
