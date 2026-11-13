# Repo tags

**Repo tags** mark which Home Repo and which work repo an issue is about, in a tracker shared by several repos: a Home Repo's effort tracker, or a Guild Repo's guild tracker. Two kinds:

- `repo:<name>`: a work repo, named as in its Home Repo's `config.md`. An issue about several work repos carries one tag for each.
- `home:<name>`: a Home Repo, named as in `guild.md`. Used only in a guild tracker. An issue that spans Home Repos carries one tag for each.

An issue about the effort or guild as a whole carries no tag of that kind.

## Choose

Pick the mechanism the tracker offers, recommending the first listed for it:

- **GitHub**: labels named `home:<name>` and `repo:<name>`. When the team already plans in a GitHub Project, offer Project fields instead: a single-select field per kind (`gh project field-create`). A single-select field holds one value, so an issue about several repos also gets the labels.
- **GitLab**: labels named `home:<name>` and `repo:<name>`. Keep the single colon: a `::` label is scoped, and a scoped label allows one value per scope.
- **Forgejo**: labels named `home:<name>` and `repo:<name>`. Leave them non-exclusive, for the same reason.
- **Local markdown**: a `Home:` line and a `Repos:` line near the top of each issue file, beside `Status:`, each a comma-separated list of names.
- **Jira**: a Component per repo, since an issue can hold several. Labels when the project's components already mean something else.
- **Linear**: labels named `home:<name>` and `repo:<name>`, outside any label group, since a group allows one label per issue.
- **Other**: ask the user which field or label carries this, and record their answer.

Done when the mechanism and the exact tag spelling are chosen.

## Apply

1. Append this section to the tracker's `docs/agents/issue-tracker.md`, filled in:

   ```markdown
   ## Repo tags

   Every issue here carries tags naming what it is about: [mechanism and spelling, for example labels `home:<name>` and `repo:<name>`].
   Names come from `config.md` (work repos) and `guild.md` (Home Repos). An issue about several repos carries a tag for each; an issue about the whole [effort or guild] carries none of that kind.
   When a skill says "publish to the issue tracker", add the tags at creation: [the exact flag or field, for example `gh issue create --label repo:<name>`].
   To list one repo's issues: [the exact query, for example `gh issue list --label repo:<name>`].
   When a tag doesn't exist yet, create it first: [the exact command].
   ```

2. Create a tag now for each repo the config already names, when the mechanism needs tags created ahead of use: `gh label create`, `glab label create`, Forgejo's label settings or its `POST /repos/{owner}/{repo}/labels` API, a Jira component, or a Linear label.

Done when the section is written and every named repo has its tag, or the user is told which tags to create by hand.
