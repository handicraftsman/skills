---
name: setup-guild-repo
description: Set up a Guild Repo, a monorepo holding an org's Home Repos and work repos as directories, or join one by finding your place in its org and choosing your Home Repos.
disable-model-invocation: true
---

# Setup Guild Repo

A **Guild Repo** is one monorepo for a **guild**: an org of any shape, from a single team to a deep tree of divisions and teams. It holds the guild's **Home Repos** and **work repos** as plain directories in one git history, not as separate git repos. Each nested Home Repo keeps its own AGENTS.md and config files, as `/setup-home-repo` writes them. The guild adds a layer above them: the org tree, which Home Repos each part of the org works in, and a guild-wide issue tracker that a Home Repo or work repo can override.

The guild keeps its facts in two files at the monorepo root, `guild.md` (committed) and `guild.local.md` (gitignored). Read [GUILD-CONFIG.md](GUILD-CONFIG.md) before Step 2: it defines both files and holds the Guild template the root AGENTS.md carries verbatim.

Settle every decision by calling the Skill tool with "grilling". Steps 1 to 4 are read-only. Leave `.env` and other secret files unread.

## Step 1: Detect the mode

Look for `guild.md` at the git root of the current directory, or of a repo the user names.

- Found: mode is **join**. The guild exists; this run records where the user fits in it. When the user also asks to change the guild itself (the org tree, the Home Repos list, the tracker), take those decisions from create mode too.
- Not found: mode is **create**.

Done when the mode is known.

## Step 2: Shape the guild (create mode)

Map the monorepo: its top-level directories, every directory holding an AGENTS.md with a `## Config` section (an existing Home Repo), and every directory that looks like a project root (its own AGENTS.md, package manifest, or build file). Use subagents for a wide tree.

Decisions, with the answer to recommend:

- The org tree: its nodes, their nesting, and one line on what each covers. A one-team guild is one node. Recommend the structure the user describes, and nothing deeper.
- The guild's roles, the kinds of people across the org (SWE, SRE, PM, and so on). Recommend none when the org has one kind of person.
- The Home Repos: each one's name, the effort it holds, and its directory. Recommend existing Home Repo directories as they are, and `homes/<name>/` for new ones.
- Which Home Repos each org node recommends, and for which roles. A node's recommendation also reaches every node below it. Recommend each Home Repo at the lowest node whose whole subtree works in it.
- Separate git repos to bring into the guild as directories: existing Home Repos and work repos. Read [IMPORT.md](IMPORT.md) and settle its Choose step. Recommend none when the user names none.
- The guild tracker, the one issue tracker for the whole guild. Read [ISSUE-TRACKER.md](ISSUE-TRACKER.md) and settle its Choose step.
- Which file the harness loads at session start: AGENTS.md, CLAUDE.md, or both. Recommend what the user's setup shows.

Done when every org node, Home Repo and import has a settled answer, and the tracker is chosen. Then go to Step 3: the user creating the guild also needs a place in it.

## Step 3: Find the user's place (both modes)

Read `guild.md` `## Org`, `## Roles` and `## Home Repos`, or the drafts from Step 2. When `guild.local.md` exists, recommend its current answers.

1. **Place**: walk the org tree from the root. At each level, show the child nodes with their one-line descriptions, and ask which one the user belongs to, or whether they sit at the current node. Descend until they stop or reach a leaf. When a level has too many children to list (past about 15), ask for their team's name and search the node names and descriptions instead. A one-node org skips this. A user can hold several places, such as one team plus a guild-wide working group.
2. **Roles**: the user's roles from `guild.md` `## Roles`, plus any custom ones, and which to assume by default. Skip when the guild defines no roles.
3. **Home Repos**: recommend the Home Repos named at each of the user's places and at every node above them, keeping those whose role filter matches the user's roles. Show each with its one-line description. The user picks any of them and adds any other Home Repo in the guild, then marks the defaults: the ones to start a session in.

Done when the user confirms a place, roles (when the guild has any), and at least one default Home Repo.

## Step 4: Agree the plan

Call the Skill tool with "writing-for-agents" before drafting any AGENTS.md text. Then show the user:

1. Create mode: the full proposed `guild.md`, the root AGENTS.md (a short intro, then the Guild template from GUILD-CONFIG.md verbatim), the import table, the directories to create, and the guild tracker with its repo tags.
2. Join mode: the changes to `guild.md`, when the user asked for any.
3. The full proposed `guild.local.md`.

Done when the user approves every item shown.

## Step 5: Apply the plan

Work on a new local branch.

1. Create mode: write the root AGENTS.md, or replace only its `## Guild` section when one exists. If the harness loads a different file, write that file as one line pointing to AGENTS.md (for CLAUDE.md: `@AGENTS.md`).
2. Write `guild.md` and `guild.local.md`. Add `guild.local.md` and `config.local.md` to the root `.gitignore`, which covers every nested Home Repo, and confirm both with `git check-ignore`.
3. Run the Apply step of [IMPORT.md](IMPORT.md), when imports were chosen.
4. Create the directory of each new Home Repo.
5. Run the Apply step of [ISSUE-TRACKER.md](ISSUE-TRACKER.md), when the tracker was chosen in this run.
6. Commit with `guild.local.md` left out. The user pushes.

Done when every approved item is applied. Report each item's outcome, the branch, and anything skipped with its reason. Then list each Home Repo directory that has no `config.md` yet, or was imported, and each of the user's default Home Repos that has no `config.local.md`: tell the user to run `/setup-home-repo` inside each one. There it writes or converts the Home Repo's config for life inside the guild, or records the user's roles and work repos.
