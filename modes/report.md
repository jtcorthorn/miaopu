# miaopu-report

The output layer. Every deliverable that leaves the system is rendered with this mode: same chrome, same series, same language. A digest in plain markdown is no longer a deliverable, it is a draft.

## The three formats

| Series | Format | Ceiling | Recipient | Content |
|---|---|---|---|---|
| **MP-D** | Weekly digest | 2 pages | The relay | The structure of `digest.md` |
| **MP-M** | Assessment memo | 3 pages | The relay, escalatable to committee | The 11 blocks of `assess.md` |
| **MP-Q** | Quarterly one-pager | 1 page, hard | Headquarters via the relay | Overview of the quarter, concrete asks |

Numbering by series, sequential and never reused. Before assigning, check the highest existing number in `02_Digests/` and `03_Memos/`. Deliverables produced before this mode existed, in plain markdown, still count in the series: the next number continues from them rather than restarting.

## Hard rules

1. **English.** All project output, by operator decision. Company names always with their 中文名. Zero em dashes.
2. **The template gets copied, the chrome does not get touched.** Templates live in `templates/`. You copy the file, you replace only the content. Tokens, band, section anchors and footer are not edited. The digest one is a real, complete reference deliverable; memo and quarterly carry placeholders. **Assume the reference template lags the mode.** Sections get added to `modes/digest.md` and the rendered reference is not re-cut every time, so it will be one or two sections behind. Build from `modes/digest.md`, which is the authority on structure, and treat the template as chrome only.
3. **Chrome tokens.** Single source is `templates/` in this repo. The shipped palette is a default, compiled from a corporate design manual: cream `#F9F2E0`, olive `#435340`, lime `#B5B834`, ink `#2F1C13`. Polarity rule: the header band is the only dark-mode element; the body is always cream. Never pure white or pure black. An operator in another organization replaces these four tokens in `templates/` and changes nothing else: no mode reads a colour. Two fixes that are already paid for: `@page{background}` is mandatory or the paper margins render pure white, and the band carries `margin:0 -14mm` so it bleeds to the paper edge.
4. **Page ceiling per format.** If it does not fit, content gets cut, a page never gets added. Leftover candidates go to the workbook. **The cut order is fixed:** first a candidate drops from NEW CANDIDATES to the workbook, then MOVEMENTS loses its least material line, then WHITESPACE compresses to one line. COVERAGE and PRODUCED BY are never what gets cut, because they are what makes the rest auditable, and a deliverable that drops its own coverage to fit one more candidate has cut the wrong thing.
5. **No section disappears in silence.** A section with no news says so in one line.
6. **PNG verification is mandatory.** The render clips overflows in silence and the page count is not enough. Rasterize every page and look at them before calling it closed. Two known failure modes, inherited from a sibling reporting system: half a page of air (fill it with a table that already exists in the data, never with filler) and tables of 3+ columns without `table-layout:fixed` with explicit widths (they collapse and push pages). The templates already ship `colgroup` with widths: keep them.
7. **Style.** Deliverables carry the operator's voice, not the system's. Miaopu supplies structure and evidence; wording is the operator's. Never invent a stance the operator did not state.

## Production cycle

1. Content closed in text first (the structure of the corresponding mode).
2. Copy the template, instantiate: series, date, recipient, content.
3. Render to PDF (weasyprint or equivalent, A4 size).
4. Rasterize to PNG and review every page: no overflows, no cuts, footer present on all of them. **Plus the edge test, by sampling and not by eye**: read the pixel at eight points around the border of every page (four corners, four mid-edges). Any pure `#FFFFFF` sample is a failed render, not a taste question, and sends you back to `@page{background}` and the band bleed. White margins shipped on every early MP-D, were invisible on visual review, and only fell out of pixel sampling. That is the whole argument for sampling instead of looking.
5. File it: PDF in `02_Digests/` (MP-D) or `03_Memos/` (MP-M, MP-Q), source HTML in the `_source/` subfolder of the same directory. Pattern `MP-X-NN_YYYY-MM-DD.pdf`. Never overwrite: previous version to `_archive/` before writing the new one.
6. Log in `05_Event_Log` and append to `_meta/BITACORA.md`.

## What wins if there is a conflict

The content is governed by the originating mode (`digest.md`, `assess.md`). This mode governs only form, series and language. If a content adjustment breaks the page ceiling, the ceiling wins: it gets cut.
