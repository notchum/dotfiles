vim.g.mapleader = " "

-- options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.fillchars = { eob = " " }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"

vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeoutlen = 400
vim.opt.undofile = true

vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.winborder = "rounded"
vim.opt.listchars = { tab = "››", space = "·" }

-- packages
vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
  { src = "https://github.com/ficd0/ashen.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/stevearc/aerial.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

-- package configs
require("ashen").setup()
require("oil").setup()
require("mason").setup()
require("aerial").setup()
require("mini.pick").setup({
  mappings = { move_down = '<C-j>', move_up = '<C-k>' }
})
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "c", "cpp", "bash", "python", "make", "rust" },
  highlight = { enable = true },
})
require("gitsigns").setup({
  signs_staged = {
    delete = { show_count = true },
    topdelete = { show_count = true },
  },
  count_chars = { "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉", ["+"] = "₊", },
})

-- language servers
require("lspconfig").efm.setup {
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
vim.lsp.enable({ "lua_ls", "clangd", "ruff", "rust_analyzer" })

-- colors
vim.cmd("colorscheme ashen")

-- mappings
local map = vim.keymap.set
map('i', 'jk', '<ESC>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map('n', '<leader>tl', ':set list!<CR>')
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>gd', vim.lsp.buf.definition)
map('n', '<leader>gD', vim.lsp.buf.declaration)
map({ 'n', 'v' }, '<leader>c', '1z=')
map({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
map({ 'n', 'v', 'x' }, '<leader>s', ':e #<CR>')
map({ 'n', 'v', 'x' }, '<leader>S', ':sf #<CR>')
map('n', '<leader>f', ':Pick files<CR>')
map('n', '<leader>h', ':Pick help<CR>')
map('n', '<leader>b', ':Pick buffers<CR>')
map('n', '<leader>e', ':Oil<CR>')
map('n', '<leader>lg', ':LazyGit<CR>')
map('n', '<leader>to', ':AerialToggle!<CR>')

-- user commands
vim.api.nvim_create_user_command("MasonInstallAll", function()
  local ensure_mason_installed = {
    "clangd", "clang-format", "lua-language-server", "ruff", "rust-analyzer", "efm", "shellcheck", "shfmt"
  }
  vim.cmd("MasonInstall " .. table.concat(ensure_mason_installed, " "))
end, {})

-- auto commands
require("autocmds")
