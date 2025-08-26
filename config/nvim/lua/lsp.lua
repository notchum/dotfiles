local lspconfig = require "lspconfig"
local servers = { "lua_ls", "clangd", "ruff", "rust_analyzer" }

-- Modified from https://gist.github.com/MariaSolOs/2e44a86f569323c478e5a078d0cf98cc
local function on_attach(client, bufnr)
  ---Utility for keymap creation.
  ---@param lhs string
  ---@param rhs string|function
  ---@param opts string|table
  ---@param mode? string|string[]
  local function keymap(lhs, rhs, opts, mode)
    opts = type(opts) == 'string' and { desc = opts }
        or vim.tbl_extend('error', opts --[[@as table]], { buffer = bufnr })
    mode = mode or 'n'
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  ---For replacing certain <C-x>... keymaps.
  ---@param keys string
  local function feedkeys(keys)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
  end

  ---Is the completion menu open?
  local function pumvisible()
    return tonumber(vim.fn.pumvisible()) ~= 0
  end

  -- Enable completion and configure keybindings.
  if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

    -- Use enter to accept completions.
    keymap('<CR>', function()
      return pumvisible() and '<C-y>' or '<CR>'
    end, { expr = true }, 'i')

    -- Use slash to dismiss the completion menu.
    keymap('/', function()
      return pumvisible() and '<C-e>' or '/'
    end, { expr = true }, 'i')

    -- Use <C-n> to navigate to the next completion or:
    -- - Trigger LSP completion.
    -- - If there's no one, fallback to vanilla omnifunc.
    keymap('<C-n>', function()
      if pumvisible() then
        feedkeys '<C-n>'
      else
        if next(vim.lsp.get_clients { bufnr = 0 }) then
          vim.lsp.completion.trigger()
        else
          if vim.bo.omnifunc == '' then
            feedkeys '<C-x><C-n>'
          else
            feedkeys '<C-x><C-o>'
          end
        end
      end
    end, 'Trigger/select next completion', 'i')

    -- Buffer completions.
    keymap('<C-u>', '<C-x><C-n>', { desc = 'Buffer completions' }, 'i')

    -- Use <Tab> to select the next completion or navigate between snippet tabstops
    -- Do something similar with <S-Tab>.
    keymap('<Tab>', function()
      if pumvisible() then
        feedkeys '<C-n>'
      elseif vim.snippet.active { direction = 1 } then
        vim.snippet.jump(1)
      else
        feedkeys '<Tab>'
      end
    end, {}, { 'i', 's' })
    keymap('<S-Tab>', function()
      if pumvisible() then
        feedkeys '<C-p>'
      elseif vim.snippet.active { direction = -1 } then
        vim.snippet.jump(-1)
      else
        feedkeys '<S-Tab>'
      end
    end, {}, { 'i', 's' })

    -- Inside a snippet, use backspace to remove the placeholder.
    keymap('<BS>', '<C-o>s', {}, 's')
  end

  -- signatures
  -- Modified from https://github.com/NvChad/ui/blob/v3.0/lua/nvchad/lsp/signature.lua
  vim.schedule(function()
    local signatureProvider = client.server_capabilities.signatureHelpProvider
    if signatureProvider and signatureProvider.triggerCharacters then
      local function check_triggeredChars(triggerChars)
        local cur_line = vim.api.nvim_get_current_line()
        local pos = vim.api.nvim_win_get_cursor(0)[2]
        local prev_char = cur_line:sub(pos - 1, pos - 1)
        local cur_char = cur_line:sub(pos, pos)

        for _, char in ipairs(triggerChars) do
          if cur_char == char or prev_char == char then
            return true
          end
        end
      end

      local group = vim.api.nvim_create_augroup("LspSignature", { clear = false })
      vim.api.nvim_clear_autocmds { group = group, buffer = bufnr }

      local triggerChars = client.server_capabilities.signatureHelpProvider.triggerCharacters

      vim.api.nvim_create_autocmd("TextChangedI", {
        group = group,
        buffer = bufnr,
        callback = function()
          if check_triggeredChars(triggerChars) then
            vim.lsp.buf.signature_help { focus = false, silent = true, max_height = 7, border = "single" }
          end
        end,
      })
    end
  end)

  -- general keymaps
  keymap('gD', vim.lsp.buf.declaration, { desc = "Go to declaration" }, 'n')
  keymap('gd', vim.lsp.buf.definition, { desc = "Go to definition" }, 'n')
  keymap('<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" }, 'n')
  keymap('<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" }, 'n')
  keymap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { desc = "List workspace folders" }, 'n')
  keymap('<leader>D', vim.lsp.buf.type_definition, { desc = "Go to type definition" }, 'n')
  keymap('<leader>lf', vim.lsp.buf.format, { desc = "Format buffer" }, 'n')
  keymap('<leader>rn', vim.lsp.buf.rename, { desc = "Rename variable" }, 'n') -- TODO better renamer
end

-- set up lsp servers
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
