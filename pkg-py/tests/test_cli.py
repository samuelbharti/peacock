from click.testing import CliRunner

from peacock_init.cli import main


def test_version() -> None:
    runner = CliRunner()
    result = runner.invoke(main, ["--version"])
    assert result.exit_code == 0
    assert "peacock" in result.output


def test_templates() -> None:
    runner = CliRunner()
    result = runner.invoke(main, ["templates"])
    assert result.exit_code == 0
    assert "shiny" in result.output


def test_init_python(tmp_path) -> None:
    runner = CliRunner()
    target = str(tmp_path / "test-proj")
    result = runner.invoke(main, ["init", "python", target])
    assert result.exit_code == 0
    assert "Created Python project" in result.output


def test_init_analysis(tmp_path) -> None:
    runner = CliRunner()
    target = str(tmp_path / "test-study")
    result = runner.invoke(main, ["init", "analysis", target])
    assert result.exit_code == 0
    assert "Created analysis project" in result.output
