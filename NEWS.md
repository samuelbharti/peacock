# peacock 0.1.0

Initial release of peacock.

## Features

* `init_shiny()` - Initialize a complete Shiny application structure with organized folders for modules, UI components, data, and static assets. Includes Dockerfile for deployment.

* `init_template()` - Download and set up project templates from GitHub repositories. Currently supports "shiny" and "cgds" templates.

* `init_changelog_md()` - Create a CHANGELOG.md file with a simple format for tracking project progress and changes.

* `tool_review_template()` - Set up an organized structure for comparing multiple tools or methods, with dedicated folders for each tool's data, scripts, and outputs.

## Notes

* All functions include a confirmation prompt by default. Set `confirm = FALSE` to skip prompts in automated workflows.

* Templates create standard directory structures that can be modified after creation to fit specific needs.

* Package includes built-in error handling and user-friendly messages for setup workflows.
