# Plan

Write the plan as one file, `docs/groove/PLAN.md`, in the user's language, with a `.gitignore` containing `*` beside it. If a plan exists, change it. Replacing it whole cannot be undone, so ask first.

## Skeleton

Keep the IDs and markers exactly as shown; `check-plan.sh` reads them. Delete a section that does not apply, and say each thing in one place.

```markdown
# <project>

## Core

<the request's core in one sentence>

## Requirements

- R1: <what is true when it works, checkable by a number or an observation>

## Not doing

- <something an agent would add unasked>: <why not>

## Design

- `<module>`: <what it does> (R1)

## Decisions

- <what you decided or assumed>: <why>

## Tasks

- [ ] T1. <task> (R1)
  - Done when: <a command, or something a person can confirm without judgment>
```

## Rules

- **Core**: check every later section and task against this sentence.
- **Requirements**: only what was requested, or what the core flow cannot finish without. Any other feature you thought of goes to Not doing.
- **Design**: each module names the requirements that use it; drop one that can name none. Read values that must match something existing, such as IDs, column names, and formats, from their definition. If there is no definition, ask.
- **Decisions**: each decision, and each assumption you did not ask about, once, with its reason.
- **Tasks**: each fits one session. `Done when` is the cheapest check that would fail if the task were wrong. Mark a task only a person can do with 👤, and never invent its result.
- The first task writes into the agent instruction file where the plan is, and that a session continuing the build uses groove to do the first unchecked task.

Before stopping, run `bash <this skill's folder>/check-plan.sh docs/groove/PLAN.md` from the project root and fix what it reports.
