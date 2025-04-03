require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>tl", "<cmd>set list!<CR>", { desc = "toggle list mode"})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
