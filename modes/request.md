# miaopu-request

Mission B. A business unit, or Innovation at headquarters, asks for something concrete: "we need X, find it in China".
The weekly scan is the opposite, mission A: Chinese supply pushes and we filter. Here the request pulls.

The edge of this mode is not searching. It is **not searching yet**. A request almost always arrives with the
intention clear and the specification empty, and a run against an empty specification returns brochures, not
evidence. Worse: it burns the requester, who concludes that the China system does not work when what was missing
was their own number.

## Flow

### 1. Open the REQ

Copy `04_Requests/_templates/REQUEST_BRIEF_template.md` to `04_Requests/REQ-0XX_<slug>_YYYY-MM-DD.md`.
Running numbering, never reused. Initial state `RECEIVED`.

**Cite the primary source.** The mail, the message or the minutes, with its URI or reference. The brief describes
what the requester said, not what the system understood. Block 1 carries no interpretation.

### 2. Separate fact from hole

Block 2 is facts, one per bullet, each with its source. Block 3 is the spec table: every parameter has a declared
value or says `NOT SPECIFIED`. **Never a plausible value.** A request with more than half its rows empty does not
move to search, and that gets said in the chat with the operator before anywhere else.

### 3. Check Gate A2 before spending anything

The out-of-scope list declared by headquarters lives in `config.md`. A business-unit request buys no waiver: if
what is being asked falls there, say so immediately, not after the run. Watch for silent overlaps, because a
request rarely names the excluded thing. Worked example: a chemistry on the out-of-scope list turned out to be the
standard binder in the formulation the requester was asking about, so the request smuggled the exclusion in
without either side noticing.

### 4. Three-resolver test on every candidate question

Before sending the requester a single question, run it against three resolvers:

1. **The evidence.** Did they already say it in their message, or is it in the folder?
2. **The written project rules.** Does `config.md`, a mode, or an already-taken decision resolve it?
3. **The conventional default.** Is there a standard industry answer nobody would dispute?

Whatever dies against any of the three goes to block 4 as a **marked assumption**, correctable but not asked.
Only what depends on the requester's judgment, their money, or information only they hold reaches block 5. The
brief shows the verdict for each question in plain sight: that is what keeps the list short and what makes the
requester answer it.

A list of twelve questions is a transfer of work. Six well chosen ones get answered the same day.

### 5. Close the brief and move to SPECIFIED

When the answers come back: fill the spec table, fix block 6 (search scope, with at least two distinct Chinese
formulations per concept), and propose the move to `SPECIFIED` to the operator. **The operator approves the state change.** Only then
is a run spent.

### 6. Issue the tasking

Copy `arm/taskings/TASKING_template.md` to `arm/taskings/TASKING_REQ-0XX_YYYY-MM-DD.md`. The tasking is
the only thing the arm reads about the request: it is written self-contained, with the numeric spec inside. Run
the model panel per `arm/README.md`.

### 7. Integrate

Findings come back to `arm/inbox/panel/`. They are compared across models, consolidated, and entered through
`modes/intake.md` like any other signal: verification before score, Gate A, single-writer checklist. **A request
buys no gate waiver.** A supplier failing A1 is archived with a reason even if the requesting business unit wants
it.

### 8. Deliver and close

Delivery goes to the relay first, always, per `config.md`. Format: one fiche per supplier in English with 中文名,
plus the internal client's four standard questions and the request-specific ones. State moves to `DELIVERED`, and to `CLOSED`
when the requester confirms. A request that dies is marked `DROPPED` with a written reason, never left hanging.

## Hard rules

- The REQ and the tasking are in English. So is everything else in this workspace. The spoken conversation with the operator follows the conversation language set in `config.md`.
- State is derived from the REQ's frontmatter, not from accumulated prose.
- No run starts at `RECEIVED`.
- No supplier is contacted from this system. That belongs to the relay or to the business unit.
- Absence is declared only if primary: where it was searched and with which Chinese formulations, or it is not declared.
