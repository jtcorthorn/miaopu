# TASKING · [REQ-0XX | weekly sweep] · YYYY-MM-DD

Self-contained. The arm reads this file and AGENTS.md, nothing else from the request folder.

## Objective

[One sentence. What must exist at the end of the run.]

## Specification

[The numeric spec, verbatim from the REQ. Every threshold with its test method. If a field is NOT SPECIFIED,
say so here too: the arm must not fill it.]

## Search scope

- Geography:
- Maturity band:
- Entity types in scope:
- Layers to sweep: [fast | fast+medium | fast+medium+slow]
- Chinese formulations (at least two per concept):
- Exclusions (Gate A2 and other):

## Client rubric fields (mandatory on every run, mission A or B)

Five fields are search objectives, not fields to fill if they happen to appear. For every entity reported, run
at least two Chinese formulations per field, built from the company name and its precursor:

| Field | Formulations |
|---|---|
| `forestry_track_record` | `[公司] 造纸 合作` · `[公司] 制浆 客户` · `[公司] 林业 试用` |
| `traction` | `[公司] 订单` · `[公司] 中标` · `[公司] 量产 客户` |
| `business_model` | `[公司] 技术许可` · `[公司] 合资` · `[公司] 设备 销售` · `[公司] 委托加工` |
| `differentiators` | `[公司] 技术路线 优势` · `[技术] 路线 对比` |
| `comparable_direct` / `comparable_indirect` | `[技术] 国内 厂商 名单` · `[技术] 竞争格局` · `[技术] 替代 路线` |

A field that survives those searches unanswered is `not obtained`, and that is a correct output. A field filled
with a confident sentence carrying no URL is the failure this block exists to prevent. Report the fill rate per
field in COVERAGE under `rubric_coverage`.

## Standing verification queue (mandatory)

Listed companies in scope for this tasking must be checked on 互动易 (irm.cninfo.com.cn) by term search.
Zero records for a term on 互动易 is evidence of absence; zero results on a search engine is not. If you
cannot reach it, say so in COVERAGE. Do not substitute a general search and call it primary.

- [ ] [company + 中文名 + the terms to search]

## Deliverable

Write to: `inbox/panel/<RUN_ID>/<MODEL_SLUG>/FINDINGS_YYYY-MM-DD.md`
Format: exactly per `OUTPUT_CONTRACT.md`. English, 中文名 on every entity.
Optional second file in the same directory: `INTAKE_DRAFT_YYYY-MM-DD.md`, non-binding.

## Stop condition

The run ends when the file is saved. State the path and stop. No approval questions, no follow-up offers.
