"""Read the vendored template registry."""

from __future__ import annotations

from pathlib import Path
from typing import Any

import yaml

_DATA_DIR = Path(__file__).parent / "_data"


def read_registry() -> list[dict[str, Any]]:
    path = _DATA_DIR / "templates.yaml"
    return yaml.safe_load(path.read_text(encoding="utf-8"))


def resolve_template(name: str) -> dict[str, Any]:
    for entry in read_registry():
        if entry["name"] == name:
            return entry
    raise ValueError(f"unknown template: {name!r}")
