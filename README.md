<h1 align="center">groove</h1>

<p align="center">A coding skill for Claude Code and Codex that writes only what the task needs.</p>

<p align="center">
  <img src="https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fphykn%2Fgroove%2Fmain%2F.claude-plugin%2Fplugin.json&query=%24.version&label=version&prefix=v" alt="version">
  <img src="https://img.shields.io/badge/Claude%20Code-plugin-orange" alt="Claude Code plugin">
  <img src="https://img.shields.io/badge/Codex-plugin-black" alt="Codex plugin">
</p>

- Plans in one file, and only when the work is too big to do and check in one go
- Names a caller before writing any new function, option, or file
- Cuts unused and one-use code before finishing, asked or not
- Keeps the test suite to a few seconds
- Reports with counted numbers: lines, new functions and files, tests and their time

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

Ask for the work. The skill starts on its own for requests such as these, in English or Korean:

```text
Fix this: the total comes out as 9:00
Plan a CLI that summarizes the CSV files in a folder
Refactor this folder
```

It stops once, after writing a plan. Say "build it" and it runs to the end.
