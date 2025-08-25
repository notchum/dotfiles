vim.diagnostic.config {
--   signs = {
--     text = {
--       [vim.diagnostic.severity.ERROR] = "󰅙",
--       [vim.diagnostic.severity.WARN] = "",
--       [vim.diagnostic.severity.INFO] = "󰋼",
--       [vim.diagnostic.severity.HINT] = "󰌵"
--     }
--   },
  underline = true,
  float = { border = "single" },
}

local lspconfig = require "lspconfig"
local servers = { "lua_ls", "clangd", "ruff", "rust_analyzer" }

local function on_attach(client, bufnr)
  vim.lsp.completion.enable(true, client.id, bufnr, {
    autotrigger = true,
    convert = function(item)
      return { abbr = item.label:gsub("%b()", "") }
    end,
  })

  local map = vim.keymap.set
  map('i', '<leader> ', vim.lsp.completion.get)
  map('n', '<leader>gd', vim.lsp.buf.definition)
  map('n', '<leader>gD', vim.lsp.buf.declaration)
  map('n', '<leader>gi', vim.lsp.buf.implementation)
  map('n', 'K', vim.lsp.buf.hover)
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
  }
end

-- configuring single server efm for bash linting + formatting
lspconfig.efm.setup {
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      bash = {
        {
          prefix = 'shellcheck',
          lintSource = 'shellcheck',
          lintCommand = 'shellcheck --color=never --format=gcc -',
          lintIgnoreExitCode = true,
          lintStdin = true,
          lintFormats = { '-:%l:%c: %trror: %m', '-:%l:%c: %tarning: %m', '-:%l:%c: %tote: %m' },
        },
        {
          formatCommand = 'shfmt -ci -s -bn',
          formatStdin = true
        },
      }
    }
  }
}
