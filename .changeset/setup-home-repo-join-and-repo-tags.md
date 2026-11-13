---
"mattpocock-skills": patch
---

`setup-home-repo` now runs in join mode when the Home Repo exists: it helps the user choose roles, then recommends work repos from each role's new `Repos:` list, and marks the chosen ones ` (default)` in `config.local.md`. It also works inside a Guild Repo, where work repos are directories and the guild tracker is the default. Effort and guild trackers now carry repo tags (`repo:<name>`, plus `home:<name>` in a guild) as labels, Project fields, components or frontmatter lines, depending on the tracker, and `setup-work-repo`'s Home Repo tracker uses them in place of the `[<repo name>]` title prefix.
