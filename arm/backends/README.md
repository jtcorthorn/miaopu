# Backends · the model-agnostic layer

Miaopu's deep-search arm is defined by a **file contract, not an API**. A backend is anything that writes
contract-compliant findings to the right path. Nothing downstream knows or cares which model produced them.

## The whole interface

```
arm/inbox/panel/<RUN_ID>/<slug>/FINDINGS_YYYY-MM-DD.md
arm/inbox/panel/<RUN_ID>/<slug>/INTAKE_DRAFT_YYYY-MM-DD.md   (optional, non-binding)
```

`<RUN_ID>` is `YYYY-MM-DD_HHMM` or `weekly_YYYY-MM-DD`. `<slug>` is a filesystem-safe name for the model or
agent that produced the file. The format of the file itself is `arm/OUTPUT_CONTRACT.md`, which is the real
specification and is not optional.

Then, from the repo root:

```bash
python3 arm/reconcile.py arm/inbox/panel/<RUN_ID>
```

`reconcile.py` walks whatever subdirectories it finds, merges aliases, counts **distinct source domains**
rather than models that agreed, cross-matches the pipeline, and writes `RECONCILED.md` and `COMPARISON.md`.
It contains no provider name, no API call and no model list. That is why swapping backends costs nothing.

## Choosing one

| Backend | Extra credentials | Cost | Chinese-internet recall |
|---|---|---|---|
| `claude-subagents` **(default)** | none | your existing assistant quota | good, weaker on `.cn` sources behind Chinese-only search |
| `openrouter-panel` | your own `OPENROUTER_API_KEY` | pay per run, yours | best. Chinese models reach Chinese sources Western models do not surface |
| `single-model` | one key of your choice | lowest | varies |

**Start on `claude-subagents`.** It needs nothing you do not already have and it exercises the whole pipeline.
Move to `openrouter-panel` when you have decided the system is worth a metered budget, and note that the value
of a panel is source independence, not model count: three models quoting one press release is one source, and
`reconcile.py` will label it single-source no matter how many agreed.

## Why more than one model at all

A panel exists to make **omission** visible. One model that never searched a rubric field and one model that
searched and found nothing produce the same blank cell, and they are not the same fact. Running the identical
tasking in isolation and diffing the coverage tables is what separates them. With a single backend you keep
the contract and lose that check, which is a real loss and an acceptable one while you are starting.

## Writing your own

Any tool that can read `arm/AGENTS.md`, `arm/OUTPUT_CONTRACT.md` and a tasking, then write a markdown file to
a given path, qualifies. GPT, Gemini, a local model, a scripted pipeline or a human analyst are all valid
backends. The system has no opinion. Add a folder here with a README saying how to launch it.

## The rule every backend obeys

The arm **proposes**. It never scores, never gates, never writes to the workbook, never asks the operator
whether to proceed, and never reports verification of its own output. The system of record recalculates and
decides. A backend that violates this is not configured differently, it is broken.
