"""Command-line interface for peacock-init."""

from __future__ import annotations

import click

from . import __version__
from ._registry import read_registry
from ._scaffold import init_analysis, init_python
from ._template import init_template


@click.group()
@click.version_option(version=__version__, prog_name="peacock")
def main() -> None:
    """Scaffold project directories from templates."""


@main.group()
def init() -> None:
    """Create a new project from a scaffold or template."""


@init.command()
@click.argument("path")
@click.option(
    "--title", default="", help="Project title for README and pyproject.toml."
)
def python(path: str, title: str) -> None:
    """Scaffold a Python project with src layout, tests, and ruff config."""
    root = init_python(path, title=title)
    click.echo(f"Created Python project at {root}")


@init.command()
@click.argument("path")
@click.option("--title", default="", help="Project title for README.")
def analysis(path: str, title: str) -> None:
    """Scaffold a reproducible analysis project."""
    root = init_analysis(path, title=title)
    click.echo(f"Created analysis project at {root}")


@init.command()
@click.argument("name_or_repo")
@click.argument("path")
@click.option(
    "--ref", default="HEAD", help="Git ref to clone (tag, branch, or commit)."
)
def template(name_or_repo: str, path: str, ref: str) -> None:
    """Clone a GitHub template into a new project directory.

    NAME_OR_REPO can be a registry name (e.g. 'shiny') or a GitHub
    owner/repo path (e.g. 'user/repo').
    """
    root = init_template(name_or_repo, path, ref=ref)
    click.echo(f"Created project from template at {root}")


@main.command()
def templates() -> None:
    """List available templates from the built-in registry."""
    registry = read_registry()
    for entry in registry:
        name = entry["name"]
        desc = entry.get("description", "")
        repo = entry.get("repo", "")
        click.echo(f"  {name:12s} {repo:40s} {desc}")
