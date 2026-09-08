# miaopu-digest

The report of the run. It is born forwardable.

This is the point where the system stops being a personal tool of the operator's and becomes the regional office's institutional contribution to Ventures. If the digest is only good for the operator to read, the system is worth half. The design standard is: **The operator must be able to forward it without editing it**, or paste a section into an email with two lines of context on top.

## The chain of recipients

**The digest goes to the relay, not to the internal client.** That is the route the operator always uses, and the relay decides what escalates to headquarters. Skipping the relay breaks a chain that already works and strips them of the role they hold.

Practical consequence: the digest is written for a reader who is **in region, not at headquarters**. The relay handles the Chinese context, talks to the paid-intelligence provider and knows the companies. With them there is no need to explain what 专精特新 is or why the corporate registry matters. But they do need the material ready so they can push it to the internal client without redoing it, which is where the global comparable and the translation of names remain mandatory.

The formatting rules follow from that.

## Formatting rules

**In English.** All project output goes in English, by operator decision. Company names carry their 中文名 alongside, because both the relay and the internal client will search for them. Technical terms as headquarters uses them: feedstock, TRL, vertical, deep dive, due diligence.

**Nothing without a comparable.** Every candidate that appears carries its direct analogue. The internal client will ask for this: it is the most common standing request, and the one most often left unmet. It is the difference between a map of China and an actionable recommendation. They also ask for the indirect comparable, the different route to the same problem. That one lives in the fiche, not in the weekly line, because it needs a paragraph and not a clause.

**Short.** If it does not fit in a screen and a half, you are reporting activity instead of findings. Nobody in headquarters cares about activity.

## Structure

```
MIAOPU · Weekly Digest [n], [date]  (series MP-D, see modes/report.md)
To: The relay

BOTTOM LINE
Two or three lines. If nothing material happened, say so, no trimmings.

ALERTS
Only if there are any. A candidate with direct feedstock fit, a move by a
reference player, a price change above 10%, or a patent granted in a space
we had marked as empty.

NEW CANDIDATES
By vertical. One line each: what it does, precursor or feedstock, scale
operating, score, direct comparable, forestry track record, and business model.
Maximum five. If there are more, they go to the workbook and the best five make
the digest.

REJECTED THIS WEEK
Three or four names with one clause each on why they died: failed gate, score
below the archive threshold in `config.md`, or out of scope. No detail, no defence. This section exists because
the client asked to be told which ones make no sense, not only which ones do.

MOVEMENTS
Changes in candidates already in pipeline, and moves in the theme tracker with
the variation since the last measurement.

WHITESPACE
New gaps with their class, the hypothesis of why it is empty, and the
cheapest experiment that resolves it.

FOR THE PAID-INTELLIGENCE PROVIDER
Specific and verifiable requests for the next interaction. Not vague briefs:
concrete questions about concrete companies.

COVERAGE
Which layers were swept and which were not due this week. Which sources could
not be reached. Rubric fill rate: the two or three fields that stayed empty this
week and after how many formulations. This section is short and it is mandatory.

PRODUCED BY
Two lines, mandatory. Which models ran the sweep and in which role, and the
panel's own numbers off COMPARISON.md: findings per model, how many were
duplicates of the pipeline, how many were unique to one model, how many claims
the verifier killed for having no source.
```

## PRODUCED BY: show the engine, in numbers

Headquarters is being asked to act on findings from an engine it cannot see. The answer is not a list of model brand
names, which tells a committee nothing and invites the wrong conversation. The answer is the panel's own audit
numbers, which already exist in `arm/inbox/panel/<RUN_ID>/COMPARISON.md` and are thrown away today.

What earns the two lines: the same tasking ran in isolation on each panelist, so a finding that only one model
surfaced is a recall gain and a finding all of them surfaced is usually one press article read three times. Then
the verifier pass, and how many claims it killed for carrying no source. That last number is the one that makes
the fiche believable, because it says the system deletes its own output.

Say it plainly and once: the arm reads public Chinese sources, it is mounted only in `arm/`, and it never
touches the workbook. That closes the governance question before it is asked, in a clause instead of a meeting.

**Model agreement is not corroboration, and the line must not imply it is.** Report models and distinct source
domains as two separate numbers, the way `reconcile.py` already does. Three models and one domain is weaker
evidence than one model and three domains.

A week with no panel says so, naming the single model and the two passes it ran: sweeper and verifier in
sequence. A relay is not a panel and the line never dresses one as the other.

## The paid-intelligence provider section is not filler

The internal client has complained more than once that the paid-intelligence membership is underused, and that the underuse puts its renewal at risk. Expect that complaint to recur: a subscription nobody visibly draws on is the first line an annual budget review deletes.

This section reaches the relay, who is precisely the person operating the paid-intelligence channel. Which means it is not a complaint travelling to headquarters: it is a work list the digest's recipient can execute the same day. It is the cheapest route for the system to generate political capital, and it is honest, because these are requests that are genuinely needed.

Format of the request: company name with its 中文名, the exact question, and what the answer is good for. Never "look into the sector".

## What does not go in the digest

- Activity. How many sources were swept is not a finding
- Candidates below the archive threshold in `config.md` as candidates. They go to the workbook with their filing reason, and to REJECTED as a name plus one clause. That is the whole appearance they get
- The full eight-field rubric. Only three of the fields drop to the weekly line: direct comparable, forestry track record, business model. The other five live in the deep-dive fiche. Bringing all eight down breaks the screen-and-a-half rule this same file sets, and a digest that reports everything reports nothing
- Emerging-trend reading. The internal client asks for it explicitly, under the strategy-fit and vertical-fit points of their rubric: trends derived from those two fits. It is answered, not dropped, but not here. A trend needs a series and a week is not a series, so it goes to the quarterly MP-Q, off `07_Theme_Tracker` and `03_Whitespace`. When the quarterly runs, that section carries their framing back to them in their own words
- Speculation without a label. If it is inference, say so
- Any data without a source

## Before sending

Consult the style skill in `config.md`. Zero em dashes. And one last pass asking: if I were the internal client and had twenty minutes, what would I do differently after reading this? If the answer is nothing, the digest is not ready.

## After

Render with the report system (`modes/report.md`, template MP-D) and save the dated digest in `02_Digests/`. Log the event in `05_Event_Log`. Offer the operator a draft of the sending email, in the operator's own voice.
