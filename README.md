<h1 align="center">groove</h1>

<p align="center">A coding skill for Claude Code and Codex that writes only what the task needs.</p>

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

## Use

Ask for the work. The skill starts on its own for requests such as these, in English or Korean:

```text
고쳐줘: total이 9:00으로 나와
Plan a CLI that summarizes the CSV files in a folder
이 폴더 리팩토링해줘
```

It stops once, after writing a plan. Say "build it" and it runs to the end.
