#!/usr/bin/env bash
awk '
function report(problem) { print problem; problems++ }

function end_task() {
    if (task != "" && !done_when) report(task ": no Done when")
    task = ""
}

function mark_requirements(line,    words, total, i, found) {
    gsub(/[^A-Za-z0-9_]/, " ", line)
    total = split(line, words, " ")
    for (i = 1; i <= total; i++) {
        if (words[i] !~ /^R[0-9]+$/) continue
        named[words[i]] = 1
        if (task != "") covered[words[i]] = 1
        found = 1
    }
    return found
}

/^[ \t]*```/ { in_fence = !in_fence; next }
in_fence { next }

{
    prose = $0
    gsub(/`[^`]*`/, "", prose)
    if (prose ~ /<[^<> =-]([^<>]*[^<> =-])?>/) report("line " NR ": unfilled placeholder")
}

/^[^ \t]/ { end_task() }
/^## / { section = $0 }

/^- R[0-9]+:/ {
    id = substr($2, 1, length($2) - 1)
    if (id in defined) report(id ": defined twice")
    defined[id] = 1
}

/^- \[.\] / {
    if ($0 !~ /^- \[[ x]\] T[0-9]+\. /) {
        report("line " NR ": task line needs an ID such as T1.")
        next
    }
    task = $0
    sub(/^- \[.\] /, "", task)
    sub(/\..*/, "", task)
    if (task in tasks) report(task ": defined twice")
    tasks[task] = 1
    done_when = 0
}

/^[ \t]+- Done when:/ { done_when = 1 }

{
    if (!mark_requirements($0) && section == "## Design" && /^- /)
        report("line " NR ": design item names no requirement")
}

END {
    end_task()
    for (id in defined) if (!(id in covered)) report(id ": no task covers it")
    for (id in named) if (!(id in defined)) report(id ": not a requirement")
    exit problems > 0
}
' "${1:-docs/groove/PLAN.md}" && echo "plan ok"
