---
name: setup-home-repo
description: Set up or refresh a Home Repo: one repo holding an effort's shared skills, docs, config and issue tracker.
disable-model-invocation: true
---

# Setup Home Repo

A **Home Repo** is one git repo for an **effort**: one person's work, a team, several teams that work together closely, a sub-project under a product, a cross-product effort, or any mix of these. It holds the effort's shared skills, AGENTS.md and shared docs, and everyone on the effort runs agents from it. It is the root of the effort's repo tree; the **work repos** are the leaves, the repos where the code lives, each keeping its own AGENTS.md, issue tracker and history. It keeps facts about the effort, its people and its repos in two config files, `config.md` (committed) and `config.local.md` (gitignored). Read [CONFIG.md](CONFIG.md) before Step 2: it defines them, roles and rules, and holds the Config template the Home Repo's AGENTS.md carries verbatim.

A remote counts as one repo in any spelling: `git@host:o/r.git` equals `https://host/o/r`.

Settle every decision by calling the Skill tool with "grilling". Steps 1 to 4 are read-only. Leave `.env` and other secret files unread.

## Step 1: Detect the mode

Look for a `config.md` in the current directory or in a repo the user names.

- Found: mode is **refresh**. The Home Repo exists, perhaps freshly cloned on a new machine.
- Not found: mode is **create**.

Done when the mode is known.

## Step 2: Inventory the repos

Ask the user for the directories that hold their projects. Find every git repo under those directories, skipping dependency and cache folders (`node_modules`, `.cache`, `vendor`, `target` and similar). Use subagents for wide searches. Record each one's path, `origin` remote, visibility (public, private, or none) and last commit date.

In refresh mode, sort each repo against the shared config and the local config:

- **mapped**: in the shared config and the local config
- **unmapped**: in the shared config, on disk, missing from the local config
- **absent**: in the shared config, not on this machine
- **new**: on disk, not in the shared config

Decisions, with the answer to recommend:

- Which repos become work repos. Recommend those with commits in the last 6 months. Refresh mode asks only about **new** repos.
- The default projects directory, where new clones go. With one projects directory, it is that one. With several, always ask, and recommend the one holding most work repos. Refresh mode asks only when the local config marks no default.
- Which file the harness loads at session start: AGENTS.md, CLAUDE.md, or both. Recommend what the user's setup shows.
- Create mode: where the Home Repo lives, and whether it is new or existing. Recommend a new private repo beside the others.
- Create mode: who the effort spans (one person, a team, several teams, a sub-project under a product, a cross-product effort, or a mix), and the roles that follow. Recommend one role per kind of person who will run agents here; a one-person effort gets one role.
- The user's roles on this machine: any from the shared config, with customizations, plus any custom ones. Then which of them to assume by default. Recommend the role that fits the repos they commit to most as the one default. Refresh mode asks only when the local config names no role.
- Rules for each work repo, main or local override. Recommend none: record only the rules the user gives.
- The effort tracker, optional. Read [ISSUE-TRACKER.md](ISSUE-TRACKER.md) and settle its Choose step. Refresh mode asks only when the Home Repo has no `docs/agents/issue-tracker.md`.
- Refresh mode: whether to clone **absent** repos now. Recommend cloning on first need.

Done when every found repo is marked in or out and every decision for this mode is settled.

## Step 3: Inventory the shared material

In create mode, or when the user asks for it in refresh mode, read [SHARED-MATERIAL.md](SHARED-MATERIAL.md) and run its inventory. Otherwise go to Step 4.

## Step 4: Agree the plan

Call the Skill tool with "writing-for-agents" before drafting any AGENTS.md text. Then show the user:

1. The full proposed shared config, or the lines added to it in refresh mode.
2. The full proposed local config.
3. The Home Repo's AGENTS.md: a short intro, then the Config template from CONFIG.md verbatim. It holds no paths: those live only in the local config. In refresh mode, show only the changes to its `## Config` section.
4. The shared-material table, when Step 3 ran.
5. The effort tracker, when one was chosen.

Done when the user approves every item shown.

## Step 5: Apply the plan

1. Create the Home Repo if needed. In create mode, write AGENTS.md. In refresh mode, replace only its `## Config` section and keep everything else. If the harness loads a different file, write that file as one line pointing to AGENTS.md (for CLAUDE.md: `@AGENTS.md`).
2. Write the shared config and the local config. Add `config.local.md` to `.gitignore` and confirm with `git check-ignore config.local.md`.
3. Clone any repos the user chose to clone now, and record their paths in the local config.
4. Apply the shared-material table, when Step 3 ran.
5. When an effort tracker was chosen, run the Apply step of [ISSUE-TRACKER.md](ISSUE-TRACKER.md).
6. Commit in the Home Repo with the local config left out. The user pushes.

Done when every approved item is applied. Report each item's outcome, every branch created, and anything skipped with its reason. Tell the user they can run `/setup-work-repo` in the Home Repo for triage labels and the domain-doc layout, and to switch or add an effort tracker later.
