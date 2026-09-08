# 苗圃 / Miaopu

The nursery: scouting of Chinese technology and startups for a corporate venture arm. Two missions:
**A, tech-in**, the recurring run that filters what China pushes; **B, market-in**, a scoped request from a
business unit (`04_Requests/`). Not yet installed? Read `INSTALL.md` first, then come back here.

This file routes and holds no content. It is the first thing to read in any session. Ceiling of 61 lines.

## Live artifact

| Artifact | Live file | State |
|---|---|---|
| Living base | `01_Database/Miaopu_Living_Database_v1.0.xlsx` | the five axis weights live in sheet `02_Scoring`, in editable cells. Do not duplicate them in any other file |
| Identity and IDs | `config.md` | the instance layer, generated from `config.template.md`. Never committed |
| Method | `modes/`, eight modes: intake, scan, assess, digest, whitespace, calibrate, report, request | read by the `miaopu` skill in `.claude/skills/` |
| Digests and briefs | `02_Digests/`, `03_Memos/` | chrome lives in `templates/`, which is the single source for it |
| Requests | `04_Requests/` | REQ series. One request per file, state in its frontmatter |
| Deep-search arm | `arm/` | model-agnostic by contract. Backends in `arm/backends/`, default `claude-subagents` |

## Where each thing lives

| Folder | What it holds |
|---|---|
| `_meta/` | `BITACORA.md`, appendable history |
| `01_Database/` | the live workbook. Do not hand-edit what the engine calculates |
| `02_Digests/` | dated digests (PDF; HTML in `_source/`) |
| `03_Memos/` | deep-dive memos and quarterlies |
| `04_Requests/` | request briefs, with their template |
| `modes/` | the method, one file per mode |
| `templates/` | render chrome. Copied into a deliverable, never edited in place |
| `arm/` | `exports/` regenerates from the workbook, `taskings/` goes in, `inbox/panel/` comes out |

## Routing by what just happened

| If | Go to | Stop at |
|---|---|---|
| I open a session here | this file, then `config.md` | |
| a Chinese technology or company signal arrives | `modes/intake.md` | **not** if `config.md` routes that domain to a sibling system |
| a business unit asks for something specific | `modes/request.md` | **no searching from `RECEIVED`.** Numeric spec first, run second |
| a bare trigger arrives ("run the scan", "build the digest", "intake", "miss check" with no domain) | **ask which system before acting** | the same phrases fire in sibling systems |
| I am about to score something | `modes/scan.md` and sheet `02_Scoring` | thresholds live in `config.md`, never in memory |
| I am about to build the digest | `modes/digest.md`, render with `modes/report.md` | verify by edge-sampling pixels, not by eye |
| a panel lands in `arm/inbox/panel/<RUN_ID>/` | run `arm/reconcile.py`, then `modes/intake.md` | the arm does not score. `RUNNING` or `MISSING` in COMPARISON.md is a failed run, not an empty week |
| the digest did not touch a layer | declare it explicitly | an honest digest saying nothing moved beats one that fabricates findings |
| I close a deliverable | append at the top of `_meta/BITACORA.md`, version with the date | move the previous one before writing the new one |

## The rules

Nothing is overwritten: `Name_YYYY-MM-DD.ext`, `_v2` if it is the second of the day; the previous one moves to `_archive/` first.
Every datum carries an evidence label, or the literal words `not obtained`. No label, no entry to the score.
注册资本 is registered capital, not raised. Announced capacity is not operating capacity. Never collapse either pair.
Model agreement is not corroboration. Independence is counted in distinct source domains.
Nothing self-verifies, anywhere, ever. The arm proposes; the system of record decides.
A well-argued negative is a deliverable. It feeds calibration and it is the raw material of whitespace.
No entity leaves without its global comparable.
Deliverables carry the operator's voice. The system supplies structure and evidence, never a stance the operator did not state.
Language: **this entire workspace is written in English.** Conversation with the operator can be any language; trigger phrases stay quoted as utterances.
The arm mounts only in `arm/`, never at the root. The boundary is access, not instruction.
Zero em dashes in any output.
