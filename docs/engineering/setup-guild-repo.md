## What it does

`setup-guild-repo` sets up a **Guild Repo**: one monorepo for an org of any shape, from a single team to a deep tree of divisions and teams. It holds the org's **Home Repos** and work repos as plain directories in one git history, not as separate git repos.

It adds a layer above the Home Repos rather than replacing them. Each Home Repo directory keeps its own `AGENTS.md` and config, as [setup-home-repo](https://aihero.dev/skills-setup-home-repo) writes them. The guild records the org tree, which Home Repos each part of the org works in, and one guild-wide issue tracker that a Home Repo or work repo can override.

## When to reach for it

Type `/setup-guild-repo`, or the agent reaches for it automatically when a task fits, such as organising several teams in one monorepo or finding your place in a repo with `guild.md` at its root.

| Situation | Reach for |
| --- | --- |
| An org keeps several efforts in one monorepo | `/setup-guild-repo`, then `/setup-home-repo` inside each Home Repo directory |
| A newcomer joins the org | `/setup-guild-repo` in join mode, to find their place and Home Repos |
| One effort across separate repos | [setup-home-repo](https://aihero.dev/skills-setup-home-repo) alone |

## Prerequisites

It writes at the monorepo root: `AGENTS.md` (with a `## Guild` section), a committed `guild.md`, a gitignored `guild.local.md`, and `.gitignore` entries covering every nested `config.local.md`. It can also import separate git repos as directories and set up the guild tracker. It works on a new local branch, commits, and leaves pushing to you.

## The org tree

The leading idea is the **org tree**. Each node recommends the Home Repos its people work in, and a recommendation reaches every node below it. Joining is a walk down that tree: at each level you pick the child node you belong to, and the skill recommends the Home Repos named at your place and everywhere above it, filtered by your roles.

## It's working if

- A newcomer's join run ends with a place in the org, their roles, and at least one default Home Repo, without anyone explaining the org to them.
- The skill's closing report lists every Home Repo directory that still needs `/setup-home-repo`.
- `guild.local.md` and every `config.local.md` stay out of git.

## Where it fits

`setup-guild-repo` is the outermost **run-once setup**: guild, then [setup-home-repo](https://aihero.dev/skills-setup-home-repo) per Home Repo, then [setup-work-repo](https://aihero.dev/skills-setup-work-repo) per work repo. For which skill to reach for next, [metaskills-help](https://aihero.dev/skills-ask-matt) routes the whole set.
