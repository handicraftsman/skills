## What it does

`setup-home-repo` sets up a **Home Repo**: one git repo for an effort (one person, a team, several teams, a sub-project, a cross-product effort, or any mix) that holds the effort's shared skills, `AGENTS.md`, shared docs and config. [Agents](https://www.aihero.dev/ai-coding-dictionary/agent) run from it, and reach out to the **work repos** where the code lives.

It never hardcodes a path in prose. Facts about the effort go in a committed `config.md` (roles, repo remotes, per-repo rules), and facts about you go in a gitignored `config.local.md` (your roles, your local paths, your overrides). That split is what lets a whole team share one Home Repo across different machines.

## When to reach for it

You invoke this by typing `/setup-home-repo`, and the agent won't reach for it on its own.

| Situation | Reach for |
| --- | --- |
| An effort spans several repos, or a team works on it | `/setup-home-repo`, then [setup-work-repo](https://aihero.dev/skills-setup-work-repo) in each work repo |
| A teammate joins an existing Home Repo, or you move to a new machine | `/setup-home-repo` in join mode |
| One repo, one tiny project | skip it: [setup-work-repo](https://aihero.dev/skills-setup-work-repo) alone is enough |
| Several efforts live in one org monorepo | [setup-guild-repo](https://aihero.dev/skills-setup-guild-repo) first |

## Prerequisites

It writes into the Home Repo: `AGENTS.md` (with a `## Config` section), `config.md`, `config.local.md` and a `.gitignore` entry for the local file. With an effort tracker chosen, it also writes `docs/agents/issue-tracker.md`. It commits and leaves pushing to you.

## Create and join

The skill detects its **mode** from whether a `config.md` already exists.

- **Create**: inventories the git repos on your machine, settles which become work repos, the roles on the effort, the optional effort tracker, and which shared material (skills, docs) moves into the Home Repo.
- **Join**: reads the existing roles and repos, recommends the work repos your roles need, and records your choices locally. It asks only about repos it has not seen before.

Inside a Guild Repo, either mode also checks the guild's own files (`guild.md` and your `guild.local.md`) against this Home Repo, and offers to update them so the guild lists it and you.

Every decision runs through a [grilling](https://aihero.dev/skills-grilling) round, and nothing is written until you approve the plan.

## Common questions

**Do I still need `/setup-work-repo`?**

Yes, in each work repo. The Home Repo holds the effort's shared layer; triage labels and the domain-doc layout stay per work repo. You can also run `/setup-work-repo` in the Home Repo itself to give it labels or switch its tracker.

## It's working if

- Starting an agent session in the Home Repo, the agent knows where every work repo lives on your machine without being told.
- `git check-ignore config.local.md` succeeds, and no local path appears in a committed file.
- A teammate's join run asks them about roles and repos, not about the effort's structure.

## Where it fits

`setup-home-repo` is a **run-once setup** one level above [setup-work-repo](https://aihero.dev/skills-setup-work-repo): run it first, then set up each work repo. Inside an org monorepo, [setup-guild-repo](https://aihero.dev/skills-setup-guild-repo) sits above it. For which skill to reach for next, [metaskills-help](https://aihero.dev/skills-ask-matt) routes the whole set.
