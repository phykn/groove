# Plan

One file holds the plan: `docs/groove/PLAN.md`, written in the user's language, next to a `.gitignore` whose only line is `*`. A plan that already exists is changed, not replaced. Replacing it cannot be undone, so ask before doing that.

## Skeleton

`check-plan.sh` reads the IDs and markers below, so keep them as they are. Drop a section with nothing to say, and say each thing in one section only.

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

## Sections

- **Core** is the sentence every later section and task is checked against.
- **Requirements** hold what was requested and what the core flow cannot finish without. Every other feature you thought of belongs in Not doing.
- **Design** lists modules, each naming the requirements that use it. A module that can name none is dropped. A value that must match something existing, such as an ID, a column name, or a format, is read from its definition; with no definition, ask.
- **Decisions** records each decision, and each assumption you did not ask about, once, with its reason.
- **Tasks** each fit one session. `Done when` is the cheapest check that would fail if the task were wrong. A task only a person can do carries 👤, and you never invent its result.
- The first task writes two things into the agent instruction file: where the plan is, and that a session continuing the build uses groove to do the first unchecked task.

Before you stop, run `bash <this skill's folder>/check-plan.sh docs/groove/PLAN.md` from the project root and fix what it reports.
