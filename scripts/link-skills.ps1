#Requires -Version 7
$ErrorActionPreference = 'Stop'

# NOTE: This is a dev-only script, intended for use by maintainers of this repo.
# It is not a supported installer. Modifications to it, or requests for
# modifications, will not be approved.
#
# PowerShell port of link-skills.sh. Links all skills in the repository into
# the local skill directories used by each agent harness:
#   - ~/.claude/skills: Claude Code
#   - ~/.agents/skills: Codex and other Agent Skills-compatible harnesses
# Each entry is a symlink into this repo, so a `git pull` is all that's needed
# to keep installed skills up to date.
#
# On Windows, creating symlinks needs Developer Mode or an elevated shell.

$repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$dests = @(
  (Join-Path $HOME '.claude/skills'),
  (Join-Path $HOME '.agents/skills')
)

# Same exclusions as link-skills.sh: `deprecated/` and `misc/` are skipped,
# `in-progress/` is linked on purpose (see that script for the reasoning).
$skills = Get-ChildItem -Path (Join-Path $repo 'skills') -Recurse -Filter SKILL.md -File |
  Where-Object { $_.FullName -notmatch '[\\/](node_modules|deprecated|misc)[\\/]' } |
  ForEach-Object { $_.Directory }

function Test-InRepo([string]$path) {
  $full = [IO.Path]::GetFullPath($path).TrimEnd('\', '/')
  $full -eq $repo -or $full.StartsWith($repo + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)
}

foreach ($dest in $dests) {
  # If $dest is a link that resolves into this repo, we'd end up writing the
  # per-skill links back into the repo's own skills/ tree. Bail out instead.
  $item = Get-Item -LiteralPath $dest -Force -ErrorAction SilentlyContinue
  if ($item -and $item.LinkType) {
    $resolved = $item.ResolveLinkTarget($true).FullName
    if (Test-InRepo $resolved) {
      Write-Error "$dest is a link into this repo ($resolved).`nRemove it (Remove-Item `"$dest`") and re-run; the script will recreate it as a real dir."
      exit 1
    }
  }

  New-Item -ItemType Directory -Force -Path $dest | Out-Null

  foreach ($skill in $skills) {
    $target = Join-Path $dest $skill.Name
    $existing = Get-Item -LiteralPath $target -Force -ErrorAction SilentlyContinue
    if ($existing) {
      # Real dirs are replaced like the .sh does; links are only unlinked, never followed.
      if ($existing.LinkType) { $existing.Delete() } else { Remove-Item -LiteralPath $target -Recurse -Force }
    }

    New-Item -ItemType SymbolicLink -Path $target -Target $skill.FullName | Out-Null
    Write-Output "linked $($skill.Name) -> $($skill.FullName) ($dest)"
  }
}
