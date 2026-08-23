from pathlib import Path

from peacock_init._scaffold import init_analysis, init_python


def test_init_python(tmp_path: Path) -> None:
    root = init_python(str(tmp_path / "myproj"))
    assert (root / "pyproject.toml").is_file()
    assert (root / "src" / "myproj" / "__init__.py").is_file()
    assert (root / "tests" / "test_myproj.py").is_file()
    assert (root / "README.md").is_file()
    assert (root / ".gitignore").is_file()
    assert (root / "AGENTS.md").is_file()
    assert (root / "CLAUDE.md").is_file()


def test_init_python_custom_title(tmp_path: Path) -> None:
    root = init_python(str(tmp_path / "my-proj"), title="My Project")
    content = (root / "src" / "my_proj" / "__init__.py").read_text()
    assert "My Project" in content


def test_init_analysis(tmp_path: Path) -> None:
    root = init_analysis(str(tmp_path / "study"))
    assert (root / "data" / "raw" / ".gitkeep").is_file()
    assert (root / "data" / "processed" / ".gitkeep").is_file()
    assert (root / "output" / "figures" / ".gitkeep").is_file()
    assert (root / "notebooks").is_dir()
    assert (root / "scripts").is_dir()
    assert (root / "README.md").is_file()
    assert (root / "AGENTS.md").is_file()
