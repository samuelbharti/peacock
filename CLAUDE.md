# CLAUDE.md

Conventions for anyone (human or agent) working in this repo.

## What peacock is

A project scaffolding tool. One monorepo: the R package lives in `pkg-r/`,
the Python package in `pkg-py/`, and the shared template registry in `shared/`.

## Ground rules

- Air formats R code. Ruff formats Python code.
- Never edit a vendored copy by hand (`pkg-r/inst/templates.dcf`,
  `pkg-py/src/peacock_init/_data/templates.yaml`). Edit `shared/` and run
  `python tools/sync_shared.py`. The drift CI job enforces this.

## Working in git

- Do not commit on `main`. Every change goes through a branch and a PR.
- Branch names use a `feat/`, `fix/`, or `chore/` prefix.
- Commit messages and PR titles follow Conventional Commits.
- Commit in small, focused batches.
- Do not attribute an AI as author or co-author on commits.

## Documentation style

- No em dashes. Write plain, direct sentences.

## Before you push

- Run `prek run --all-files`.
