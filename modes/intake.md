# miaopu-intake

The entry gate. The operator brings a raw signal and out comes a normalized, verified, scored row, ready for decision.

What makes this gate valuable is not scoring. It is **verifying before scoring**. On the first run, a single
fiche already circulating in headquarters carried three material errors: one company counted as two, a technology
maturity standard presented as a product specification, and capacity figures that exist in no public source.
If verification comes after the score, the system gives decimal precision to false data.

## Flow

### 1. Normalize the input

Accepts any format: a link, a fiche from the paid-intelligence provider, a paper, WeChat article, photo of a product, a bare name. Extract and make
explicit what is being evaluated: a company, a technology with no vehicle, an institute, or a theme.

If it comes in Chinese, translate. **A Chinese-language document is never sent to headquarters.** That is a standing instruction from the internal
client, and it does not have exceptions.

### 2. Deduplicate

Read `01_Pipeline` and `05_Event_Log` in the workbook. If the entity already exists, this is an update, not a new
row. Watch the aliases: in China the same company shows up as Chinese name, official English name, subsidiary
name and press transliteration. The first run had a case where a company and its subsidiary were being treated
as two.

### 2b. If the input is a panel, reconcile before anything else

Run `arm/reconcile.py` over the run directory. It alias-merges the entities, cross-matches them against
`exports/PIPELINE.md`, emits the 互动易 verification queue, and, most importantly, counts **distinct source
domains** per entity.

**Model agreement is not corroboration.** Three models asserting the same fact is frequently one press article
read three times. Source independence is the only thing that counts, so the reconciler reports both numbers and
they move independently: on the seeding run one entity carried three models and one
distinct source domain, while another carried one model and three distinct domains. The second is better evidence
than the first.

Every pipeline row born from a panel carries its corroboration in `Reason / note`: how many models, how many
distinct source domains, and the label. A row that says `SINGLE-SOURCE` is verified before it leaves the system.

This step exists because the rule was written and then broken the same day by the system that wrote it, for the
ordinary reason: nothing mechanical checked it. A rule with no check attached is taste.

### 3. Verify before scoring

Four checks, in this order:

**Identity.** Does the entity exist? What is its registered name? Are the subsidiary and the parent the same
thing? Check against the corporate registry (企查查, 天眼查, 爱企查). If the registry is unreachable, **say so**
and mark the row as not verified against the registry. It is not skipped in silence.

**Capital.** 注册资本 is registered capital, not raised capital. They go in different fields. A round announced in
the press without confirmation from the company or the investor is `press`, not `verified financing`.

**Capacity.** Announced and operating are different fields and are never collapsed. In the Chinese materials
sector the typical gap is 3 to 1, and a general manager from that sector put it in writing: many companies
declare ten-thousand-tonne lines whose real capacity is two to three thousand, with utilization below 30%.

**Cited standards and certifications.** Verify what the standard actually says before accepting it as technical
evidence. Precedent: GB/T 37264-2018 was presented as a product specification and is in fact the Chinese
technology maturity scale.

Every data point carries an origin label: `registry`, `patent`, `paper`, `filing`, `company`, `press`.
**No label, no entry into the score.**

### 4. Gate A: knockouts

Five binaries. A no on any of them and the row goes to `01_Pipeline` with state `archived` and a written reason.
It is not scored, it does not reach the digest as a candidate, but it **can** feed whitespace.

| # | Criterion |
|---|---|
| A1 | **Feedstock fit.** Does it consume the company's raw material or one of its process by-products? The list is in `config.md`. At what percentage of the recipe? No number, no pass |
| A2 | **Not covered internally and not out of scope.** See the list in `config.md` |
| A3 | **Does not compete against a cheap commodity with no differential.** Find the market price of the substituted product and its trend before answering |
| A4 | **Accessibility and exposure.** Military or defence line, export control lists, or impossibility of obtaining information as a foreigner |
| A5 | **Documentation obtainable in Spanish or English** |

Operating note on A4: until there is a resolved source for control lists, a "no findings" is an **unverified
negative**, not a pass. It is recorded as a flag, not a green check, and is formally closed before any agreement.

### 5. Gate B: traffic lights that route

TRL (green 6 to 8, amber 5, red ≤4), corporate vehicle (startup, spin-off in formation, or institution with no
cap table), stage plus ticket against the thresholds in `config.md`, and forestry track record.

**Forestry track record** (from the client rubric in `config.md`). Green if a forestry or pulp
and paper counterparty is named and verified, amber if the counterparty is named by the company but not
corroborated, red if there is none. This is the cheapest de-risking evidence in the whole gate: a technology that
already ran with a large pulp or paper producer has been through an industrial feedstock it did not choose,
which is exactly the question the company would otherwise pay to answer. Name the counterparty and what was done. "Works
with the forestry sector" is not a track record.

It is a traffic light and not a scoring axis on purpose. It routes and it is reported; it does not silently move
a weight the calibration loop set with evidence.

Red does not kill: it routes. See step 7.

### 6. Score

Five axes against sheet `02_Scoring`. **Read the weights from the sheet, never from memory**, because the
calibration loop changes them.

Feedstock fit, impact on the company's core, industrial maturity and cost parity, exportability outside China, and why
us. The detail of how each axis is scored lives in the sheet.

Two rules when scoring:

- **The cost parity axis is evaluated against the market price and its derivative, not just its level.** A product
  at parity today in a market falling 20% a year is not at parity. Look at `07_Theme_Tracker`.
