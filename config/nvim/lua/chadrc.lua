-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "ashen",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  statusline = {
    theme = "vscode_colored",
  },
  tabufline = {
    modules = {
      treeOffset = require("custom.tabufline.modules").treeOffset,
      buffers = require("custom.tabufline.modules").buffers,
      tabs = require("custom.tabufline.modules").tabs,
      btns = require("custom.tabufline.modules").btns,
    },
  },
}

return M
