local usercmd = vim.api.nvim_create_user_command
local autocmd = vim.api.nvim_create_autocmd
local tabufline = require "nvchad.tabufline"

---------------------------------- auto cmds -------------------------------------------

autocmd({"BufCreate","BufReadPost"}, {
  callback = function(args)
    vim.api.nvim_buf_set_var(args.buf, "pinned", false)
  end
})

---------------------------------- functions -------------------------------------------

local function buf_index(bufnr)
  for i, value in ipairs(vim.t.bufs) do
    if value == bufnr then
      return i
    end
  end
end

local function get_pinned_bufs()
  local pinned_buffs = {}
  for _, value in ipairs(vim.t.bufs) do
    if vim.api.nvim_buf_get_var(value, "pinned") then
      table.insert(pinned_buffs, value)
    end
  end
  return pinned_buffs
end

local function PinCurrentBuffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local curbufinx = buf_index(bufnr)

  if not curbufinx or vim.api.nvim_buf_get_var(bufnr, "pinned") then
    return
  end

  local pbufs = get_pinned_bufs()
  local nmoves = curbufinx - (#pbufs + 1)
  for _ = 1, nmoves do
    tabufline.move_buf(-1)
  end
  vim.api.nvim_buf_set_var(bufnr, "pinned", true)
end

local function UnpinCurrentBuf()
  local bufnr = vim.api.nvim_get_current_buf()
  local curbufinx = buf_index(bufnr)

  if not curbufinx or not vim.api.nvim_buf_get_var(bufnr, "pinned") then
    return
  end

  local pbufs = get_pinned_bufs()
  local nmoves = #pbufs - curbufinx
  for _ = 1, nmoves do
    tabufline.move_buf(1)
  end
  vim.api.nvim_buf_set_var(bufnr, "pinned", false)
end

local function CloseNonPinnedBufs()
  local pbufs = get_pinned_bufs()
  if next(pbufs) == nil then
    return
  end
  vim.api.nvim_set_current_buf(pbufs[#pbufs])
  tabufline.closeBufs_at_direction("right")
end

-------------------------------- user commands ----------------------------------------

usercmd("PinCurrentBuf", function(_)
  PinCurrentBuffer()
end, {})
usercmd("UnpinCurrentBuf", function(_)
  UnpinCurrentBuf()
end, {})
usercmd("CloseNonPinnedBufs", function(_)
  CloseNonPinnedBufs()
end, {})
