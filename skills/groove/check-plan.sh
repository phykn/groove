#!/usr/bin/env bash
# usage: check-plan.sh [docs/groove/PLAN.md]
plan=${1:-docs/groove/PLAN.md}
[ -f "$plan" ] || { echo "no plan at $plan"; exit 2; }

awk '
function fail(message) { print message; bad = 1 }
function end_task() { if (task != "" && !done) fail(task ": no Done when") }

/^```/ { code = !code; next }
code { next }

{ prose = $0; gsub(/`[^`]*`/, "", prose) }
prose ~ /<[^<>]+>/ { fail("line " NR ": unfilled placeholder") }

/^- R[0-9]+:/ {
    id = substr($2, 1, length($2) - 1)
    if (id in defined) fail(id ": defined twice")
    defined[id] = 1
}

/^- \[[ x]\] / { end_task(); task = $2 == "[x]" ? $3 : $4; done = 0 }
/Done when:/ { done = 1 }

{
    line = $0
    while (match(line, /R[0-9]+/)) {
        id = substr(line, RSTART, RLENGTH)
        used[id] = 1
        if (task != "") covered[id] = 1
        line = substr(line, RSTART + RLENGTH)
    }
}

END {
    if (task == "") fail("no tasks")
    end_task()
    for (id in defined) if (!(id in covered)) fail(id ": no task covers it")
    for (id in used) if (!(id in defined)) fail(id ": not a requirement")
    exit bad
}
' "$plan" && echo "plan ok"
