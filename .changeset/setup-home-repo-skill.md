---
"mattpocock-skills": patch
---

Add `setup-home-repo`, an in-progress user-invoked skill that sets up or refreshes a Home Repo: one repo for the shared skills, AGENTS.md and docs of an effort (one person, one or more teams, a sub-project under a product, a cross-product effort, or any mix), which keeps facts about the effort and its repos in two config files, a committed `config.md` (roles, repo remotes and main per-repo rules) and a gitignored `config.local.md` (the user's roles, chosen or custom, with the default ones marked, local paths and rule overrides), instead of hardcoding paths in prose. It can also set up an optional issue tracker for the effort as a whole.
