# Issue tracker: Forgejo

Issues and specs for this repo live as issues on a Forgejo instance, such as Codeberg. Use the [`fj`](https://codeberg.org/forgejo-contrib/forgejo-cli/wiki) CLI (forgejo-cli) for all operations.

## Conventions

- **Create an issue**: `fj issue create "<title>" --body "..."`. Use `--body-file <path>` for multi-line bodies; leaving both out opens an editor.
- **Read an issue**: `fj issue view <number>` for the title and body, `fj issue view <number> comments` for the comments. `fj` prints text, not JSON.
- **List issues**: `fj issue search --labels "<label>"`, with `--state open|closed|all` and `--all` to skip paging.
- **Comment on an issue**: `fj issue comment <number> "..."`, or `--body-file <path>`.
- **Apply / remove labels**: `fj issue edit <number> labels --add "<label>"` / `--rm "<label>"`.
- **Close**: `fj issue close <number> --with-msg "..."` posts the explanation and closes in one step.
- **Pull requests**: `fj pr create "<title>" --base <branch> --head <branch> --body "..."`, `fj pr view <number>` (add `diff` or `comments`), `fj pr comment <number> "..."`, `fj pr close <number>`.

Infer the repo from `git remote -v`; `fj` does this automatically inside a clone. Pass `-R <remote>` to pick a git remote, or `-H <host>` for an instance other than the remote's.

## Pull requests as a triage surface

**PRs as a request surface: no.** _(Set to `yes` if this repo treats external pull requests as feature requests; `/triage` reads this flag.)_

When set to `yes`, PRs run through the same labels and states as issues, using the `fj pr` equivalents:

- **Read a PR**: `fj pr view <number>`, `fj pr view <number> comments` and `fj pr view <number> diff`.
- **List external PRs for triage**: `fj pr search --state open`, then keep only PRs whose author is not a maintainer (a contributor's PR, not a maintainer's in-flight work).
- **Comment / close**: `fj pr comment`, `fj pr close --with-msg`.

Like GitHub, Forgejo numbers issues and PRs in one sequence, so `#42` names exactly one of them.

## When a skill says "publish to the issue tracker"

Create a Forgejo issue.

## When a skill says "fetch the relevant ticket"

Run `fj issue view <number>` and `fj issue view <number> comments`.

## Wayfinding operations

Used by `/wayfinder`. The **map** is a single issue with **child** issues as tickets.

- **Map**: a single issue labelled `wayfinder:map`, holding the Notes / Decisions-so-far / Fog body.
- **Child ticket**: an issue carrying `Part of #<map>` at the top of its body, and labels `wayfinder:<type>` (`research`/`prototype`/`grilling`/`task`). Once claimed, the ticket is assigned to the driving dev.
- **Blocking**: Forgejo's **native issue dependencies**: `fj issue depend add <child> <blocker>`. A ticket is unblocked when every dependency is closed.
- **Frontier query**: `fj issue search --labels "wayfinder:<type>" --state open --all` for each type, keeping issues whose body says `Part of #<map>`; drop any with an open dependency (`fj issue depend list <n>`) or an assignee; first in map order wins.
- **Claim**: `fj issue assign <n> <username>`, with the username from `fj whoami`, as the session's first write.
- **Resolve**: `fj issue close <n> --with-msg "<answer>"`, then append a context pointer (gist + link) to the map's Decisions-so-far.
