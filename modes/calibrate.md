# miaopu-calibrate

The learning loop. Without this Miaopu is a search engine, not a system.

Two signals, two directions of error.

## Signal 1: discrepancy between the score and the human verdict

Every time the system's score does not match what a human decides, there is training data.

| Case | What it means |
|---|---|
| I scored high, headquarters dropped it | False positive. There is a criterion the committee applies and the rubric does not capture |
| I scored low, headquarters or the operator wants to see it anyway | Rubric false negative. An axis is badly weighted |
| I scored high and it advanced | Confirmation. It gets logged all the same, because without positives the sample is biased toward errors |

### The verdict problem, and how it gets solved

The committee's verdict arrives as a fixed phrase with no technical content: *"we discussed the opportunity in committee, but our decision is not to proceed with an investment at this time."* That trains nothing.

**The rich reason shows up earlier, in the round with R&D.** In the case that established this rule, the real analysis of why a candidate was dropped came through the R&D channel and not through the committee: its gasification route was already covered by an internal project, its cellulosic sugars did not compete with the incumbent feedstock on cost, and its lignin volumes were too small to validate the full route. None of those three reasons appeared in the committee's sentence.

Operating rule: **capture the reason at the R&D step, not at the committee one.** When headquarters returns a verdict with no reason, ask for it explicitly, and if it does not arrive, log `reason not obtained` instead of inventing one. A discrepancy without a reason is noise and must not move weights.

## Signal 2: miss check

False negatives, which in scouting are invisible by default.

Periodically sweep closed rounds, industrial agreements and commissionings in China within the verticals in `config.md`, and cross them against `01_Pipeline` including the archived ones.

| Result | Action |
|---|---|
| We had it and we scored it right | Nothing, it gets logged |
| We had it archived and someone invested | **Miss.** Understand why. It is the most informative case in the system |
| We did not have it | Coverage miss. The problem is in `04_Sources`, not in the rubric |

The distinction between a rubric miss and a coverage miss matters: one is fixed by changing weights, the other by adding a source. Confusing them makes the system tweak weights to paper over a coverage hole.

## Flow

1. Read `06_Calibration` and the rows of `01_Pipeline` with a verdict since the last calibration run.
2. Classify each discrepancy by type and by responsible axis. Which axis would have corrected the error if it had weighed differently?
3. Run the miss check over the period.
4. **Only propose a weight change with at least three cases pointing at the same axis.** One case is anecdote. Reweighting with n=1 is overfitting to the last conversation.
5. Present the proposal to the operator: current weight, proposed weight, the cases that support it, and the effect on the full history if applied.
6. Once approved, change the cell in `02_Scoring` and **recalculate the whole history**. That is the reason the base is a sheet and not Notion.
7. Log the change in `06_Calibration` with date and justification. The rubric carries its own changelog.

## What gets calibrated besides the weights

- **Thresholds.** If nothing gets past the deep-dive threshold in `config.md` for months, either the threshold is wrong or the theme's thesis is dead. Tell which of the two.
- **Gates.** A knockout that never kills anything is dead text and has to be pruned. One that kills everything is a badly placed filter.
- **Sources.** Coverage per source against findings it produced. A source that gets swept every week and never contributed anything comes off the register.
- **Cadence.** If the middle layer moves faster than expected, it goes up to weekly.

## Lessons already logged from run 1

They go into the log on day one, so the system does not start from zero:

1. **The cost parity axis turned out to be more discriminating than the feedstock fit axis.** The five candidates from run 1 died on market price, none on bad fit. Approved by the operator and applied in `02_Scoring`, with the whole history recalculated, which is how the change showed up on rows that had been scored months earlier.
2. **The derivative of price is missing, not just the level.** In Chinese sectors on a ramp the price falls 20% a year and a thesis that was right eighteen months ago is dead today. That is where `07_Theme_Tracker` was born.
3. **Gate A4 could not be run** for lack of a source of control lists. Until that is resolved, it is a flag and not a knockout, and it has to be said on every card.
4. **The verification layer paid for itself in the first run**: three material errors in a card that was already circulating internally.

## Cadence

Monthly, or whenever a verdict from headquarters arrives. The miss check, quarterly, because a round takes time to become public.
