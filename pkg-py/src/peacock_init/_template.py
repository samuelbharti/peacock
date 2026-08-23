"""Download and unpack a GitHub repository as a project template."""

from __future__ import annotations

import shutil
import subprocess
import tempfile
from pathlib import Path

from ._registry import resolve_template


def init_template(name_or_repo: str, path: str, ref: str = "HEAD") -> Path:
    root = Path(path)

    if "/" not in name_or_repo:
        entry = resolve_template(name_or_repo)
        repo = entry["repo"]
        ref = entry.get("ref", ref)
    else:
        repo = name_or_repo

    url = f"https://github.com/{repo}.git"

    with tempfile.TemporaryDirectory() as tmp:
        clone_dir = Path(tmp) / "repo"
        cmd = ["git", "clone", "--depth", "1"]
        if ref and ref != "HEAD":
            cmd += ["--branch", ref]
        cmd += [url, str(clone_dir)]
        subprocess.run(cmd, check=True, capture_output=True, text=True)

        git_dir = clone_dir / ".git"
        if git_dir.exists():
            shutil.rmtree(git_dir)

        root.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(clone_dir, root)

    return root
