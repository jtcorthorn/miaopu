#!/usr/bin/env bash
# Miaopu deep-search panel · bash (WSL, git-bash, macOS)
#   ./run_panel.sh arm/taskings/TASKING_REQ-0XX_<date>.md            # parallel
#   SERIAL=1 ./run_panel.sh arm/taskings/TASKING_weekly_<date>.md    # serial
set -euo pipefail

TASKING="${1:?usage: run_panel.sh <tasking-file> }"
RUN_ID="${RUN_ID:-$(date +%Y-%m-%d_%H%M)}"
TODAY="$(date +%Y-%m-%d)"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"   # = <repo>/arm
PANEL="$ROOT/inbox/panel/$RUN_ID"
export OPENCODE_ENABLE_EXA=1   # without this there is no websearch tool on an OpenRouter model

MODELS=("${MODELS[@]:-}")
if [ -z "${MODELS[0]:-}" ]; then
  # Default roster shape: three panelists. The freed seat
  # does NOT go to DeepSeek V4 Pro: it holds the verifier seat and would be judge and party.
  MODELS=(
    "openrouter/z-ai/glm-5.3"
    "openrouter/minimax/minimax-m3"
    "openrouter/qwen/qwen3.8-2.4t-a95b"
  )
fi

mkdir -p "$PANEL"
slug() { echo "${1#openrouter/}" | tr '/:.' '---'; }

run_one() {
  local model="$1" s out rel t0 code
  s="$(slug "$model")"; out="$PANEL/$s"; mkdir -p "$out"
  rel="inbox/panel/$RUN_ID/$s/FINDINGS_$TODAY.md"
  t0=$(date +%s)
  timeout "${TIMEOUT_MIN:-30}m" ${PANEL_CLI:-opencode} run --agent panelist --model "$model" --dir "$ROOT" --auto --format json \
    "Read AGENTS.md and OUTPUT_CONTRACT.md in this directory, then execute the tasking in $TASKING.
Write your output to exactly this path and nowhere else: $rel
Write that file yourself. Do NOT delegate the sweep to subagents or spawn parallel research tasks:
you are being compared against other models on your own work, so delegation invalidates the comparison.
Save partial work as you go rather than holding everything until the end.
You are running in isolation as one panelist among several models. Do not speculate about other runs.
The run ends when that file is saved. State the path and stop." \
    > "$out/_transcript_$s.jsonl" 2>&1
  code=$?
  printf '{"model":"%s","exitCode":%s,"wrote":%s,"seconds":%s}\n' \
    "$model" "$code" "$( [ -f "$ROOT/$rel" ] && echo true || echo false )" "$(( $(date +%s) - t0 ))" \
    > "$out/_status.json"
  if [ -f "$ROOT/$rel" ]; then echo "[$s] wrote $rel"; else echo "[$s] FINISHED WITHOUT WRITING ITS FILE"; fi
}

for m in "${MODELS[@]}"; do
  if [ "${SERIAL:-0}" = "1" ]; then echo "[$(slug "$m")] running..."; run_one "$m"
  else echo "[$(slug "$m")] launched"; run_one "$m" & fi
done
[ "${SERIAL:-0}" = "1" ] || wait

written=0
{
  echo "# Panel run $RUN_ID"; echo
  echo "Tasking: $TASKING"
  echo "Models: ${MODELS[*]}"
  echo "Mode: $([ "${SERIAL:-0}" = "1" ] && echo serial || echo parallel)"
  echo "Closed: $(date +%H:%M:%S)"; echo
  echo "| Model | Status | Output file | Bytes | Findings | Sourced claims | Duplicates of pipeline | Unique to this model | Fabrications caught |"
  echo "|---|---|---|---|---|---|---|---|---|"
  for m in "${MODELS[@]}"; do
    s="$(slug "$m")"; f="$PANEL/$s/FINDINGS_$TODAY.md"
    if [ -f "$f" ]; then
      written=$((written+1))
      echo "| $m | ok | \`$s/FINDINGS_$TODAY.md\` | $(wc -c < "$f") | $(grep -c '^### F-' "$f") | | | | |"
    else
      why=$( [ -f "$PANEL/$s/_status.json" ] && echo "ran, wrote nothing" || echo "killed or never finished" )
      echo "| $m | **MISSING** ($why) | | 0 | 0 | | | | |"
    fi
  done
  echo
  echo "Columns beyond Findings are filled by the main system during intake, never by the arm."
  echo "A model that produced zero findings is a data point about the model, not an empty week."
  echo "A row marked MISSING is a failed run, not an empty result. Check \`_status.json\` and the transcript first."
} > "$PANEL/COMPARISON.md"

echo "Panel closed. Sheet: $PANEL/COMPARISON.md"
echo "Next: python3 reconcile.py inbox/panel/$RUN_ID"
