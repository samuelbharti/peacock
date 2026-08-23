# peacock

Project scaffolding for R and Python. One function (or CLI command) sets up
a ready-to-work directory with the right layout, config files, and agent
guidance.

## Packages

| Package | Language | Install | Docs |
|---------|----------|---------|------|
| [peacock](pkg-r/) | R | `pak::pak("samuelbharti/peacock/pkg-r")` | [samuelbharti.com/peacock/r](https://www.samuelbharti.com/peacock/r/) |
| [peacock-init](pkg-py/) | Python | `pip install peacock-init` | coming soon |

## Repository layout

```
pkg-r/     R package (CRAN)
pkg-py/    Python CLI (PyPI)
shared/    Template registry (source of truth for both packages)
tools/     Sync and version-check scripts
```

## License

MIT
