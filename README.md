<h1 align="center">groove</h1>

<p align="center">One skill for all coding work in Claude Code and Codex: it writes the least that finishes the job and proves it.</p>

<p align="center">
  <img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fphykn%2Fgroove%2Fmain%2F.claude-plugin%2Fplugin.json&query=%24.version&label=version&prefix=v" alt="version">
  <img src="https://img.shields.io/badge/Claude%20Code-plugin-orange" alt="Claude Code plugin">
  <img src="https://img.shields.io/badge/Codex-plugin-black" alt="Codex plugin">
</p>

- Does the task you name: a rebuild is rewritten from scratch, not trimmed into a refactor
- Writes a function, option, or file only after naming what calls it
- Cuts unused and one-use code before finishing, without being asked
- Asks only what no file can answer, and stops only once, after a plan
- Reports counted numbers: lines, new functions, new files, tests and their time

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

Ask for the work in English or Korean. The skill starts on its own:

```text
Fix this: the total comes out as 9:00
Plan a CLI that summarizes the CSV files in a folder
Rebuild this project
```

Big work and rebuilds get a one-file plan first. Say "build it" and it runs to the end.
