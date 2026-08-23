"""Scaffold Python and analysis projects."""

from __future__ import annotations

from pathlib import Path

from ._agents import write_agent_files


def init_python(path: str, title: str = "") -> Path:
    root = Path(path)
    root.mkdir(parents=True, exist_ok=True)

    name = root.name.replace("-", "_")
    if not title:
        title = root.name

    (root / "src" / name).mkdir(parents=True)
    (root / "src" / name / "__init__.py").write_text(
        f'"""{title}."""\n\n__version__ = "0.1.0"\n',
        encoding="utf-8",
    )

    (root / "tests").mkdir()
    (root / "tests" / "__init__.py").write_text("", encoding="utf-8")
    (root / "tests" / f"test_{name}.py").write_text(
        f"from {name} import __version__\n\n\ndef test_version():\n"
        f'    assert __version__ == "0.1.0"\n',
        encoding="utf-8",
    )

    (root / "pyproject.toml").write_text(
        f"""[build-system]
requires = ["hatchling>=1.27"]
build-backend = "hatchling.build"

[project]
name = "{root.name}"
version = "0.1.0"
description = "{title}"
readme = "README.md"
requires-python = ">=3.9"
license = "MIT"

[dependency-groups]
dev = ["pytest>=8", "ruff>=0.15"]

[tool.hatch.build.targets.wheel]
packages = ["src/{name}"]

[tool.ruff]
line-length = 88
target-version = "py39"

[tool.ruff.lint]
select = ["E", "F", "W", "I", "UP", "B"]
ignore = ["E501"]
""",
        encoding="utf-8",
    )

    (root / "README.md").write_text(f"# {title}\n", encoding="utf-8")

    (root / ".gitignore").write_text(
        "__pycache__/\n*.py[cod]\n.venv/\n.pytest_cache/\n"
        ".ruff_cache/\nbuild/\ndist/\n*.egg-info/\n",
        encoding="utf-8",
    )

    write_agent_files(root)

    return root


def init_analysis(path: str, title: str = "") -> Path:
    root = Path(path)
    root.mkdir(parents=True, exist_ok=True)

    if not title:
        title = root.name

    for d in [
        "data/raw",
        "data/processed",
        "output/figures",
        "output/tables",
        "notebooks",
        "scripts",
    ]:
        (root / d).mkdir(parents=True)

    (root / "README.md").write_text(
        f"# {title}\n\nReproducible analysis project.\n",
        encoding="utf-8",
    )

    (root / ".gitignore").write_text(
        "data/raw/\ndata/processed/\noutput/\n.env\n__pycache__/\n*.py[cod]\n.venv/\n",
        encoding="utf-8",
    )

    (root / "data" / "raw" / ".gitkeep").write_text("", encoding="utf-8")
    (root / "data" / "processed" / ".gitkeep").write_text("", encoding="utf-8")
    (root / "output" / "figures" / ".gitkeep").write_text("", encoding="utf-8")
    (root / "output" / "tables" / ".gitkeep").write_text("", encoding="utf-8")

    write_agent_files(root)

    return root
