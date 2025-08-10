local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    rust = { "rustfmt" },
    json = { "jq" },
  },
}

return options
