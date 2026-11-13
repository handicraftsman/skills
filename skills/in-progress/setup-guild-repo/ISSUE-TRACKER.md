# Guild tracker

The one issue tracker for the whole guild: issues that span Home Repos, issues about the guild itself, and every issue from a Home Repo or work repo that keeps no tracker of its own. A Home Repo or work repo overrides it by writing its own `docs/agents/issue-tracker.md`. Adapted from the issue-tracker section of `setup-work-repo`, so the guild ends up configured the way the engineering skills expect.

## Choose

Offer these, recommending the first that fits:

- **GitHub**: issues live in the guild's GitHub Issues (uses the `gh` CLI). Recommend when the monorepo's remote is on GitHub.
- **GitLab**: issues live in the guild's GitLab Issues (uses the [`glab`](https://gitlab.com/gitlab-org/cli) CLI). Recommend when the remote is on `gitlab.com` or a self-hosted GitLab.
- **Forgejo**: issues live in the guild's issues on a Forgejo instance such as Codeberg (uses the [`fj`](https://codeberg.org/forgejo-contrib/forgejo-cli/wiki) CLI). Recommend when the remote is on `codeberg.org` or a self-hosted Forgejo or Gitea.
- **Local markdown**: issues live as files under `.scratch/<feature>/` at the guild root. Fits a guild with no remote.
- **Other** (Jira, Linear, etc.): ask the user to describe the workflow in one paragraph, and record it as freeform prose.

The tracker may live outside the monorepo, such as a separate repo kept only for issues: record its URL.

Then read [REPO-TAGS.md](REPO-TAGS.md) and settle its Choose step for this tracker, with `home:` and `repo:` tags.

Done when the tracker, its URL when it has one, and its repo tags are chosen.

## Apply

1. Write `docs/agents/issue-tracker.md` at the guild root from the matching seed template: [issue-tracker-github.md](issue-tracker-github.md), [issue-tracker-gitlab.md](issue-tracker-gitlab.md), [issue-tracker-forgejo.md](issue-tracker-forgejo.md) or [issue-tracker-local.md](issue-tracker-local.md). For **Other**, write it from scratch using the user's description. When the tracker lives outside the monorepo, name its repo in every command (for example `gh issue create -R <owner>/<repo>`). Leave the GitHub, GitLab and Forgejo templates' "PRs as a request surface" flag off, and don't raise it.
2. Run the Apply step of [REPO-TAGS.md](REPO-TAGS.md).
3. Add this block to the root AGENTS.md, or update it in place when an `## Agent skills` block already exists:

   ```markdown
   ## Agent skills

   ### Issue tracker

   [one-line summary of where guild issues are tracked]. See `docs/agents/issue-tracker.md`.
   ```

4. For GitHub, GitLab or Forgejo, run `gh repo view`, `glab repo view` or `fj repo view` against the tracker's repo.

Done when `docs/agents/issue-tracker.md` with its `## Repo tags` section and the `## Agent skills` block are written, and for GitHub, GitLab or Forgejo, the repo view prints the project. When it can't, the remote likely doesn't exist yet: keep the written files, and report that the tracker becomes reachable once the user creates it.
