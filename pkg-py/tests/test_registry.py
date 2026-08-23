import pytest

from peacock_init._registry import read_registry, resolve_template


def test_read_registry() -> None:
    registry = read_registry()
    assert isinstance(registry, list)
    assert len(registry) >= 1
    assert all("name" in entry for entry in registry)
    assert all("repo" in entry for entry in registry)


def test_resolve_known_template() -> None:
    entry = resolve_template("shiny")
    assert entry["repo"] == "samuelbharti/RShiny_template"


def test_resolve_unknown_template() -> None:
    with pytest.raises(ValueError, match="unknown template"):
        resolve_template("nonexistent-template")
