"""Check that version strings are consistent across the monorepo."""

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

SOURCES = {
    "pkg-r/DESCRIPTION": re.compile(r"^Version:\s*(.+)$", re.MULTILINE),
    "CITATION.cff": re.compile(r"^version:\s*(.+)$", re.MULTILINE),
    "pkg-r/NEWS.md": re.compile(r"^#\s+peacock\s+([\d.]+)", re.MULTILINE),
}

PY_SOURCE = {
    "pkg-py/pyproject.toml": re.compile(r'^version\s*=\s*"(.+?)"', re.MULTILINE),
}


def main() -> int:
    versions: dict[str, str] = {}

    for rel_path, pattern in SOURCES.items():
        path = ROOT / rel_path
        if not path.exists():
            print(f"warning: {rel_path} not found, skipping")
            continue
        match = pattern.search(path.read_text(encoding="utf-8"))
        if match:
            versions[rel_path] = match.group(1).strip()
        else:
            print(f"warning: no version found in {rel_path}")

    for rel_path, pattern in PY_SOURCE.items():
        path = ROOT / rel_path
        if not path.exists():
            continue
        match = pattern.search(path.read_text(encoding="utf-8"))
        if match:
            versions[rel_path] = match.group(1).strip()

    if not versions:
        print("error: no version sources found")
        return 1

    unique = set(versions.values())
    for source, version in sorted(versions.items()):
        status = "ok" if len(unique) == 1 else ""
        print(f"  {source}: {version} {status}")

    if len(unique) > 1:
        print(f"\nerror: found {len(unique)} different versions: {unique}")
        return 1

    print(f"\nall versions match: {unique.pop()}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
