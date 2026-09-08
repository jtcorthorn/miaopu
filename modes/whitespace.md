# miaopu-whitespace

Active hunt for gaps. What should exist and does not.

This mode is the reason the system survives. Candidate-centered scouting produces mostly negatives, and negatives are the cheapest thing to produce and the hardest thing to get paid for. The edge of an industrial CVC is not finding the startup a financial fund also finds: it is identifying the gap only the company can fill, because it has the raw material and can run the experiment without asking anyone for permission.

The first run proved it. The pipeline result was zero candidates over the threshold. The result with value was three gaps.

## The four classes of gap

**1. Industry gap.** A business model that exists in one market and not in another, or that nobody is running.
> Worked example from run 1: no listed Chinese paper company has a hard carbon program. Verified against a primary source: zero records of 黑液 across the entire investor interaction platform, zero of 木质素 crossed with 硬碳, and of 32 records of 硬碳负极 none is from a paper or pulp company. The absence is the finding.

**2. IP gap.** A claim nobody executed, or an empty patent space.
> Worked example: a granted patent claims kraft lignin in its claim 3, while all six of its worked examples use lignosulfonate and alkali lignin. Zero examples with kraft. The holder has freedom of claim and never ran it, which is exactly what an IP gap looks like from the outside.

**3. Literature gap.** A material, species or route with no published work.
> Worked example: a plantation species the company grows at scale, for which nobody in the world has published hard carbon for sodium. The company holds the asset and nobody holds the data.

**4. Data gap.** Something the market needs to know and nobody measures.
> Worked example: the analysis of ash, Na, K and sulfate in ppm of the company's own kraft lignin, read against the impurity spec written into a third party's patent. It costs one lab analysis and it decides an entire thesis.

## Flow

1. **Start from the absence, not the presence.** The question is not what did I find, it is what did I expect to find and was not there. After sweeping a topic, list the players, routes or data that sector logic predicts and the sweep did not return.

2. **Verify the absence is real and not an artifact of the method.** An absence can be of the world or of the search. Before logging it, search with at least two different formulations, including one in Chinese, and against a primary source if one exists. **Zero records of a term in a primary source is evidence. Zero results in a search engine is not.**

3. **Classify** into one of the four classes.

4. **Ask why it is empty.** Three possible hypotheses and you have to choose with evidence:
   - Nobody has tried it (opportunity)
   - They tried it and it did not close (trap, and you have to find the corpse)
   - It is happening and is not public yet (timing risk)

   This question is mandatory. A gap with no hypothesis of why it is empty is an invitation to repeat someone else's mistake. In run 1 the corpse was in plain sight: a large European pulp producer had already built a lignin anode line and frozen it, and the freeze was public.

5. **Assess whether the company can fill it.** The gap is only worth something if the missing asset is one the company has. Kraft lignin, black liquor, kraft pulp, plantation wood of the species the company actually grows, or access to industrial operations for piloting.

6. **Define the cheapest experiment that resolves it.** A gap with no concrete, bounded next step is an observation, not an asset. The standard is: what can be done for less than the cost of a trip, and what result would kill it.

7. **Write to `03_Whitespace`** with the operator's approval. Fields: class, description, evidence of the absence with source, hypothesis of why it is empty, the company asset that applies, proposed experiment, estimated cost, kill criterion, and status.

## Honesty rule

A gap with a corpse inside gets logged anyway, marked as a trap. It is as valuable as an opportunity and cheaper: it stops someone at headquarters from proposing in six months what already died somewhere else.

## Output

Proposed entries for `03_Whitespace`, and one line for the digest per new gap with class, hypothesis and experiment.
