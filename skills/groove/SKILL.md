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

1. **Name the task.** If the user named a task from the Tasks table, that is the task. Swapping it for a smaller one, such as a refactor for a rebuild, needs the user's yes first. If the user named none, pick the row whose "Done when" should be true at the end. A dependency upgrade or a port is a refactor, and a security check is a review. Work that fits no row follows Work alone.
2. **Read.** Read a file once, and again only after it changes. Do not read outside the project unless the user points there, and use subagents only when the user asks.
3. **Ask or decide.** Ask only when no file has the answer and a wrong guess would be costly to undo: what the user intends, a fact outside the project, or an action that cannot be undone. Send every question in one message before you write anything, with the options in brief and a recommendation only if the user asks for one. Decide everything else yourself and report it as an assumption.
4. **Plan or work.** Three things get a plan before any code: a rebuild, a request to write or change a plan, and work too large to do and check within this session. For these, read `plan.md` and follow it. When the user says to build, do every unchecked task in order through Work, and check each task's box as soon as its "Done when" passes. Anything else goes straight to Work.

## Work

A task marked † changes no file. Before you write, delete, or review code, a README, or an instruction file, read `code.md`. Stay on the main branch unless the user asks for another.

1. **Write only what something uses.** Before writing a new function, option, or file, name what calls it, and leave out what nothing calls. Unasked, write only a regression test for a bug you fixed, a test for behavior the user requested, and validation of input from outside the program. The only documents to write are the plan, the README, and the instruction file. Behavior that changes loses its old form, along with the tests that covered only that form. When you rename something or change a config key, update every caller, test, document, instruction file, and config file that names it. A code change brings the README and the instruction file up to date in the same task; a missing one is created only in a new project or a planned build.
2. **Check each change** with the cheapest check that would fail if you were wrong, so one command's output comes before a test suite.
3. **Cut before finishing, asked or not.** Cutting reaches what this task wrote or changed, and the whole scope in a refactor or a rebuild. Delete what `code.md` rules out. From the plan, the README, the instruction file, and comments, delete each sentence that tells readers what they would do anyway or repeats another place. A feature whose benefit is unclear or negative is deleted in a refactor or a rebuild and only named in the report elsewhere. Say which files you will delete before deleting them. Never merge lines or shorten names to bring a count down.
4. **Run the whole suite once.** If it fails, go back to step 1. If tests you wrote push it past a few seconds, trim them. If it was slower than that before you began, run only the tests for what you changed and report that the full suite did not run. In a new project, and whenever a README command changed, run the README's commands as written.
5. **Clean up.** Delete temporary files, and any check that only compared before with after.

## Stop

These are the only places to stop and hand back to the user:

- after writing or changing a plan;
- when a check still fails after two fixes, saying where you are stuck;
- at a task only a person can do;
- before an action that cannot be undone, which includes removing behavior that the files show something outside the project depends on;
- after each file, when the user wants a refactor gone through file by file.

## Report

Report in a few lines, in the language the user wrote in even when the project uses another:

- Whether the task is done. Done means its check passed.
- The evidence. When the task changed code, that includes four numbers, each counted by command after the last edit, such as `git diff --numstat` and `wc -l` for new files: lines added and removed, new functions, new files, and tests with their time.
- What you assumed, and what you could not verify. Do not pass checking on to the user, and do not ask again about something already decided.
- What you noticed outside the scope, one line each, including anything that looks unneeded and worth deleting.

Do not begin or propose a next step.

## Tasks

| Task | Done when | Rules |
|---|---|---|
| Understand † | You can say what the code does | Rest each claim on code you ran or read, never on names, comments, or the README. Say what is a bug and what is intended |
| Review † | You can say what to fix | Stay in the scope the user set. Judge by `code.md`, including whether each function is needed and whether its name fits. Label each point a fact or a suggestion |
| Find a cause † | You can say why one symptom happens | Reproduce the symptom, and name a cause only once you have observed it |
| New project | Code runs where there was none | Start with the thinnest slice that runs end to end. Write a README and an instruction file |
| Rebuild | Every file in the scope is newly written and every requirement in the plan holds | Write each file from the idea, not by editing the old one, and leave none of the scope out. Read the old code from the commit the plan names. Carry over an old feature or rule only if you can name what breaks without it |
| Remove a feature | The behavior is gone | So are its callers, tests, dependencies, and documentation |
| Fix a bug | Behavior again matches what documents, tests, and callers expect | Find the cause before editing, and fix it where it arises, not where it shows. Leave one regression test that the unfixed code fails |
| Refactor | Kept behavior is unchanged and the shape is different | Follow Refactor in `code.md` |
| Optimize | Behavior is unchanged and a measurement is better | Record the baseline before the first edit, measure again the same way, and report both |
| Experiment | One candidate is chosen | Set the conditions and the rule for choosing before the first run, and give every candidate the same conditions |
| Long run | A fixed job has run to the end | Run one short trial, then the job in the background. If it is interrupted, resume from the last saved state |
| README | Someone new can run the project by following it | Include only commands you have run |
| Change a plan | The plan fits the new requirement | Follow `plan.md` |
