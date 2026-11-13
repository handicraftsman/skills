# Issue tracker: Home Repo

Issues for this repo live in the effort tracker of its Home Repo, not in this repo. This repo is one of that Home Repo's work repos.

## Finding the Home Repo's tracker

Work through these in order and use the first that answers:

1. **This session**: the session runs from a Home Repo (its AGENTS.md has a `## Config` section) whose `config.md` lists this repo, or the conversation names the Home Repo. Use that Home Repo.
2. **AGENTS.md**: the `### Issue tracker` line in this repo's `## Agent skills` block names the Home Repo and its remote. Use that Home Repo, cloning or pulling it as its own config describes.
3. **Ask the user** which Home Repo this repo belongs to.

Then read the Home Repo's `docs/agents/issue-tracker.md`. That file is the tracker's real workflow; this one only points at it. When the Home Repo has none and sits in a Guild Repo (a monorepo with `guild.md` at its root), use the guild tracker in the guild root's `docs/agents/issue-tracker.md`.

## When a skill says "publish to the issue tracker"

Follow the Home Repo's tracker workflow, run against the Home Repo rather than this repo: for example `gh issue create -R <owner>/<home-repo>`, or a file under the Home Repo's `.scratch/`. Tag the issue with this repo, and in a guild tracker with its Home Repo, as the tracker's `## Repo tags` section says. When the tracker has no such section, name this repo in the title instead, as `[<repo name>] <title>`.

## When a skill says "fetch the relevant ticket"

Fetch it from the Home Repo's tracker, the same way.
