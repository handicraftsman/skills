#Requires -Version 7
$ErrorActionPreference = 'Stop'

$repo = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path

Get-ChildItem -Path $repo -Recurse -Filter SKILL.md -File |
  Where-Object { $_.FullName -notmatch '[\\/]node_modules[\\/]' } |
  ForEach-Object { [IO.Path]::GetRelativePath($repo, $_.FullName) -replace '\\', '/' } |
  Sort-Object -CaseSensitive
