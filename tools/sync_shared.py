"""Sync shared/templates.yaml to vendored copies in pkg-r/ and pkg-py/."""

from pathlib import Path
import shutil
import yaml

ROOT = Path(__file__).resolve().parent.parent
SHARED_YAML = ROOT / "shared" / "templates.yaml"
R_DCF = ROOT / "pkg-r" / "inst" / "templates.dcf"
PY_YAML = ROOT / "pkg-py" / "src" / "peacock_init" / "_data" / "templates.yaml"

FIELD_MAP = {
    "name": "Name",
    "repo": "Repo",
    "ref": "Ref",
    "doc_url": "DocURL",
    "description": "Description",
}


def to_dcf(templates: list[dict]) -> str:
    blocks = []
    for tmpl in templates:
        lines = []
        for yaml_key, dcf_key in FIELD_MAP.items():
            value = tmpl.get(yaml_key, "")
            lines.append(f"{dcf_key}: {value}")
        blocks.append("\n".join(lines))
    return "\n\n".join(blocks) + "\n"


def main() -> None:
    templates = yaml.safe_load(SHARED_YAML.read_text(encoding="utf-8"))

    R_DCF.parent.mkdir(parents=True, exist_ok=True)
    R_DCF.write_text(to_dcf(templates), encoding="utf-8")
    print(f"wrote {R_DCF.relative_to(ROOT)}")

    if PY_YAML.parent.exists():
        shutil.copy2(SHARED_YAML, PY_YAML)
        print(f"wrote {PY_YAML.relative_to(ROOT)}")
    else:
        print(f"skipped {PY_YAML.relative_to(ROOT)} (pkg-py not found)")


if __name__ == "__main__":
    main()
