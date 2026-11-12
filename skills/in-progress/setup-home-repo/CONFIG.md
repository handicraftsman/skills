# Config

The Home Repo's two config files, each a Markdown file of sections:

- the **shared config**, `config.md` (committed): true on every machine. Its `## Roles` section describes each role people take in the effort. Its `## Repos` section lists each repo's name, purpose, remote, hint and main rules.
- the **local config**, `config.local.md` (gitignored): true on this machine only. Its `## Roles` section lists the user's roles, from the shared config or custom, and marks which ones to assume by default. Its `## Repos` section lists the projects directories, which one new clones go into, each repo's path, and rule overrides.

A **role** is a kind of person working on the effort, such as an SWE, a DevOps engineer, or a collaborator from another team. A **rule** is a line under a repo that gives context: who owns it, what each role is responsible for there, what to check before changing it. A rule can apply to every role or to one.

Other sections, such as facts about the effort or the person on this machine, go in whichever file matches where they are true.

## Config template

```markdown
## Config

Facts about this effort, its people and its repos live in two Markdown files. Read both at the start of a session.
`config.md` (committed) holds what is true on every machine; `config.local.md` (gitignored) holds what is true on this one.
When I tell you a lasting fact, record it in the matching file, under a fitting `##` section.

### Roles

- `config.md` `## Roles`, one line per role on this effort:
  `- **<role>**: <what this role does here, what it owns, what it leaves to others>`
- `config.local.md` (gitignored) `## Roles`, my roles on this machine, one line each:
  `- <role>` naming one from `config.md`, with indented lines that customize it for me; or `- <role> (custom): <full description>`.
  Add ` (default)` after each role to assume unless I say otherwise.

Assume my default roles. Take on another of my roles only when I name it or the task clearly needs it, and say so.
Use the roles in play to judge what is mine to change, what needs someone else, and how much to explain.

### Repos

The effort's work repos are listed in each file's `## Repos` section. The repo name joins them.

- `config.md` (committed), one line per repo with an online source:
  `- **<name>** (<what it is>): <remote URL>. <optional hint>`
  Past about 20 repos, the section holds one line per area instead, `- <Area> (<what it covers>): see repos/<area>.md`, and each area file lists its repos.
- `config.local.md` (gitignored), where each repo lives on this machine:
  first one line per projects directory, `Projects: <absolute path>`, with ` (default)` after the one new clones go into; then `- <name>: <absolute path>`.
  A repo with no remote appears only here, as `- <name>: <absolute path> (local only)`.
  It sets a clone protocol only when I ask for one: `Clone over: ssh` or `Clone over: https` for every repo, or ` (clone over ssh)` or ` (clone over https)` after one repo's line. A repo's own setting wins. With neither, clone the remote exactly as `config.md` spells it.

A repo line in either file can carry rules as indented bullets: context, ownership, responsibilities, what to check before changing it.
`  - <rule>` applies to every role; `  - (<role>) <rule>` applies only to that role.
Rules in `config.md` are the main ones. Rules under the repo's line in `config.local.md` are my overrides: where the two conflict, the local rule wins.

To open a repo, find its line in `config.md`, follow its hint, and read its rules for the roles in play, then take its path from `config.local.md`.
If the path is missing or the folder is gone, clone the remote into the default projects directory and record the path.
If `config.local.md` is missing or marks no default, ask me for my projects directories and, when there are several, which one is the default. Never guess one.

Whenever you clone, create or find an unlisted repo, add it to `config.local.md`, and to `config.md` when it has a remote.

### Issues

An issue about one work repo goes to that work repo's own tracker, as its AGENTS.md or `docs/agents/issue-tracker.md` says.
An issue that spans repos, or is about the effort itself, goes to the effort tracker named in this file's `## Agent skills` section. With no effort tracker, ask me where.
```
