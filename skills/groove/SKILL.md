---
name: groove
description: >
  Use for every request to change or examine code in a project, however small,
  before reading or editing anything: a one-line bug fix (고쳐줘) counts.
  Covers understanding a project, reviewing code, finding a root cause,
  starting or rebuilding a project, planning before coding, adding, changing,
  or removing a feature, fixing a bug, refactoring, making something faster,
  writing tests, running an experiment or a long job, and updating a README or
  agent instruction file (만들어줘, 고쳐줘, 추가해줘, 바꿔줘, 지워줘,
  리팩토링해줘, 정리해줘, 리뷰해줘, 왜 안 돼, 계획 세워줘, 테스트 짜줘,
  돌려줘; "build this", "fix this", "plan this app", "clean this up", "why
  does this fail"). Not for explaining code, analyzing data or results,
  writing prompts, skills, or guides, or committing, opening a PR, or
  deploying.
---

# Groove

## Route

1. Read each file once, and again only after it changes.
2. Decide for yourself and report the assumption. Ask only when no file can tell you and a wrong guess is costly to undo: the user's intent, a fact outside the project, or an action that cannot be undone. Then ask everything in one message before writing, with the options listed briefly and a recommendation only when asked.
3. Plan first when you cannot do and check the work in one go in this session, when it is a rebuild, or when the user asks for a plan: read `plan.md`, write the plan, and stop. When the user says to build, do every task through Work without stopping again. Anything else goes straight to Work.

## Work

Read `code.md` before writing or cutting code. A task marked † changes no file and skips steps 1 and 3 to 5.

1. **Write.** Name what calls each new function, option, or file before writing it; if nothing does, do not write it. Unasked, write only a regression test for a bug you fixed, a test for the requested behavior, and validation of input from outside the program. When behavior changes, delete the old behavior and the tests that only covered it. When a name or config key changes, update every caller, test, document, instruction file, and config file that names it.
2. **Check** what you changed with the cheapest check that would fail if you were wrong. One command's output beats a test suite. After two failed fixes, stop and say where you are stuck.
3. **Cut**, asked or not. From what this task wrote or changed, delete what `code.md` rules out. From the plan, README, instruction file, and comments, delete each sentence that says what the reader would do anyway or repeats another place. Find out why a check or handler exists before deleting it. Never pack lines or shorten names to save lines.
4. **Run the whole suite once.** On failure, go back to step 1. If tests you wrote push it past a few seconds, trim them. If it was already slow, run only the tests for what you changed and say the full suite was not run. In a new project, or when a README command changed, run that command as written.
5. Delete temporary files and checks that only compared before and after.

## Report

A few lines, in the language of the user's request even when the project is in another:

- Done or not. It is done only when the check passed.
- The evidence, and all four numbers, counted by command after the last edit, such as `git diff --numstat` and `wc -l` for new files: lines added and removed, new functions, new files, tests and their time.
- Assumptions, and what you could not verify. Do not ask the user to check it, and do not ask again about anything decided.
- What you saw outside the scope, one line each, including what looks unneeded and should be deleted.

Do not start or propose the next step.

## Limits

- Cutting and the time limit cover only what this task wrote or changed, or the scope the user gave for a refactor. Read outside the project only when the user points there.
- Stop on your own only after writing or changing a plan, when a check fails twice, at a task only a person can do, or before an action that cannot be undone. Deleting a promise that files show something outside the project relies on is such an action: ask first.
- Name the files you will delete before deleting them. Stay on the main branch unless the user asks for another.
- Write no documents except the plan, the README, and the instruction file. Use subagents only when the user asks.

## Tasks

Pick the row by what is true when the work ends, whatever the user calls it: upgrading a dependency or porting is a refactor, CI or build config is a feature, a security check is a review. A task with no row follows Work alone.

| Task | True when done | Keep |
|---|---|---|
| Understand † | You say what the code does | Confirm each claim by running or reading the code. Names, comments, and the README are not evidence. Separate bugs from intent |
| Review † | You say what to fix | Stay in the scope the user set. Separate facts from suggestions. Judge each function's need and name |
| Find a cause † | You say why one symptom happens | Reproduce it, and confirm the cause by observation before stating it |
| New project | Code exists where there was none | Build the thinnest end-to-end slice first. Write a README and an instruction file |
| Rebuild | New code replaces old code used only as evidence | Carry over the idea. Bring an old feature or rule only if you can name what breaks without it. Read the old code from the commit the plan names |
| Remove a feature | Existing behavior is gone | Delete its callers, tests, dependencies, and documentation too |
| Fix a bug | Behavior matches the promise again | Find the cause first, and fix where it arises, not where the symptom shows. Leave one regression test that fails on the code before the fix |
| Refactor | Kept behavior is the same and the shape differs | Follow Refactor in `code.md`. Cut across the whole scope. Do not change a character of text you move, such as help and messages. Report what you changed on purpose, such as fixed bugs and deleted features, apart from the comparison |
| Improve | The promise is the same and a measurement is better | Measure and write down the baseline before the first edit. Measure again the same way and report both |
| Experiment | One candidate is chosen | Fix the conditions and the rule for choosing before the first run. Run every candidate under the same conditions |
| Long run | A fixed job runs to the end | Run one short trial, then run it in the background. If it stops, resume from the last saved state |
| README | A user can run the project from it | List only commands you ran |
| Change a plan | The plan fits the new requirement | Change only what the requirement touches. Leave finished tasks alone. Stop after the change |

- The promise is the behavior that documents, tests, and callers expect.
- When code changes, update the README and instruction file in the same task. Create a missing one only for a new project or a planned build.
- Delete a feature whose benefit is unclear or negative only in a refactor or a rebuild. In other tasks, say so in the report.
- When the user asks to go through a refactor file by file, stop after each file: clean the whole file, then for each function say what it does in short steps, whether it is needed, and whether its name fits, and wait. After a folder, check it once more for comments, unused imports, long lines, and its tests.
