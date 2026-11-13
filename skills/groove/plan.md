# Plan

The plan is one file, `docs/groove/PLAN.md`, written in the user's language. Beside it sits a `.gitignore` whose only line is `*`.

## An Existing Plan

Change an existing plan in place. Never start a fresh file over it: it is outside git, so what you drop cannot be recovered.

- While any task is unchecked, change only what the new requirement touches, and leave finished tasks alone.
- Once every task is checked, new planned work begins by deleting the finished tasks. Requirements and Design then cover only the new work: a requirement that already holds stays only if a new task could break it, and that task names it. Keep every decision that still holds, and replace conflicting wording instead of adding a correction beside it.

## Skeleton

`check-plan.sh` reads the headings, IDs, and `Done when` markers below, so keep their form; you do not need to read the script. Leave out a section that has nothing to say, and say each thing in one section.

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

- **Core** is what every other section and every task is tested against.
- **Requirements** are what the user asked for and what the core flow cannot finish without. Any other feature you thought of goes in Not doing.
- **Design** lists the modules. Each names the requirements that use it, and one that can name none is dropped. Read a value that must match something existing, such as an ID, a column name, or a format, from where it is defined; if it is defined nowhere, ask.
- **Decisions** holds each decision, and each assumption you made instead of asking, once, with its reason.
- **Tasks** each fit one session. `Done when` is the cheapest check that would fail if the task were done wrong. Mark a task only a person can do with 👤, and never make up its result.
- The first task of a new plan writes two things into the agent instruction file: where the plan is, and that a session continuing the build uses groove to do the first unchecked task.

## Rebuild

The user will not say what is wrong with the old code, so find it before planning: read everything in the scope, run it, and look for bugs, weak structure, and parts nothing needs. Do not ask which to fix.

- A problem counts only if you reproduced it or can point to it in the code.
- Each problem becomes a requirement stating what is true once it is fixed, with its reason in Decisions.
- Decisions names the commit that holds the old code. If the old code is not committed, the first task is 👤: commit it.
- Every file in the scope belongs to a task that writes it anew.

## Check

Before finishing, run `bash <this skill's folder>/check-plan.sh` from the project root and fix whatever it reports.
