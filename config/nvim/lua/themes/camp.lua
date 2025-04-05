-- Customized by @notchum
-- Credits to original https://github.com/Lvzitan/obsidian-ember-theme

local M = {}

M.base_30 = {
  white = "#d3d3d3",
  darker_black = "#000000",
  black = "#1e1e1e", --  nvim bg
  black2 = "#252525",
  one_bg = "#2c2c2c",
  one_bg2 = "#333333",
  one_bg3 = "#3a3a3a",
  grey = "#414141",
  grey_fg = "#484848",
  grey_fg2 = "#4f4f4f",
  light_grey = "#565656",
  red = "#ff6464",
  baby_pink = "#de878f",
  pink = "#d57780",
  line = "#333333", -- for lines like vertsplit
  green = "#52aa5e",
  vibrant_green = "#76c793",
  blue = "#4a8b8b",
  nord_blue = "#74b2c9",
  yellow = "#ffcc00",
  sun = "#e0c247",
  purple = "#824c71",
  dark_purple = "#bd5e91",
  teal = "#087f8c",
  orange = "#cd6316",
  cyan = "#00c3a5",
  statusline_bg = "#222222",
  lightbg = "#303030",
  pmenu_bg = "#853d3d",
  folder_bg = "#b14242",
}

M.base_16 = {
  base00 = "#000000", -- default background
  base01 = "#2c2c2c", -- lighter background (used for status bars, line number, and folding marks)
  base02 = "#333333", -- selection background
  base03 = "#3a3a3a", -- comments, invisibles, line highlighting
  base04 = "#d3d3d3", -- dark foreground (used for status bars)
  base05 = "#d3d3d3", -- default foreground, caret, delimiters, operators
  base06 = "#ECEFF4", -- light foreground (not often used)
  base07 = "#8FBCBB", -- light background (not often used)
  base08 = "#d3d3d3", -- variables, xml tags, markup link text, markup lists, diff deleted
  base09 = "#E49A44", -- integers, boolean, constants, xml attributes, markup link url
  base0A = "#848484", -- classes, markup bold, search text background
  base0B = "#aa6666", -- strings, inherited class, markup code, diff inserted
  base0C = "#eeeeee", -- support, regular expressions, escape characters, markup quotes
  base0D = "#E49A44", -- functions, methods, attribute ids, headings
  base0E = "#E49A44", -- keywords, storage, selector, markup italic, diff changed
  base0F = "#eeeeee", -- deprecated, opening/closing embedded language tags, e.g. <?php ?>
}

M.polish_hl = {
  cmp = {
    CmpItemAbbrMatch = {
      fg = M.base_16.base08,
    },
    CmpItemAbbrMatchDefault = {
      bold = true,
      fg = M.base_16.base08,
    },
  },

  nvimtree = {
    NvimTreeWinSeparator = {
      fg = M.base_30.line,
    },
  },

  treesitter = {
    ["@string"] = { fg = M.base_16.base0B },
    ["@string.documentation"] = { fg = M.base_16.base0B },
    ["@string.regexp"] = { fg = M.base_16.base0B },
    ["@string.escape"] = { fg = M.base_16.base0B },
    ["@string.special"] = { fg = M.base_16.base0B },
    ["@string.special.symbol"] = { fg = M.base_16.base0B },
    ["@string.special.path"] = { fg = M.base_16.base0B },
    ["@string.special.url"] = {
      fg = M.base_16.base0B,
      underline = true,
    },

    ["@character"] = { fg = M.base_16.base0B },
    ["@character.special"] = { fg = M.base_16.base0B },

    ["@keyword.exception"] = { fg = M.base_16.base0A },
  },

  defaults = {
    SpellBad = {
      sp = M.base_30.red,
    },
    Cursor = {
      bg = M.base_16.base0E,
    },
    CursorLineNr = {
      fg = M.base_16.base0E,
    },
    CursorColumn = {
      bg = M.base_16.base0E,
    },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "camp")

return M
