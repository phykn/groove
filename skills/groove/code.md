# Code

The user's request and the project's existing conventions come before this page. In a new project, apply it as written.

## Deletion

- Lean toward deleting. Delete what nothing uses: functions, options, imports, and code kept only for tests, and change the tests to fit the code. Inline a constant, variable, or function used in one place into that place, except a step split out of a long method and the function an entry point calls.

  ```python
  # not: MAX_RETRY = 3 used once, or def is_valid(x): return x > 0 called once
  for attempt in range(3):
      if value > 0:
  ```

- Avoid unnecessary keyword-only separators, wrappers, helper classes, and aliases. Keep them only when they prevent real ambiguity, duplication, or misuse.
- Check each value once. Do not recheck what config loading or input reading already validated, or a condition that always holds where it is checked.
- Delete options always given the same value, unreachable branches, and code with no effect, such as initialization that loaded weights overwrite or dropout in a module that always runs in eval mode.
- When the last use of a dependency goes, remove it from the dependency list too.

## Structure

- An entry point file reads arguments and calls one function. Keep the main path linear and visible in that function.

  ```python
  # run_train.py
  if __name__ == "__main__":
      parser = argparse.ArgumentParser()
      parser.add_argument("--config", default="config.yaml")
      run_train(parser.parse_args().config)

  # src/run.py
  def run_train(config_path):
      cfg = parse_config(config_path)
      train, val = build_loaders(cfg)
      model = build_model(cfg)
      fit(model, train, val, cfg)
  ```

- Divide folders and files along clear boundaries, so each one's role is evident from where it sits. Move code the main program does not use, such as one-off tools, into a separate scripts folder.
- Make broad coordinated changes when the structural benefit justifies them.
- Keep behavior, including one-use behavior, with the data, class, or lifecycle that owns it. Avoid routing unrelated concerns through shared config, metadata, or distant utilities.
- Keep functions and methods in the order a reader encounters them during execution, with similar ones next to each other.
- Group many functions that share state into a class, and split a long method into one method per step.
- When the project has settings, keep every default in one config file. Overlay user settings on it and validate the result strictly, once.
- Return what callers need in one result, such as `{"logits", "probs", "classes"}`, so no caller recomputes it.

## Names, Types, And Comments

- Where the language makes type annotations optional, write no type hints or type aliases.
- Comment rarely: only a why the code cannot show, in one line. Write no file-top docstrings or comments that restate the code, and leave no commented-out code or placeholder TODOs. When refactoring, also delete existing comments and docstrings that restate the code; if code reads a docstring, such as `__doc__` for CLI help, move its text to that use.
- Start function names with a verb that says what the function does. Match paired names, such as `write_split_csv` and `read_split_csv`, and give a family one prefix, such as `apply_gamma` and `apply_blur`.
- Keep local variable names short and conventional, such as `cfg`, `vol`, `idx`, and `img`. Keep descriptive names for public APIs and domain concepts.
- Use singular and plural names consistently, such as `prob` for one value and `probs` for a collection.

## Fixes And Error Handling

- When generated output is wrong, fix the source data, prompt, or contract first, before adding a layer that corrects the output.
- Add exception handling only for a concrete failure, contract, cleanup, or recovery path.

## Refactor

- Also fix potential bugs supported by concrete code paths or evidence in the affected scope.
- Build as if from scratch: delete legacy compatibility code, such as old formats, format versions, shims, and stale aliases, together with its tests.
- Compare outputs numerically before and after. If float32 results differ, recompare in float64 to tell rounding from a real change.

## Tests

- Keep the whole suite to a few seconds. Replace heavy models with tiny stand-ins that run the same flow, and call a script's `main()` in process instead of through a subprocess.
- Keep a real heavy-model test only for what a stand-in cannot show, such as loading pretrained keys or one real training step with save and restore.
- Write one test file per source module, with shared helpers in one file.
- Prefer one strong test to several weak ones. Delete tests that overlap others or no longer guard anything.
- Keep check and timing runs minimal: one warmup and one or two measured runs, or the fewest steps that show the failure. Stop checking once the evidence is enough for what you claim. Say the expected duration before a run longer than a few minutes.

## Machine Learning

Apply only in a machine learning project.

- Set defaults to the conditions the pretrained model was trained under, such as its input size.
- Keep the key names of pretrained weights, and the module names that hold those keys.
- Give each augmentation its own probability and its own strength.
- End learning-rate schedules exactly at the last training step.
- Do not add seed fixing or other reproducibility machinery to training code. Fix a data split by saving it to a file, not by a seed.

## README And Files

- Write a README like a GitHub front page: a centered title, a one-line summary, badges, and a short feature list, then install and usage steps in the order users run them.
- Keep it short: command blocks with a line or two each. Leave out project layout, detailed settings tables, collapsible blocks, and any explanation a user does not need to run the project, and leave values to the config file.
- Do not reference local files that readers do not have.
- End with numbered references in paper style: authors, title, venue, and year, with code or data links.
- Divide a dataset README into layout, a class table, and how to rebuild the data.
- Keep the agent instruction file in step with the current code, as a short list per module.
- Prefer short noun filenames without redundant type prefixes or names that look like duplicates.
- Keep planning documents and the `docs/` folder out of the git remote.
