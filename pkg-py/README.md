# peacock-init

Python CLI companion to the [peacock](https://github.com/samuelbharti/peacock)
R package. Scaffold project directories from templates with one command.

## Install

```bash
pip install peacock-init
```

## Usage

```bash
# Scaffold a Python project
peacock init python my-project

# Scaffold a reproducible analysis
peacock init analysis my-analysis

# Use a GitHub template from the registry
peacock init template shiny my-app

# Use any GitHub repo as a template
peacock init template owner/repo my-project --ref v1.0

# List available templates
peacock templates
```

## Templates

Run `peacock templates` to see the built-in template registry. Templates are
GitHub repositories that get cloned and unpacked into your target directory.

## License

MIT
