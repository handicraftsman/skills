---
"mattpocock-skills": patch
---

Add `setup-guild-repo`, an in-progress user-invoked skill that sets up a Guild Repo: one monorepo holding an org's Home Repos and work repos as directories, with a committed `guild.md` (guild roles, the org tree with the Home Repos each node recommends, every Home Repo's directory) and a gitignored `guild.local.md` (the user's place in the org, roles and chosen Home Repos). The first run maps or imports repos (`git subtree add` keeps history) and sets up a guild issue tracker that Home Repos and work repos can override. Later runs walk the user down the org tree to their place, then recommend Home Repos for their role.
