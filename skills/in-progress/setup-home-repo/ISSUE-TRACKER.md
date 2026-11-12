# Effort tracker

Where issues about the effort as a whole live: work that spans repos, or is about the effort itself. Issues about one work repo stay in that work repo's own tracker. Adapted from the issue-tracker section of `setup-work-repo`, so the Home Repo ends up configured the same way the engineering skills expect.

## Choose

Offer these, recommending the first that fits:

- **GitHub**: issues live in the Home Repo's GitHub Issues (uses the `gh` CLI). Recommend when the Home Repo's remote is, or will be, on GitHub.
- **GitLab**: issues live in the Home Repo's GitLab Issues (uses the [`glab`](https://gitlab.com/gitlab-org/cli) CLI). Recommend when the remote is on `gitlab.com` or a self-hosted GitLab.
- **Forgejo**: issues live in the Home Repo's issues on a Forgejo instance such as Codeberg (uses the [`fj`](https://codeberg.org/forgejo-contrib/forgejo-cli/wiki) CLI). Recommend when the remote is on `codeberg.org` or a self-hosted Forgejo or Gitea.
- **Local markdown**: issues live as files under `.scratch/<feature>/` in the Home Repo. Fits a one-person effort or a Home Repo with no remote.
- **Other** (Jira, Linear, etc.): ask the user to describe the workflow in one paragraph, and record it as freeform prose.
- **None**: no effort tracker. Recommend for a one-person effort.

For GitHub, GitLab or Forgejo, also settle the Home Repo's remote URL, since the tracker lives there.

Done when the tracker is chosen, and for GitHub, GitLab or Forgejo, the remote URL is known.

## Apply

1. Write `docs/agents/issue-tracker.md` in the Home Repo from the matching seed template: [issue-tracker-github.md](issue-tracker-github.md), [issue-tracker-gitlab.md](issue-tracker-gitlab.md), [issue-tracker-forgejo.md](issue-tracker-forgejo.md) or [issue-tracker-local.md](issue-tracker-local.md). For **Other**, write it from scratch using the user's description. Leave the GitHub, GitLab and Forgejo templates' "PRs as a request surface" flag off, and don't raise it.
2. Add this block to the Home Repo's AGENTS.md, or update it in place when an `## Agent skills` block already exists:

   ```markdown
   ## Agent skills

   ### Issue tracker

   [one-line summary of where effort issues are tracked]. See `docs/agents/issue-tracker.md`.
   ```

   The block goes in AGENTS.md even when the harness loads CLAUDE.md, because in a Home Repo, CLAUDE.md is only a one-line pointer to AGENTS.md.
3. For GitHub, GitLab or Forgejo, wire up the remote when no `git remote` points at that host: `git remote add origin <url>`. Then run `gh repo view`, `glab repo view` or `fj repo view` from the Home Repo.

Done when `docs/agents/issue-tracker.md` and the `## Agent skills` block are written, and for GitHub, GitLab or Forgejo, the repo view prints the project. When it can't, the remote repo likely doesn't exist yet: keep the written files, and report that the tracker becomes reachable once the user creates and pushes the remote.
