# Import

Bringing separate git repos into the guild as directories.

## Choose

For each repo the user names, settle:

- **Source**: its remote URL or local path, and the branch to import. Recommend its default branch.
- **Directory**: where it lands. Recommend `homes/<name>/` for a Home Repo (its AGENTS.md has a `## Config` section) and `repos/<name>/` for a work repo, unless the monorepo already has a layout to follow.
- **History**: keep it with `git subtree add`, or a plain copy that starts fresh. Recommend keeping it.

Then check each one for what stops working in a subdirectory, and list it: CI config (`.github/`, `.gitlab-ci.yml`, `.forgejo/`), git hooks, root-relative paths in build files, and a `.gitignore` written for the repo root. Recommend moving CI config to the monorepo root and leaving the rest for the user.

Done when every repo has a source, branch, directory and history choice, and its subdirectory breakages are listed. Show them in Step 4 as a table: repo, source and branch, directory, history, breakages.

## Apply

1. With history: `git subtree add --prefix=<directory> <source> <branch>`, one repo at a time, on the guild's new branch. A plain copy: copy the working tree without its `.git` folder, then `git add <directory>`.
2. Move CI config to the root when the user chose to.
3. Leave the source repos and their remotes as they are. Archiving them is the user's call, once the guild is pushed.

Done when every chosen repo sits in its directory and is committed on the branch.
