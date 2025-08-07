require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>tl", "<cmd>set list!<CR>", { desc = "toggle list mode" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- tabufline
map("n", "<leader>ta", "<cmd>tabnew<CR>", { desc = "create new tab" })
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "close current tab" })

-- yazi
map({ "n", "v" }, "<leader>-", "<cmd>Yazi<cr>", { desc = "open yazi at the current file" })
map("n", "<leader>cw", "<cmd>Yazi cwd<cr>", { desc = "open yazi in nvim's working directory" })
map("n", "<C-up>", "<cmd>Yazi toggle<cr>", { desc = "Resume the last yazi session" })

-- lazygit
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- aerial
map("n", "<leader>to", "<cmd>AerialToggle!<CR>", { desc = "toggle file outline" })

-- nvim-dap
map("n", "<leader>dt", function()
  require("dap").toggle_breakpoint()
end, { desc = "(DAP) toggle breakpoint", nowait = true, remap = true })

map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "(DAP) continue", nowait = true, remap = true })

map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "(DAP) step into", nowait = true, remap = true })

map("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "(DAP) step over", nowait = true, remap = true })

map("n", "<leader>du", function()
  require("dap").step_out()
end, { desc = "(DAP) step out", nowait = true, remap = true })

map("n", "<leader>dr", function()
  require("dap").repl.open()
end, { desc = "(DAP) open repl", nowait = true, remap = true })

map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "(DAP) run last", nowait = true, remap = true })

map("n", "<leader>dq", function()
  require("dap").terminate()
  require("dapui").close()
  require("nvim-dap-virtual-text").toggle()
end, { desc = "(DAP) terminate", nowait = true, remap = true })

map("n", "<leader>db", function()
  require("dap").list_breakpoints()
end, { desc = "(DAP) list breakpoints", nowait = true, remap = true })

map("n", "<leader>de", function()
  require("dap").set_exception_breakpoints { "all" }
end, { desc = "(DAP) set exception breakpoints", nowait = true, remap = true })
