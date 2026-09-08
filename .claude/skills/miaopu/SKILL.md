---
name: miaopu
description: "Miaopu 苗圃 (the nursery): scouting system for Chinese technology and startups on behalf of a corporate venture arm. Use when the operator brings a Chinese technology or company signal (a link, a company profile, a paper, a WeChat article, a photo, a bare company name); asks for the run (\"run the scan\", \"weekly run\"); a deep dive (\"validate it\", \"build the memo\"); the digest for the internal client; whitespace hunting (\"where is the gap\"); a scoped business-unit request; or the learning loop (\"calibrate\", \"miss check\"). If the trigger is bare and could belong to a sibling system (\"run the scan\", \"build the digest\", \"intake\", \"miss check\" with no domain named): ASK which system before acting. Do NOT use for pulp or wood capacity, for Chinese policy and regulation, or for medical and longevity technology: those are separate systems where they exist."
---

# Miaopu 苗圃 · router

The nursery: where seedlings are raised before transplanting, and where it is decided which ones survive the change of climate. A scouting system for Chinese technology and startups, run by one analyst on behalf of a corporate venture arm.

## Hard start rule

**Before acting, read with the Read tool: `config.md` at the repo root, and the file for the relevant mode in `modes/`.** Never improvise the method from this page. The method lives in the mode files.

If `config.md` does not exist, the instance has not been installed. Stop and run `INSTALL.md`.

## Where the system lives

Every path in this system is **relative to the repository root**. The repo is the system; there is no path outside it.

```
<repo root>/
  MAPA.md              entry file. Read first when mounting the folder
  config.md            identity, interlocutors, thresholds, cadence. NOT in git
  config.template.md   the blank it is generated from
  INSTALL.md           setup, once per operator
  .claude/skills/miaopu/SKILL.md   this file
  modes/               intake · scan · assess · whitespace · digest · calibrate · report · request
  01_Database/         the live workbook
  02_Digests/          dated deliverables
  03_Memos/            deep-dive memos and quarterlies
  04_Requests/         scoped business-unit requests
  templates/           render chrome for the deliverables
  arm/                 the deep-search arm, model-agnostic
  _meta/BITACORA.md    appendable history
```

The operator, the internal client, the verticals, the thresholds and the out-of-scope list are **not in this file**. They live in `config.md`, and they are the only thing that differs between two instances of Miaopu.

## Scope

Technologies and companies **in China** that could consume the operator's fibre or strengthen its commercial position, plus **the gaps where they should exist and do not**.

Out of scope, with routing: signals about pulp or wood capacity, about Chinese policy and macro, about startups outside China, or about medical technology belong to other systems. `config.md` names which of those exist in this instance. Where a sibling system does not exist, say so rather than absorbing the signal.

That boundary is not cosmetic. Without it the same signal ends up recorded in two bases and the system loses its only advantage, which is one truth per subject.

## Mode router

| Mode | File | When |
|---|---|---|
| Intake | `modes/intake.md` | Raw signal: link, company profile, paper, article, photo, company name. Normalize, verify, score |
| Scan | `modes/scan.md` | "Run the scan", "sweep the sources", or the scheduled run. Respects the per-layer cadence |
| Assess | `modes/assess.md` | Candidate over threshold, or deep validation. Memo with a mandatory global comparable |
| Whitespace | `modes/whitespace.md` | "Where is the gap", or on closing any scan |
| Digest | `modes/digest.md` | "Build the digest", or at the close of the run |
| Report | `modes/report.md` | The render layer. Called by digest and assess, never on its own |
| Request | `modes/request.md` | A business unit asks for something specific. Numeric spec first, run second |
| Calibrate | `modes/calibrate.md` | "Calibrate", "miss check". The learning loop |

Natural sequence: scan, intake of what survives, whitespace on closing, digest. Assess on demand. Calibrate monthly.

## Invariants

- **Never invent a number.** Every datum carries an origin label: registry, patent, paper, filing, company, press. No label, no entry to the score.
- **注册资本 is registered capital, not raised capital.** Separate fields. Confusing them is the most common error a foreign analyst makes.
- **Announced capacity and operating capacity are separate fields** and are never collapsed. Typical gap in the Chinese materials sector: 3 to 1.
- **Verify before scoring.** Entity identity, capital, capacity, and what any cited standard actually says.
- **Chinese sources first.** The global sweep exists to contrast, not to discover.
- **No entity leaves without its global comparable.** It is the condition for a Chinese finding to be credible at headquarters.
- **Nothing enters the pipeline without the operator's explicit approval.**
- **A well-argued negative is a deliverable**, not a failure. It is recorded with its reason, because it is the input to the calibration loop and the raw material of whitespace.
- **Model agreement is not corroboration.** Independence is counted in distinct source domains, never in models that agreed.
- **Deliverables carry the operator's voice.** The system supplies structure and evidence. It never writes a stance the operator did not state.
- **Zero em dashes** in any output.

## The workbook is the source of truth

`01_Database/` holds the live workbook. Sheets: `00_Read_Me`, `01_Pipeline`, `02_Scoring`, `03_Whitespace`, `04_Sources`, `05_Event_Log`, `06_Calibration`, `07_Theme_Tracker`, `08_Contacts`, `09_Dictionary`.

The rubric weights live in editable cells of `02_Scoring`, and the scores in `01_Pipeline` are formulas that reference them: changing a weight recalculates the whole history. Read the weights from the sheet, never from memory. That is the reason the base is a spreadsheet and not a database page.

Read it with `openpyxl` or `pandas` via bash. After writing with openpyxl, recalculate before reading values back.

## Why whitespace sits at the same level as the pipeline

Scouting centred on candidates produces mostly negatives, and negatives are the cheapest thing to produce and the hardest thing to get paid for. The advantage of an industrial CVC is not finding the startup a financial fund also finds: it is identifying the gap only this company can fill, because it holds the raw material and can run the experiment.

## The deep-search arm

`arm/` is where wide Chinese-language recall happens. It is **model-agnostic by contract**: any backend that writes contract-compliant `FINDINGS_*.md` into `arm/inbox/panel/<RUN_ID>/<slug>/` is a valid arm. See `arm/backends/README.md`. The arm never scores, never gates and never writes to the workbook. That is `modes/intake.md`.
