# Shared material

Moving shared skills and docs into the Home Repo, so each lives in one place.

## Inventory

Across the work repos and the user-level skill folders (such as `~/.claude/skills` and `~/.agents/skills`), list every skill (a folder with a SKILL.md), every AGENTS.md and CLAUDE.md, and every doc written for agents: coding standards, glossaries, ADRs. Sort each item into exactly one bucket, with its destination:

- **shared**: true across repos. Moves to the Home Repo.
- **duplicate**: the same item in several places. Diff the copies; the newest moves to the Home Repo as the one copy.
- **repo-specific**: about one work repo's code, commands or domain. Stays in its repo.
- **installed**: from a published skills repo or plugin marketplace, or a symlink into one. Stays installed.

Done when every item sits in exactly one bucket. Show the result in Step 4 as a table: item, current location, bucket, destination.

## Apply

1. Copy each item that moves into the Home Repo, keeping skill folders whole.
2. In each work repo, on a new local branch, remove the copies that moved. Repo-specific material stays.
