# Output contract · Miaopu deep-search runs

A run produces one or two files, and nothing anywhere else.

**Where they go.** A single-model run writes to `inbox/`. A panel run writes to
`inbox/panel/<RUN_ID>/<MODEL_SLUG>/`, the exact path handed to you in the run prompt. Never both, never the
other one, never a path you chose yourself. The per-model directory is what allows model performance to be
compared instead of silently merged.

1. `FINDINGS_YYYY-MM-DD.md`, MANDATORY. Facts with sources. Format below; it is what the main system's intake mode parses. Deviating from it means the run gets re-processed by hand, which defeats the purpose.
2. `INTAKE_DRAFT_YYYY-MM-DD.md`, OPTIONAL and NON-BINDING. If the run has enough material, you may draft the full intake: proposed Gate A/B results, proposed axis scores with breakdown, proposed routing, proposed pipeline updates and tracker rows. Useful as acceleration; never authoritative.

Add `_v2` if same-day rerun. **The run ends when these files are saved.** No approval questions, no writes to the system of record, no follow-up actions. The main system re-verifies and integrates.

## INTAKE_DRAFT header (mandatory if the file exists)

The draft must open with this block, verbatim:

```markdown
> NON-BINDING DRAFT produced by the deep-search arm. All gates, scores and
> routings in this file are PROPOSALS. The system of record recalculates and
> decides; nothing in this file authorizes a write. Entities failing a Gate A
> criterion carry no score, only the proposed archive reason.
```

## File structure

```markdown
# MIAOPU DEEP-SEARCH FINDINGS · YYYY-MM-DD

## RUN HEADER
- Tasking: [pasted tasking | standard weekly sweep]
- Layers swept: [fast | fast+medium | fast+medium+slow]
- Models: sweeper=[model], verifier=[model]

## ALERTS
[Only if any. One paragraph each, with the trigger named.]

## FINDINGS

### F-01 · [Entity English name] [中文名]
- entity_type: startup | subsidiary | listed company | institute | supplier | technology without vehicle | theme signal
- pipeline_match: NEW | UPDATE of MP-0XX | reference only
- city_province:
- vertical: [one of the five, or out-of-profile reference]
- technology_precursor: [what it does, feedstock and precursor, no adjectives]
- feedstock_detail: [species accepted, share of recipe, accepts residues? · label]
- forestry_track_record: [NAMED forestry or pulp and paper counterparties and what was run with each · label. "works with the sector" is not a track record; if none is found, "not obtained"]
- scale_operating: [value · label]        # NEVER merged with announced
- scale_announced: [value · label]
- traction: [paying customers, signed contracts, order book, lines or plants sold · label. Expect "not obtained" often; never estimate]
- capital_registered: [注册资本 · label]   # NEVER merged with raised
- financing_verified: [rounds with investor names · label]
- trl_declared: [value · label]
- business_model: [licence, JV, equipment sale, tolling, product sale, or the actual mix · label]
- differentiators: [what they do that the incumbent and the direct comparable cannot, stated as a capability and not as a claim · label]
- ip: [patent family, holder as currently registered · label]
- comparable_direct: [same technology, same market. Stage, funding, who wins and why. Otherwise "not searched"]
- comparable_indirect: [different route to the same problem, including the incumbent. Otherwise "not searched"]
- verification_status: [what was verified, what remains open]
- open_questions: [phrased as answerable questions]
- sources: [one per line: label · URL · date · one-line content note]

## THEME TRACKER ENTRIES
[One per price/cost/tender data point:]
- theme / metric / date of data / value / unit / source / label / note

## WHITESPACE OBSERVATIONS
[Expected-but-absent findings. For each: what was expected, where you searched,
the exact formulations used (including Chinese), and whether the source was
primary. Do not hypothesize why it is empty; that analysis happens downstream.]

## OUT_OF_SCOPE_NOTES
[One line each, only if genuinely notable.]

## COVERAGE
- Sources swept: [IDs from SOURCES.md]
- Sources unreachable: [IDs + what failed]
- Layers not touched and why
- rubric_coverage: [one row per rubric field: sourced / not obtained, out of the entities reported, plus the
  formulations actually run. Format below]

| Rubric field | Sourced | Not obtained | Formulations run |
|---|---|---|---|
| forestry_track_record | | | |
| traction | | | |
| business_model | | | |
| differentiators | | | |
| comparable_direct | | | |
| comparable_indirect | | | |
```

## Spec compliance (mission B runs only)

When the tasking carries a numeric specification, every finding adds:

```markdown
- spec_compliance: [per spec line: S1 met / not met / not obtained, with the measured value and its label]
```

A candidate that fails the spec is still reported, marked failing, with the number. Silence is not a filter.

## Non-negotiables

0. **The rubric fields are searched, not awaited.** `forestry_track_record`, `traction`, `business_model`,
   `differentiators`, `comparable_direct` and `comparable_indirect` get at least two Chinese formulations each,
   per entity, before any of them is written as `not obtained` (formulations in the tasking template). A blank
   because nobody looked and a blank after two primary searches are different objects, and only the second one
   is a finding. The `rubric_coverage` table in COVERAGE is where that distinction becomes auditable.
1. Every field either has a sourced value or says `not obtained`. No plausible filler. This applies with particular force to the six fields added on 2026-09-03 from the client rubric (`forestry_track_record`, `traction`, `business_model`, `differentiators`, `comparable_direct`, `comparable_indirect`), because they are the fields a language model can produce fluently from nothing. A confident sentence with no URL behind it is the failure mode this contract exists to prevent.
2. Evidence labels (`registry`, `patent`, `paper`, `filing`, `company`, `press`) on every factual field.
3. `pipeline_match` checked against `exports/PIPELINE.md` including archived rows and aliases.
4. English throughout, 中文名 attached to every entity name, original Chinese quoted for load-bearing phrases.
5. A finding with zero verifiable sources does not go in FINDINGS; it goes in COVERAGE as a lead that failed verification.
6. The arm never reports verification of its own outputs ("I verified my formulas/backup/writes"). Self-verification does not count as verification anywhere in this system.
7. The arm never asks the operator whether to proceed with integration. An operator "proceed" in the arm's chat approves proposal content only; the write is executed and verified by the main system.
