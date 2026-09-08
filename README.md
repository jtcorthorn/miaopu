# Miaopu 苗圃

**The nursery.** A scouting system for Chinese technology and startups, run by one analyst on behalf of a
corporate venture arm. It finds candidates, and it finds the gaps where a candidate should exist and does not.

This repository is the **method**, not anyone's data. You clone it, run `INSTALL.md`, and you have your own
instance: your verticals, your thresholds, your internal client, your pipeline, your credits.

## What it actually does

Two missions.

**Tech-in.** A recurring run that sweeps Chinese-language primary sources, normalizes what it finds into a
scored pipeline, and produces a digest for the person inside your company who has to decide something.

**Market-in.** A business unit asks a scoped question with a numeric specification. The system converts it
into a tasking, runs it, and answers with candidates measured against the spec, including the ones that fail.

Around both sits the part most scouting misses: **whitespace**. Scouting centred on candidates produces mostly
negatives, and negatives are cheap to produce and hard to get paid for. The advantage of an industrial venture
arm is not finding the startup a financial fund also finds. It is identifying the gap only your company can
fill, because it holds the raw material and can run the experiment. A well-argued negative is a deliverable
here, not a failed week.

## What it refuses to do

- Invent a number. Every field carries an evidence label or the literal words `not obtained`.
- Treat 注册资本 (registered capital) as raised capital, or announced capacity as operating capacity. Separate
  fields, never collapsed. The typical announced-to-operating gap in Chinese materials is 3 to 1.
- Count model agreement as corroboration. Independence is counted in **distinct source domains**. Three models
  quoting one press release is one source, and the reconciler labels it so.
- Write anything to your system of record without your explicit approval.
- Verify its own output. Nothing in this system self-verifies, anywhere.

## Shape

| | |
|---|---|
| `MAPA.md` | entry file. Read it first, every session |
| `config.md` | your instance. Generated at install, never committed |
| `modes/` | the method: intake, scan, assess, whitespace, digest, report, request, calibrate |
| `01_Database/` | the live workbook, and the source of truth. Rubric weights sit in editable cells |
| `arm/` | the deep-search arm. **Model-agnostic**: see below |
| `templates/` | render chrome for the deliverables |

## Model-agnostic by design

The deep arm's interface is a **file contract, not an API**. Any backend that writes a compliant
`FINDINGS_*.md` to the right path is valid, and `arm/reconcile.py` contains no provider name, no API call and
no model list. Three backends ship:

- **`claude-subagents`** (default) needs no extra account and no key. Start here.
- **`openrouter-panel`** runs Chinese-hosted models for the best reach into Chinese primary sources. Your key,
  your bill.
- **`single-model`** is the cheapest, and the README says exactly what it costs you in blind spots.

Writing a fourth for GPT, Gemini or a local model means writing a README. See `arm/backends/README.md`.

## Requirements

An AI assistant that can read a folder, run bash and launch subagents (Claude Cowork, Claude Code or
equivalent). Python 3.9+. That is all the default path needs.

## Install

`INSTALL.md`. Budget 30 minutes, most of it deciding your verticals and thresholds rather than typing.

## Licence

See `LICENSE`.
