---
name: wizard
description: Generate an interactive wizard (bash and PowerShell 7) that walks a human through steps only they can perform. Use when provisioning infrastructure, setting up credentials or CI secrets, walking an unfamiliar third-party dashboard, or running a one-off migration or cutover. Don't invoke this for steps the agent can perform itself.
---

# Wizard

A **wizard** is a script that walks a human, step by step, through a manual procedure that's tedious to do by hand and tedious to re-explain to an AI every time. It opens each URL, says exactly what to click and copy, captures the values, writes them where they belong (`.env`, GitHub secrets), confirms at every stage, and shows how many stages are left. It might configure third-party services, run a one-off migration, or move the project from one state to another.

Every wizard is three files side by side: a markdown **source** (`<name>.wizard.md`, the procedure textified) and two **builds** from it, `<name>.sh` for bash and `<name>.ps1` for PowerShell 7. The source is the single source of truth: a change lands there first, then both builds are regenerated from it, so the two can never drift apart.

The delightful UX is already solved by the libraries in [template.sh](template.sh) and [template.ps1](template.ps1), which share helper names and behaviour: stage-by-stage progress, confirmation gates, cross-platform URL opening (including WSL), hidden secret entry, idempotent `.env` upserts, `gh secret`/`gh variable` writes, and a closing summary. **Your job is only to scope the procedure, write its source, and build its stages.** The library above each template's `STAGES` marker is identical in every wizard; that consistency is the point: never hand-edit it.

A wizard is ephemeral by default: built for one run, saved to a scratch or `scripts/` path, its three files deleted together when the job's done. Commit all three only when the user wants a repeatable setup path that should live in the repo.

## Process

### 1. Scope the procedure

Work out every manual step the human must take and every value that gets captured along the way. Read the repo first, don't ask cold:

- For setup: `.env`, `.env.example`, `.env.*`, `README`, `docker-compose*`, framework config, and `.github/workflows/*` (every `secrets.*` / `vars.*` reference is a value the wizard must produce).
- For a migration or transition: the current state, the target state, and the irreversible actions between them.

Then show the user the ordered list of stages and the values each produces, and confirm: they may add, drop, or reorder.

**Done when:** every stage is named in order, and for each captured value you know (a) where the human gets it, (b) where it's written (`.env`, a GitHub secret, both, or nowhere; some stages are pure actions), and (c) whether it's secret (hidden entry) or public.

### 2. Map each stage's journey

For each stage, write the precise path a human follows: which URL to open, what to do there, where a value is shown, which variable it fills: e.g. "Dashboard → Developers → API keys → Reveal test key → copy". Where you don't actually know the current UI or the exact command, say so and ask the user or check the docs: never invent steps that may not exist.

**Done when:** every stage traces to concrete instructions a stranger could follow.

### 3. Write the source

Copy [template.md](template.md) to `<name>.wizard.md` at the target path and persist it before any script exists. Replace the example with one `## Stage:` per step, in dependency order, and one bullet per library call, following the grammar in the template's comment.

Hold the bar the library sets: open the URL before asking for its value, use `ask_secret` for anything secret, `write_env` every persisted value, `set_secret` only the values CI actually needs, and `confirm` before any irreversible action. Each `stage` clears the screen so only the current step is visible: keep a stage to one focused task so nothing the human needs scrolls away.

**Done when:** every stage and value from steps 1 and 2 appears in the source, and the `Builds:` line names both script paths.

### 4. Build both scripts from the source

Copy `template.sh` to `<name>.sh` and `template.ps1` to `<name>.ps1`. In each, replace the example stage with a call-for-call translation of the source: every bullet becomes exactly one helper call, in the same order, with the same strings; a `confirm` bullet becomes an `if` around its indented bullets. Set `TOTAL_STAGES` (in the `.ps1`, `$script:TOTAL_STAGES`) to the number of `## Stage:` headings. Translate only what the source says: a fix the scripts need is a fix to the source, then a rebuild of both. Don't touch the library above either marker.

**Done when:** both scripts read as the same bullet list, line for line, and neither carries a call the source lacks.

### 5. Verify and hand off

- `bash -n <name>.sh`; run `shellcheck` if available. `chmod +x <name>.sh`.
- Parse-check the PowerShell build: `pwsh -NoProfile -Command '$e=$null; [void][Management.Automation.Language.Parser]::ParseFile("<name>.ps1",[ref]$null,[ref]$e); $e'` prints nothing when clean. Run `Invoke-ScriptAnalyzer -Severity Error` if it's installed.
- Don't run either end-to-end yourself: they open browsers and block on human input. Trace them statically instead, against the source: every value from step 1 is captured and lands where step 1 said, and every `set_secret` name exactly matches a `secrets.*` reference in CI.
- Tell the user how to run each build (`./<name>.sh`, or `pwsh <name>.ps1`). If it's a repeatable setup path, commit the source and both builds, and link the source from the README so the next person runs a script instead of asking an AI.
