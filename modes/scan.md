# miaopu-scan

The run. Sweeps the source registry in `04_Sources` respecting the cadence per layer and proposes new candidates.

The edge here is double: the language and the cadence discipline. The signal that matters is in Chinese and shows
up in provincial filings, ministerial lists, patents and sector press before it reaches any Western database. And
not everything moves at the same speed, so sweeping everything every week produces noise and kills the reading habit.

## Cadence

Read the cadence table in `config.md`. Summary:

| Layer | Cadence | What moves there |
|---|---|---|
| Fast | Weekly | Rounds, capital press, sector WeChat, investor-interaction filings |
| Medium | Monthly | Prices and cost curves, tenders, capacity coming online |
| Slow | Quarterly | Patents, papers, state lists, trade fairs |

**A weekly run sweeps the fast layer only.** The digest declares which layers were not touched. That honesty is
part of the product: a digest saying "nothing moved in the slow layer this week" is more useful than one that
stretches a finding to justify itself.

## Flow

1. **Load the registry.** Read `04_Sources`: source, language, layer, cadence, the retrieval route that works, and
   last date swept. Prioritize Chinese and primary sources over secondary press.

2. **Sweep by layer.** Look for signals across the verticals in `config.md` plus the active themes in
   `07_Theme_Tracker`: new companies, rounds, capacity coming online, price changes, granted patents, papers, and
   moves by relevant actors.

2b. **Hunt the client rubric, do not wait for it.** The eight fields the internal client declared are what their
   committee analyses, so five of them are search objectives of this mode and not fields that get filled if the
   sweep happens to trip over them: `forestry_track_record`, `traction`, `business_model`, `differentiators`,
   `comparable_direct` and `comparable_indirect`. For every candidate that survives dedup, run at least two
   Chinese formulations per field, built from the company's own name and its precursor:

   | Field | Formulations to build |
   |---|---|
   | Forestry track record | `[公司] 造纸 合作` · `[公司] 制浆 客户` · `[公司] 林业 试用` · `[公司] 中试 纸厂` |
   | Traction | `[公司] 订单` · `[公司] 中标` · `[公司] 量产 客户` · `[公司] 供货协议` |
   | Business model | `[公司] 技术许可` · `[公司] 合资` · `[公司] 设备 销售` · `[公司] 委托加工` |
   | Differentiators | `[公司] 技术路线 优势` · `[技术] 路线 对比` · `[公司] 与 [comparable] 对比` |
   | Comparables | `[技术] 国内 厂商 名单` · `[技术] 竞争格局` · `[技术] 替代 路线` |

   Two rules that make this worth running. **The search is what converts an empty field into evidence**: a field
   left blank because nobody looked is a hole in the system, a field left `not obtained` after two primary
   formulations is a statement about Chinese disclosure, and only the second one is reportable. And **these are
   the six fields a language model writes most fluently from nothing**, which is why they carry a source or the
   literal words `not obtained`, never a plausible sentence.

3. **Deduplicate.** Against `01_Pipeline` and `05_Event_Log`. Careful with Chinese aliases: Chinese name, official
   English name, subsidiary, and press transliteration are the same entity. Only genuinely new or materially
   updated items go up.

4. **Verify online what is verifiable.** Registered versus raised capital, announced versus operating capacity, and
   what any cited standard actually says. An unverified candidate still enters, marked, but is not scored until it
   passes through `intake.md`.

5. **Update the theme tracker.** If a price, a tender or a cost data point shows up, it goes to `07_Theme_Tracker`
   with its date. **The time series is the asset, not the loose data point.** A thesis that was right eighteen
   months ago can be dead today, and that is only visible in the series.

6. **Do not invent.** If a source hints at a number that cannot be confirmed, it is recorded as a hole or a flag,
   not as data.

7. **Flag alerts.** These rise to the top of the digest: a candidate with direct feedstock fit (plantation wood,
   kraft pulp, or a kraft by-product), a move by a reference industrial actor, a price change above 10% in the
   medium layer, or a granted patent in a space we had marked as empty.

8. **Close with whitespace.** Every run ends by asking what should have appeared and did not. Run `whitespace.md`.

9. **Deliver, do not commit.** Candidates are presented as a list for review. The operator approves which ones enter. The
   approved ones route through `intake.md` for full normalization.

## Output

Dated scan digest, which feeds `digest.md`:

- Alerts at the top if any
- New candidates, grouped by vertical, one line each with origin label and link
- Theme tracker moves, with the change since the last measurement
- Proposed holes
- **Rubric coverage**: one row per rubric field, how many of this run's candidates carry a sourced value and how
  many stayed `not obtained` after the formulations above. Report the fill rate, do not apologize for it. Traction
  will be the low one for as long as the corporate registry stays blocked, and a measured hole is the finding
- **Honest coverage**: which sources were swept, which could not be reached, and which layers were not due this week

## Retrieval notes

Several Chinese sources do not respond to a plain fetch. The route that works per source is recorded in its
`04_Sources` row, not in this file.

Blocked for programmatic querying at the time of writing: 企查查, 天眼查, 爱企查 (the entire corporate registry) and
Google Patents. That list moves, so it is re-checked rather than trusted. The official investor-interaction platform of the Chinese exchanges (irm.cninfo.com.cn) does work
and turned out to be the best primary source of the sweep: it allows verifying by term search what a listed
company is declaring and, above all, **what it is not declaring**. Zero records for a term is data, not an
absence of data.
