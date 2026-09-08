# miaopu-assess

Deep dive on a candidate over the deep-dive threshold in `config.md`, or when the operator asks for a full validation. The output is a memo that can go to committee without rework.

Intake decides whether it is worth looking. Assess decides whether it is worth acting, and with which vehicle.

## When it runs

A score in `01_Pipeline` at or above the deep-dive threshold in `config.md`, or a direct instruction from the operator. A candidate below the threshold can be assessed if the interest comes from headquarters, but it gets logged in `06_Calibration` as a discrepancy: if the system scored something well below the bar and the internal client wants to see it anyway, the rubric is miscalibrated and that is training data.

## Memo structure

**1. Bottom line.** Pursue, park or kill, with the proposed vehicle, in three lines. First, not last.

**2. What it does, technically, and how it charges for it.** No adjectives, no brochure language. If the mechanism cannot be explained, that itself is the finding. Close the block with the **business model**: licence, JV, equipment sale, tolling, product sale, or the actual mix. It belongs here and not in the commercial section because the mechanism and the way it is sold decide each other, and because the committee reads them together (rubric field 6).

**3. The fit with the company, quantified, and the industrial evidence.** Species it accepts, percentage of the by-product in the recipe, yield per species, whether it accepts forest and industrial residues. Potential volume against what the company produces. Without numbers here, the memo is not ready.

   Then the two evidence fields the committee filters on. **Forestry track record** (rubric field 3): named forestry or pulp and paper counterparties and what was run with each. This is the cheapest de-risking evidence in the whole memo, because a technology that already ran with a large pulp or paper producer has been through an industrial feedstock it did not choose. "Works with the sector" is not a track record. **Traction** (rubric field 2, the market half of maturity): paying customers, signed contracts, order book, lines or plants sold. Expect `not obtained` here more often than not, and write those words rather than an estimate.

**4. Unit economics against the incumbent.** Stated cost, verified cost if possible, market price of the substituted product, **and the trend of that price**. Green parity, not green premium: the venture arm's own market reading is categorical, and the market already rejects the green markup. A product at parity today in a market falling 20% a year is not at parity.

**5. Comparables, direct and indirect.** Mandatory and the heart of the memo. Both, since the internal client split the field (rubric field 8), and the split is not cosmetic: **the direct one says whether this candidate wins its own race, the indirect one says whether the race is worth entering.** A memo carrying only the direct comparable answers the smaller of the two questions.

   **Direct.** Same technology, same market. The analogue outside China: what stage, how much it raised, who backs it, and why the Chinese one wins or loses. Priority to the analogue coming from the pulp and paper industry, because it is the direct mirror of what the company could do on its own.

   **Indirect.** A different route to the same problem, the incumbent included. This is where a technically excellent candidate dies honestly: if the incumbent route is cheaper and already installed, the case is weak no matter how good the chemistry is.

   **And find the corpse.** If someone already tried this route and abandoned it, finding that is worth more than any projection. The signal is in the absence: investment decisions not taken in three years, topics that disappear from financial reports, plants that get sold, executives who publicly back a different technology.

**6. Intellectual property.** Patent family, jurisdictions, **verified current holder**. There is precedent of a Chinese university patent transferred to a private company nineteen months after filing. Verify ownership before any licensing conversation. This block does not constitute a freedom to operate analysis and must say so.

**7. Exportability risk.** The six sub-axes: IP ownership and jurisdiction, dependence on local subsidy, portability of the supply chain, exposure to export control or dual use, willingness to license or form a JV abroad, and precedent of international operation.

**8. Differentiators, and why us.** Two halves that only mean something together. First the **differentiators** (rubric field 7): what this company does that the incumbent and the direct comparable cannot, stated as a capability with evidence behind it and never as a claim off their own deck. Then the inverted question: what does the company have that is worth more to the candidate than the check? A purchase order, a reference plant outside China, a feedstock nobody else gives them, or access to the company's home region. If the answer is "nothing, just money", the case is weak, because a good Chinese startup in a hot vertical does not need the company's check.

**9. Vehicle and next step.** Which of the routing vehicles in the table in `intake.md`, who is the internal counterpart, and what is the experiment or meeting that follows.

**10. Kill criterion.** Defined before spending. What result kills the case. Without this, an assessment turns into a process that justifies itself.

**11. Open questions, what could not be verified, and rubric coverage.** Explicit. A "no findings" on a check that could not be run is an unverified negative, not a pass.

   Close with two mandatory lines. **Rubric coverage**: which of the internal client's eight fields this memo answers and which stayed empty, and for each empty one whether it was searched. A field nobody hunted and a field that survived its Chinese formulations both look like a blank, and only the second one is a finding. **Produced by**: which models ran the sweep and in which role, corroboration as two separate numbers (models and distinct source domains, off `reconcile.py`), and how many claims the verifier killed for having no source. The memo goes to a committee that cannot run the engine, so it carries the engine's numbers instead of a claim of rigour.

## Before writing

- Read the full row in `01_Pipeline` and the topic history in `07_Theme_Tracker`
- If the case has real stakes, offer the operator a structured devil's-advocate pass before closing the recommendation
- Check the style skill in `config.md` for the drafting

## After writing

Update `01_Pipeline` with the recommendation and the date. Log the event. If the assess killed the case, **the reason gets written in full**, because it is the input to the calibration loop and the reason that comes back from committee does not serve that purpose: it arrives as a fixed phrase with no technical content.
