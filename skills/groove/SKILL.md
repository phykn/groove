---
name: groove
description: >
  Use for every request to change or examine code in a project, however small
  or quick it looks, before reading or editing anything: a one-line bug fix
  (고쳐줘) counts. Does the work end to end with only what the task needs.
  Covers requests to understand a project, review code, find a root cause, start or
  rebuild a project, plan before coding, add, change, or remove a feature, fix
  a bug, refactor or clean up, make something faster, write tests, run an
  experiment or a long job, or update a README or agent instruction file (for
  example 만들어줘, 고쳐줘, 추가해줘, 바꿔줘, 지워줘, 리팩토링해줘, 정리해줘,
  리뷰해줘, 왜 안 돼, 계획 세워줘, 테스트 짜줘, 돌려줘; "build this", "fix
  this", "plan this app", "clean this up", "why does this fail"), even when
  the change looks small. Do not use to explain code, analyze data or results,
  write prompts, skills, or guides, or to commit, open a PR, or deploy.
---

# Groove

Write only what the task needs, cut before finishing, and prove the result with the cheapest check that could fail.

## Route

1. Read what the request touches. Read each file once, and again only after it changes.
2. Ask only when no file can tell you and a wrong guess is costly to undo: the user's intent, a fact outside the project, or an action that cannot be undone. Put every question in one message before you write anything, list the options briefly, and recommend one only when asked. Otherwise decide, and give the assumption in the report.
3. Can you do the work and check it in one go in this session?
   - Yes: go to Work.
   - No, or it is a rebuild, or the user asked for a plan: read `plan.md`, write the plan, and stop. When the user says to build, do the tasks in order through Work without stopping again.

A read-only task (marked † below) is read, verify, report. It changes no file.

## Work

Read `code.md` before you write or cut code.

1. **Write.** Before each new function, option, or file, name what calls it. If you cannot, do not write it. The only things you write unasked are a regression test for a bug you fixed, a test for the behavior requested, and validation of input from outside the program. When behavior changes, delete the old behavior and the tests that only covered it in the same change. When a name or config key changes, update every caller, test, document, instruction file, and config file that names it.
2. **Check what you changed.** Use the cheapest check that would fail if you were wrong. One command's output beats a test suite. On failure, fix and recheck. If the same check still fails after two fixes, stop and say where you are stuck.
3. **Cut.** Asked or not, compare everything this task wrote or changed against `code.md` and delete what it rules out. Before deleting a check or handler, find out why it exists. Never pack lines or shorten names to save lines.
4. **Run the whole suite once.** If it fails, go back to step 1. If tests you wrote push it past a few seconds, trim them. If the project's suite was already slow, do not trim it: run the tests for what you changed and say the full suite was not run. If the project has no tests, a command's output is the check. In a new project, or when a README command changed, run that command as written.
5. Delete temporary files and checks that only compared before and after.
6. **Report.**

## Report

In the user's language, in a few lines:

- Whether it is done. Say done only when the check passed.
- The evidence, and these numbers counted by command, not estimated: lines added and removed, new functions and files, tests and how long they take.
- Assumptions you made, and what you could not verify. State it; do not ask the user to check it for you, and do not ask again about anything already decided.
- Anything seen outside the scope in one line each, including what looks unneeded and should be deleted.

Do not start or propose the next step.

## Limits

- Do only what was asked. Cutting and the time limit apply to what this task wrote or changed, or to the scope the user gave for a refactor. Read outside the project only when the user points there.
- Stop on your own only after writing or changing a plan, when a check fails twice, at a task only a person can do, or before an action that cannot be undone. Deleting a promise that files show something outside the project relies on is such an action: ask first.
- Say which files you will delete before deleting them. Work on the main branch unless the user asks for another.
- Never run a command that sends, deploys, deletes outside the project, or touches a real account.
- The only documents you write are the plan, the README, and the agent instruction file. No notes or summaries. Use subagents only when the user asks.
- A mixed request is done one task at a time.

## Tasks

Find the request's row by what is true when the work ends, whatever the user calls it. Upgrading a dependency or porting is a refactor, CI or build config is adding a feature, a security check is a review.

| Task | True when done | Keep |
|---|---|---|
| Understand † | You say what the code does | Confirm each claim by running or reading the code. Names, comments, and the README are not evidence. Separate bugs from intent |
| Review † | You say what to fix | Stay in the scope the user set. Give file and line for each finding, and separate facts from suggestions. Judge each function's need and name |
| Find a cause † | You say why one symptom happens | Reproduce it, and confirm the cause by observation before stating it. If you could not confirm it, say so |
| New project | Code exists where there was none | Build the thinnest end-to-end slice first. Write a README and an instruction file |
| Rebuild | New code replaces old code that served only as evidence | Carry over the idea. Bring an old feature or rule only if you can name what breaks without it. Read the old code from the commit the plan names |
| Add a feature | Behavior that did not exist works | Build only what was asked |
| Change a feature | Existing behavior differs | Step 1's rule on old behavior |
| Remove a feature | Existing behavior is gone | Delete its callers, tests, dependencies, and documentation too |
| Fix a bug | Behavior matches the promise again | Find the cause first. Fix where the cause arises, not where the symptom shows. Leave one regression test that fails on the code before the fix |
| Refactor | Kept behavior is the same and the shape differs | Follow Refactor in `code.md`. Cut across the whole scope. Do not change a character of text you move, such as help and messages. Leave out of the comparison what you changed on purpose, such as fixed bugs and deleted features, and report it separately |
| Improve | The promise is the same and a measurement is better | Measure and write down the baseline before the first edit. Measure again the same way and report both |
| Write tests | The code is the same and tests are added | Follow Tests in `code.md` |
| Experiment | One candidate is chosen | Fix the conditions and the rule for choosing before the first run. Run every candidate under the same conditions. Report the choice and its evidence |
| Long run | A fixed job runs to the end | Run one short trial, then run it in the background. If it stops, resume from the last saved state |
| README | A user can run the project from it | List only commands you ran |
| Instruction file | An agent reads it (`CLAUDE.md`, `AGENTS.md`) | Match the code as it is now |
| Change a plan | The plan fits the new requirement | Change only what the requirement touches. Leave finished tasks alone. Stop after the change |

- The promise is the behavior that documents, tests, and callers expect.
- When code changes, update the README and instruction file in the same task. Create a missing one only for a new project or a planned build.
- When the user asks to go through a refactor file by file, stop after each file: clean the whole file first, then for each function say what it does in short steps, whether it is needed, and whether its name fits, and wait. After a folder, check it once more for comments, unused imports, long lines, and its tests.
- A feature whose benefit is unclear or negative is deleted only in a refactor or a rebuild. In any other task, say so in the report.
