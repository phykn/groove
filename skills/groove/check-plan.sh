#!/usr/bin/env bash
# usage: check-plan.sh [docs/groove/PLAN.md]
plan=${1:-docs/groove/PLAN.md}
[ -f "$plan" ] || { echo "no plan at $plan"; exit 2; }

awk '
/^```/ { code = !code; next }
code { next }

{ prose = $0; gsub(/`[^`]*`/, "", prose) }
prose ~ /<[^<>]+>/ { print "line " NR ": unfilled placeholder"; bad = 1 }

/^- R[0-9]+:/ {
    id = substr($2, 1, length($2) - 1)
    if (id in defined) { print id ": defined twice"; bad = 1 }
    defined[id] = 1
}

/^- \[[ x]\] / {
    if (task != "" && !done) { print task ": no Done when"; bad = 1 }
    task = $4; done = 0
}
task != "" && /Done when:/ { done = 1 }

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
    if (task == "") { print "no tasks"; bad = 1 }
    else if (!done) { print task ": no Done when"; bad = 1 }
    for (id in defined) if (!(id in covered)) { print id ": no task covers it"; bad = 1 }
    for (id in used) if (!(id in defined)) { print id ": not a requirement"; bad = 1 }
    exit bad
}
' "$plan" && echo "plan ok"
