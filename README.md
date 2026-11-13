<h1 align="center">groove</h1>

<p align="center">A coding skill for Claude Code and Codex that takes the whole job, writes only what it needs, and reports the check that passed.</p>

<p align="center">
  <img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fphykn%2Fgroove%2Fmain%2F.claude-plugin%2Fplugin.json&query=%24.version&label=version&prefix=v" alt="version">
  <img src="https://img.shields.io/badge/Claude%20Code-plugin-orange" alt="Claude Code plugin">
  <img src="https://img.shields.io/badge/Codex-plugin-black" alt="Codex plugin">
</p>

- Takes the task you name: a rebuild is written from scratch and fixes what was wrong with the old code
- Names the caller before writing any function, option, or file
- Cuts unused and one-use code before it finishes, asked or not
- Asks only what no file can answer, and stops only for a plan, a check that fails twice, a job for a person, or a step that cannot be undone
- Reports what it counted: lines changed, new functions, new files, and tests with their time

## Install

Claude Code:

```text
/plugin marketplace add phykn/groove
/plugin install groove@groove
```

Codex:

```text
codex plugin marketplace add phykn/groove
codex plugin add groove@groove
```

## Use

Ask in English or Korean, and the skill starts by itself:

```text
The total prints 9:00 but should be about 33 hours. Fix it
Review entries.py
Plan a CLI that summarizes the CSV files in a folder, then build it
전체 프로젝트 리빌딩 해줘
```

A rebuild, or work too large for one session, gets a one-file plan first. Say "build it" and every task runs to the end.
