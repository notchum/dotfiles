local autocmd = vim.api.nvim_create_autocmd

-- Disable kitty padding when in nvim
autocmd("VimEnter", {
  command = ":silent !kitty @ set-spacing padding=0",
})

-- Enable kitty padding when exiting nvim
autocmd("VimLeavePre", {
  command = ":silent !kitty @ set-spacing padding=default",
})

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = "1000"
    })
  end
})

-- Remove whitespace on save
autocmd("BufWritePre", {
  pattern = "",
  command = ":%s/\\s\\+$//e"
})

-- Restore cursor position on file open
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})
