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
vim.opt.winborder = "double"
vim.opt.listchars = { tab = "››", space = "·" }

-- packages
vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
  { src = "https://github.com/ficd0/ashen.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/stevearc/aerial.nvim" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/rmagatti/auto-session" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
})

-- package configs
require("ashen").setup()
require("oil").setup()
require("mason").setup()
require("aerial").setup()
require("auto-session").setup()
require("fzf-lua").setup({
  winopts = {
    height = 0.60,
    width = 0.60,
    row = 1,
    col = 0,
    border = "double",
    preview = { hidden = true },
  },
})
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "c", "cpp", "bash", "python", "make", "rust" },
  highlight = { enable = true },
})
require("gitsigns").setup({
  signs = {
    delete = { show_count = true },
    topdelete = { show_count = true },
  },
  count_chars = { "₁", "₂", "₃", "₄", "₅", "₆", "₇", "₈", "₉", ["+"] = "₊", },
})

-- language servers
require("lsp")

-- colors
vim.cmd("colorscheme ashen")

-- mappings
local map = vim.keymap.set
map('i', 'jk', '<ESC>')
map('n', '<ESC>', ':noh<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map('n', '<leader>tl', ':set list!<CR>')
map('n', '<leader>lf', vim.lsp.buf.format)
map('n', '<leader>r', vim.lsp.buf.rename)
map({ 'n', 'v' }, '<leader>c', '1z=')
map({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
map({ 'n', 'v', 'x' }, '<leader>s', ':e #<CR>')
map({ 'n', 'v', 'x' }, '<leader>S', ':sf #<CR>')
map('n', '<leader>f', ':FzfLua files<CR>')
map('n', '<leader>h', ':FzfLua helptags<CR>')
map('n', '<leader>b', ':FzfLua buffers<CR>')
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
