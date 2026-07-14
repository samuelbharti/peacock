# Write AGENTS.md (the source of truth) plus a CLAUDE.md that imports it, so both
# cross-tool agents and Claude Code pick up the project's guidance.
#
# @param path Project directory.
# @param lines Character vector of AGENTS.md contents.
# @return Invisibly, `path`.
write_agent_files <- function(path, lines) {
  agents <- file(file.path(path, "AGENTS.md"))
  writeLines(lines, agents)
  close(agents)

  claude <- file(file.path(path, "CLAUDE.md"))
  writeLines(
    c(
      "# Agent guidance",
      "",
      "This project's agent instructions live in [AGENTS.md](AGENTS.md).",
      "",
      "@AGENTS.md"
    ),
    claude
  )
  close(claude)

  invisible(path)
}
