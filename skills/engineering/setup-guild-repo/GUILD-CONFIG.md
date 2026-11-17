# Guild config

The Guild Repo's two config files, at the monorepo root, each a Markdown file of sections:

- the **guild config**, `guild.md` (committed): true for everyone. `## Roles` describes each guild-wide role. `## Org` is the org tree, with the Home Repos each node recommends. `## Home Repos` lists every Home Repo in the guild and its directory.
- the **guild local config**, `guild.local.md` (gitignored): true for the user on this machine. `## Place` names their org nodes. `## Roles` lists their roles and marks the defaults. `## Home Repos` lists the Home Repos they work in and marks the ones to start in.

A **node** is one part of the org: the guild itself, a division, a team, a working group. Nodes nest. A node's recommended Home Repos reach every node below it, so the guild root's recommendations reach everyone.

`guild.local.md` stores Home Repo names, not directories: the name joins it to `guild.md`, which holds each directory once.

Each nested Home Repo's own `config.md` and `config.local.md` hold its roles, work repos and rules, as `/setup-home-repo` writes them. The guild files hold nothing about work repos.

## Guild template

```markdown
## Guild

This repo is a Guild Repo: one monorepo holding the guild's Home Repos and work repos as directories, in one git history.
Facts about the guild live in two Markdown files at the root. Read both at the start of a session.
`guild.md` (committed) holds what is true for everyone; `guild.local.md` (gitignored) holds my own choices.

### Org

- `guild.md` `## Roles`, one line per guild-wide role: `- **<role>**: <what this role does across the guild>`
- `guild.md` `## Org`, the org tree as nested bullets, one node per line:
  `- **<node>** (<what it covers>). Homes: <name>, <name> (<role>)`
  A node recommends its Home Repos to everyone at that node and below. A `(<role>)` after a name limits it to that role.
  Past about 50 nodes, a subtree moves to `org/<node>.md`, and its line reads `- **<node>** (<what it covers>): see org/<node>.md`.
- `guild.md` `## Home Repos`, one line per Home Repo: `- **<name>** (<what effort it holds>): <directory from the guild root>`
- `guild.local.md` `## Place`, my nodes, each as a path from the root: `- <node> / <node> / <node>`
- `guild.local.md` `## Roles`, my guild roles: `- <role>`, or `- <role> (custom): <full description>`, with ` (default)` after each to assume unless I say otherwise.
- `guild.local.md` `## Home Repos`, the Home Repos I work in: `- <name>`, with ` (default)` after each to start in.

### Home Repos

Start each task in my default Home Repos. Read the Home Repo's AGENTS.md, `config.md` and `config.local.md`, and work as its `## Config` section says.
When I name another Home Repo, or the task clearly belongs to one, work there too and say so. Leave `guild.local.md` as it is: it records my usual choice, not a limit.
If a Home Repo I work in has no `config.local.md`, take the roles from its `config.md` that best match my guild roles, say which, and suggest I run `/setup-home-repo` there.
If `guild.local.md` is missing, ask me to run `/setup-guild-repo`.

Work repos are directories, not separate git repos: one history, one remote, and a branch or commit may touch several of them.

### Issues

The nearest tracker wins: a work repo's own `docs/agents/issue-tracker.md`, then its Home Repo's, then the guild tracker in this repo's `docs/agents/issue-tracker.md`.
An issue that spans Home Repos, or is about the guild itself, goes to the guild tracker.
Tag each issue in a Home Repo's tracker or the guild tracker with its repo tags, as that tracker's `## Repo tags` section says.
```