- **The exportability axis is scored even when it is uncomfortable.** Scoring low for geopolitical exposure is
  correct. How that is communicated to headquarters is a separate decision, not a reason not to measure it.

### 7. Route

| Profile | Vehicle | Interlocutor |
|---|---|---|
| Startup, score at or above the deep-dive threshold in `config.md`, raising | VC Investment | Committee via the internal client |
| Good technology with no corporate vehicle | R&D Agreement or feedstock trial | The corporate R&D team. Better if the centre is already on their visit agenda |
| Forestry or silviculture, any TRL | R&D Forests | The forestry R&D lead named in `config.md` |
| Mature, could simply be bought | Co-Financed Technology Adoption or supply contract | Business unit |
| Solves a concrete operational pain | Venture Client pilot | Innovation |
| TRL 2 to 4 with potential | Public funds | R&D |
| None of the above | Archive with a reason | `01_Pipeline`, state archived |

### 8. Write

Propose the row to the operator. **Nothing enters the pipeline without their approval.** An approval given in a satellite chat
(the arm or another arm) approves the content, not the write: the write is executed only by this system. Once
approved, write it into `01_Pipeline` and log the event in `05_Event_Log`.

**Single-writer checklist, mechanical and mandatory before closing any write to the workbook.** It is born from a
single run in which all five of these failed at once:

1. SCORE formulas with relative references to THEIR row, not copied literally from another.
2. Column mapping against the sheet's real header, field by field. A one-column shift passes silently and
   poisons the entire record.
3. The system's State vocabulary: `watchlist`, `archived`, `not verified`, `out of range`. Routing goes in
   Routing, not in State.
4. ID ranges: active rows in the running series, archived rows and references in the separate reference series. The two series are defined in `config.md`. Never reuse an ID.
5. Failed Gate A means archive with a reason and **no score**.

**The writer's self-verification does not count as verification.** If an external arm wrote (it should not), the
whole thing is audited here before a single cell is accepted. Verify by re-reading from the written file, not
from memory.

If the intake produced a hole (something that should exist and does not, a patent claim with no worked example,
an absence of literature), offer to run `whitespace.md` over it.

## Output

One-page fiche, fixed format:

```
CANDIDATE      Latin name + 中文名 + site + city and province
MISSION        A (tech-in) or B (market-in)
VERTICAL       One of the verticals listed in `config.md`
WHAT IT DOES   Three lines, no adjectives
SCORE          XX/100 · breakdown across the five axes
GATE A         The five checks with evidence, and unverified flags stated as such
FEEDSTOCK      Species accepted, % of recipe, yield, whether it accepts residues
FORESTRY       Named forestry or P&P counterparties, what was run with each, source
TRL            Declared and verified, with a source for each
SCALE          Operating vs announced, in separate fields
TRACTION       Paying customers, contracts, order book, lines sold. `not obtained` when it is
COST           Against the incumbent and against the price trend
BUSINESS MODEL How they make money: licence, JV, equipment sale, tolling, product sale
DIFFERENTIATOR What they do that the incumbent and the direct comparable cannot
IP             Patent family, jurisdictions, current holder
CORPORATE      Registered entity, registered vs raised capital, verified rounds
EXPORTABILITY  The six sub-axes with traffic lights
COMPARABLE D   Direct analogue: same technology, same market. Stage, funding, who wins and why
COMPARABLE I   Indirect analogue: different route to the same problem, including the incumbent
ROUTING        Proposed vehicle and internal interlocutor
QUESTIONS      What is missing, written the way the internal client writes them
SOURCES        With a type label for every data point
PRODUCED BY    Models that ran the sweep and their role, corroboration as two
               separate numbers (models / distinct source domains), and how many
               claims the verifier killed for having no source
```

Both COMPARABLE blocks are mandatory. A fiche without them is incomplete and is not sent. The split is the
internal client's: the direct comparable tells them whether the Chinese candidate wins its own race, the indirect
one tells them whether the race is worth entering. A fiche that only carries the direct comparable answers the smaller of the two questions.

FORESTRY, TRACTION, BUSINESS MODEL and DIFFERENTIATOR come from the same rubric. They are reported fields, not
scoring axes, and they follow the same rule as every other field here: sourced value with a label, or `not
obtained`. TRACTION is the one that will be empty most often, for the reason recorded in `config.md`. Empty and
labelled is the correct output. Estimated is not.

Those fields are also **searched and not awaited**: `scan.md` runs at least two Chinese
formulations per field before any of them is written as `not obtained`. When a fiche carries an empty rubric
field, say in one clause how many formulations were run against it. An empty field that was hunted is evidence
about Chinese disclosure; an empty field that was never hunted is a hole in the system, and the reader cannot
tell them apart unless the fiche says which one it is.

PRODUCED BY exists for the same reason in reverse. The client is being asked to act on findings from an engine
they cannot run, so the fiche carries the engine's own numbers rather than a claim of rigour. Take them from
`arm/inbox/panel/<RUN_ID>/COMPARISON.md` and from `reconcile.py`, never from memory, and keep models and
distinct source domains as two separate numbers: **model agreement is not corroboration** (see step 2b).

## The four standard questions

The internal client declared these reusable. They go in the QUESTIONS block of every mission A fiche:

1. Does any type of wood work for them, and which species is most efficient in terms of yield?
2. Can they use forest and industrial residues?
3. What scale are they at: TRL, commercial, industrial?
4. What is the corporate structure between the entities involved?

For lignin, two more: which main lignin type they use, and whether they have used kraft lignin.
