"""Write AGENTS.md and CLAUDE.md into scaffolded projects."""

from __future__ import annotations

from pathlib import Path

_AGENTS_MD = """\
# AGENTS.md

Conventions for AI agents working in this project.

## Style

- Write clear, direct code with descriptive names.
- Keep functions short and focused.
- Add comments only when the reason is not obvious from the code.

## Testing

- Run tests with `pytest`.
- Add a test for every new function.
"""

_CLAUDE_MD = """\
# CLAUDE.md

## Build and test

```
pytest
ruff check .
ruff format --check .
```

## Conventions

- Follow existing code patterns.
- No em dashes in comments or documentation.
- Keep documentation simple and factual.
"""


def write_agent_files(root: Path) -> None:
    (root / "AGENTS.md").write_text(_AGENTS_MD, encoding="utf-8")
    (root / "CLAUDE.md").write_text(_CLAUDE_MD, encoding="utf-8")
