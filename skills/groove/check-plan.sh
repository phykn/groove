#!/usr/bin/env bash
# usage: check-plan.sh [docs/groove/PLAN.md]
plan=${1:-docs/groove/PLAN.md}
[ -f "$plan" ] || { echo "no plan at $plan"; exit 2; }

awk '
function report(problem) { print problem; failed = 1 }
function close_task() { if (task != "" && !has_done) report(task ": no Done when") }

/^```/ { fenced = !fenced; next }
fenced { next }

{
    text = $0
    gsub(/`[^`]*`/, "", text)
    if (text ~ /<[^<>]+>/) report("line " NR ": unfilled placeholder")
}

/^- R[0-9]+:/ {
    id = $2
    sub(/:$/, "", id)
    if (id in required) report(id ": defined twice")
    required[id] = 1
}

/^- \[[ x]\] T[0-9]+\./ {
    close_task()
    match($0, /T[0-9]+/)
    task = substr($0, RSTART, RLENGTH)
    has_done = 0
}
/Done when:/ { has_done = 1 }

{
    rest = $0
    while (match(rest, /R[0-9]+/)) {
        id = substr(rest, RSTART, RLENGTH)
        named[id] = 1
        if (task != "") covered[id] = 1
        rest = substr(rest, RSTART + RLENGTH)
    }
}

END {
    if (task == "") report("no tasks")
    close_task()
    for (id in required) if (!(id in covered)) report(id ": no task covers it")
    for (id in named) if (!(id in required)) report(id ": not a requirement")
    exit failed
}
' "$plan" && echo "plan ok"
