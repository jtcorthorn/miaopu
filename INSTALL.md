# Install Miaopu

One operator, one instance, one set of credits. Budget 30 minutes. Most of it is deciding what you are
scouting for, not typing.

## 0 · What you need first

- **An AI assistant that can mount a folder, run bash and launch subagents.** Claude Cowork, Claude Code or
  equivalent. This is the real requirement: Miaopu is a method the assistant executes, not a program that
  runs on its own. Without it the repo is a set of documents.
- **Python 3.9 or newer.**
- Nothing else on the default path. No API key, no second account.

## 1 · Clone and mount

```bash
git clone <repo url> miaopu
cd miaopu
pip install -r requirements.txt
playwright install chromium      # only if you will render PDF deliverables
```

Then **mount this folder in your assistant** as the working folder. The skill ships at
`.claude/skills/miaopu/SKILL.md` and is picked up from the repo, so there is nothing to install into your
profile and no absolute path to fix.

Verify: ask your assistant *"read MAPA.md and tell me which mode files exist"*. If it lists eight modes, the
mount is right.

## 2 · Create your instance

```bash
cp config.template.md config.md
cp .env.example .env             # only needed for metered backends; can stay empty
cp _meta/BITACORA.template.md _meta/BITACORA.md
cp arm/exports/PIPELINE.template.md arm/exports/PIPELINE.md
cp arm/exports/SOURCES.template.md arm/exports/SOURCES.md
```

`config.md` is gitignored on purpose. It is the **only** file that differs between two instances of Miaopu,
and everything in it is yours.

Fill it in. The sections that decide whether the system works:

| Section | What it decides | Getting it wrong costs you |
|---|---|---|
| **Internal client** | who receives findings and can act on them | a system that produces reports nobody asked for |
| **Active verticals** | what the sweep is looking for | scope creep, and a pipeline that means nothing |
| **Declared out of scope** | what your client has already said no to | burned runs on answered questions |
| **Thresholds** | deep dive, watchlist, archive | everything scores as interesting, which is the same as nothing scoring |
| **Interlocutors** | who unblocks what | findings that stall |

Write **Declared out of scope** even if it starts empty. It is the section that keeps an analyst from spending
a week on something the business already rejected, and it only grows by asking.

## 3 · Seed the workbook

```bash
cp 01_Database/Miaopu_Living_Database_TEMPLATE.xlsx \
   01_Database/Miaopu_Living_Database_v1.0.xlsx
```

Open it and do two things:

1. **Sheet `02_Scoring`: set your five axis weights.** They live in editable cells and the pipeline scores are
   formulas that reference them, so changing a weight recalculates your whole history. This is deliberate.
   Read weights from the sheet, never from memory.
2. **Sheet `04_Sources`: seed the sources your verticals need**, each with the retrieval route that actually
   works. Start with five you already read. The arm reports unreachable sources back and the registry grows.

The workbook is the source of truth. Not the digests, not the exports, not your notes.

## 4 · Pick a backend

Default is `claude-subagents`, which needs nothing further. Read `arm/backends/README.md` before choosing
anything else, and stay on the default until you have decided the system is worth a metered budget.

## 5 · First run

Ask your assistant, in your own words:

> Run the Miaopu weekly scan.

It should read `config.md` and `modes/scan.md` before doing anything. If it starts sweeping without reading
those, stop it: it is improvising the method, and the method is the product.

A first run typically ends with **zero candidates over threshold and two or three whitespace observations**.
That is a successful run, not an empty one. If your first run returns five exciting candidates, be suspicious
and check their evidence labels.

## 6 · Confirm the loop closes

```bash
python3 arm/reconcile.py arm/inbox/panel/<RUN_ID>
```

You should get `RECONCILED.md` and `COMPARISON.md`. Read `COMPARISON.md` first and look at the coverage
table, not the findings: **the fields nobody searched are the ones that will mislead you**, and a blank
because nobody looked reads identically to a blank after two primary searches in every workbook cell ever
made. Only the second one is a finding.

Then append what happened to `_meta/BITACORA.md`, and you are running.

## Troubleshooting

| Symptom | Cause |
|---|---|
| Assistant improvises instead of reading modes | `config.md` missing, or folder not mounted at the repo root |
| `reconcile.py` finds no findings | backend wrote to a path it chose itself. The contract path is not a suggestion |
| Everything scores 70+ | axis weights left at template defaults, or evidence labels not enforced |
| Every rubric field says `not obtained` | the backend has no websearch tool enabled |
| Digest renders with white margins | `@page{background}` missing. See `modes/report.md` |
