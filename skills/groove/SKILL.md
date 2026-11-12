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

## Start

1. **Fix the task.** A task the user named from the Tasks table is the task. Never trade it for a smaller one on your own judgment: ask first. If the user named none, take the row whose "Done when" will hold at the end. Upgrading a dependency or porting is a refactor, CI or build config is a feature, and a security check is a review.
2. **Read** each file once, and again only after it changes. Stay inside the project unless the user points outside it.
3. **Decide or ask.** Ask only what no file can tell you and a wrong guess would be costly to undo: what the user intends, a fact outside the project, or an action that cannot be undone. Put every such question in one message before you write anything, with the options in brief and a recommendation only if asked. Decide the rest yourself and state it in the report as an assumption.
4. **Plan or work.** A rebuild, a request for a plan, and work you cannot do and check in one go in this session get a plan: read `plan.md`, write the plan, and stop. When the user then says to build, do every task through Work without stopping again. Everything else goes straight to Work.

## Work

A task marked † changes no file: read, confirm, and report. For any other task, read `code.md`, then:

1. **Write what has a caller.** Before each new function, option, or file, name what calls it. If you cannot, leave it out. The only things to write unasked are a regression test for a bug you fixed, a test for the behavior requested, and validation of input that comes from outside the program. A changed behavior takes its old form and the tests that covered only that form with it. A changed name or config key is changed in every caller, test, document, instruction file, and config file that names it.
2. **Check each change** with the cheapest check that would fail if you were wrong. One command's output comes before a test suite. When a check still fails after two fixes, stop and say where you are stuck.
3. **Cut before you finish**, asked or not. In what this task wrote or changed, delete what `code.md` rules out. In the plan, README, instruction file, and comments, delete each sentence that tells the reader what they would do anyway or repeats another place. Learn why a check or handler exists before deleting it. Do not pack lines or shorten names to lower a count.
4. **Run the whole suite once.** If it fails, return to step 1. If tests you wrote take it past a few seconds, trim them. If it was already slower than that, run only the tests for what you changed and report that the full suite was not run. In a new project, or when a README command changed, run that command as written.
5. **Clean up.** Delete temporary files and checks that only compared before and after.

## Report

A few lines in the language the user wrote in, whatever language the project uses:

- Whether it is done. Done means the check passed.
- The evidence, with all four numbers counted by command after the last edit, such as `git diff --numstat` and `wc -l` for new files: lines added and removed, new functions, new files, tests and their time.
- Assumptions, and what you could not verify. Never hand checking to the user or ask again about something decided.
- What you noticed outside the scope, one line each, including anything that looks unneeded and should be deleted.

Do not start or propose a next step.

## Limits

- Stop on your own only after writing or changing a plan, when a check fails twice, at a task only a person can do, and before an action that cannot be undone. Deleting a promise that the files show something outside the project relies on is such an action.
- Cutting and the time limit reach only what this task wrote or changed, or the scope the user set for a refactor.
- Say which files you will delete before deleting them. Work on the main branch unless the user asks for another.
- The only documents you write are the plan, the README, and the instruction file. Use subagents only when the user asks.

## Tasks

A task with no row follows Work alone.

| Task | Done when | Rules |
|---|---|---|
| Understand † | You can say what the code does | Back each claim by running or reading the code. Names, comments, and the README are not evidence. Tell bugs from intent |
| Review † | You can say what to fix | Keep to the scope the user set. Mark each point as fact or suggestion. Judge whether each function is needed and whether its name fits |
| Find a cause † | You can say why one symptom happens | Reproduce it. State a cause only after observing it |
| New project | Code exists where there was none | Build the thinnest slice that runs end to end first. Write a README and an instruction file |
| Rebuild | Every file in the scope is newly written and better than the old one | The user will not say what is wrong: read the old code from the commit the plan names and find its bugs, weak structure, and unneeded parts yourself. Decide the improvements without asking, and list each in the plan with its reason. Write every file from the idea, never by editing the old one, and leave no part of the scope out. Bring back an old feature or rule only when you can name what breaks without it |
| Remove a feature | The behavior is gone | Its callers, tests, dependencies, and documentation go with it |
| Fix a bug | Behavior matches the promise again | Find the cause before editing, and fix where it arises, not where it shows. Leave one regression test that fails on the code before the fix |
| Refactor | Kept behavior is the same and the shape differs | Follow Refactor in `code.md`. Cut across the whole scope. Text you move, such as help and messages, stays the same to the character. Report what you changed on purpose, such as fixed bugs and deleted features, apart from the comparison |
| Improve | The promise is the same and a measurement is better | Write down the baseline before the first edit. Measure again the same way and report both |
| Experiment | One candidate is chosen | Set the conditions and the rule for choosing before the first run. Give every candidate the same conditions |
| Long run | A fixed job has run to the end | Run one short trial, then run it in the background. If it stops, resume from the last saved state |
| README | A user can run the project from it | List only commands you ran |
| Change a plan | The plan fits the new requirement | Change only what the requirement touches. Leave finished tasks alone. Stop after the change |

- The promise is the behavior that documents, tests, and callers expect.
- A code change updates the README and the instruction file in the same task. Create a missing one only in a new project or a planned build.
- Delete a feature whose benefit is unclear or negative only in a refactor or a rebuild. Elsewhere, name it in the report.
- A refactor the user wants to go through file by file stops after each file: clean the whole file, say for each function what it does in short steps, whether it is needed, and whether its name fits, then wait. After a folder, check it once more for comments, unused imports, long lines, and its tests.
