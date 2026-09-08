---
id: REQ-0XX
title:
requester:
requester_unit:
cc:
received: YYYY-MM-DD
source: [mail:/// URI or message reference]
status: RECEIVED   # RECEIVED | SPECIFIED | SEARCHING | DELIVERED | CLOSED | DROPPED
mission: B         # A = tech-in (we push), B = market-in (they pull)
vertical:          # one of the five in config.md, or "provisional, pending spec"
gate_a2_check:     # pass | fail | pending. headquarters's out-of-scope list
---

# REQ-0XX · [Title]

## 1. WHAT WAS ACTUALLY ASKED

[Verbatim or close paraphrase of the request, in the requester's own terms. Quote the original.
No interpretation in this block.]

## 2. FACTS ON THE RECORD

[One bullet per fact stated by the requester. Nothing inferred. Each with its source.]

## 3. THE SPEC

Every row is either a stated number or an explicit hole. A hole is `NOT SPECIFIED`, never a plausible value.

| # | Parameter | Value | Status |
|---|---|---|---|
| S1 | | | stated / NOT SPECIFIED |

## 4. MARKED ASSUMPTIONS

Questions that died against a resolver. They travel as assumptions, and the requester can correct them.

| Assumption | Killed by | Evidence |
|---|---|---|

## 5. OPEN QUESTIONS

Only what survives all three resolvers: it depends on the requester's judgment, their money, or information
only they hold. Numbered, so the answer can come back as a list.

| Q | Question | Why it survives |
|---|---|---|

## 6. SEARCH SCOPE (draft, activates at SPECIFIED)

- Geography:
- Maturity band (TRL / commercial):
- Entity types in scope:
- Layers to sweep:
- Chinese search formulations (at least two distinct per concept):
- Patent search: yes / no, and register
- Explicit exclusions:

## 7. ROUTING

- Miaopu vertical:
- Deliverable to the requester: [format and date]
- Internal path: [the relay first, per config.md]
- External partners considered and why: [the paid-intelligence provider is paid and standing; any new partner must beat it]

## 8. LOG

| Date | Event |
|---|---|
