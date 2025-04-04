-- Ported by @notchum
-- Credits to original https://github.com/ficcdaf/ashen.nvim

local M = {}

M.ashen = {
  -- used for errors
  red_flame = "#C53030", -- Brightest, most intense red
  -- standard red colors
  red_glowing = "#DF6464", -- Slightly deeper glowing red
  red_ember = "#B14242", -- Deep, smoldering ember red

  -- standard orange colors
  orange_glow = "#D87C4A", -- Bright, glowing orange
  orange_blaze = "#C4693D", -- Vibrant blaze orange
  orange_smolder = "#E49A44",

  -- used for warnings
  orange_golden = "#E5A72A",

  -- NOTE: These reds are not widely used and will likely be fazed out in a future update.
  red_kindling = "#BD4C4C", -- Light, warm red
  red_burnt_crimson = "#A84848", -- Muted crimson red
  red_brick = "#853D3D", -- Muted, earthy brick red
  red_deep_ember = "#7A2E2E", -- Dark, deep ember red
  red_ashen = "#6F2929", -- Cool, ashen red

  -- standard misc colors
  blue = "#4A8B8B", -- Muted teal, soft and unobtrusive
  blue_dark = "#3A6E6E", -- Dark teal, ideal for subtle backgrounds
  -- strong contender: #629C7D
  green_light = "#629C7D",
  green = "#1E6F54",

  -- standard grayscale palette
  background = "#121212",
  -- duplicate for compatibility
  -- g_0 will be removed in future
  g_0 = "#e5e5e5",
  g_1 = "#e5e5e5",
  g_2 = "#d5d5d5",
  g_3 = "#b4b4b4",
  g_4 = "#a7a7a7",
  g_5 = "#949494",
  g_6 = "#737373",
  g_7 = "#535353",
  g_8 = "#323232",
  g_9 = "#212121",
  g_10 = "#1d1d1d",
  g_11 = "#191919",
  g_12 = "#151515",

  -- WARNING: These colors are not part of the Ashen palette!
  -- Rather, they're here as reference, to have a list of "normal"
  -- colors that still fit nicely with the theme -- for example, in case
  -- you *really* need something to be, say, purple, and want it to
  -- look decent with the rest of the theme. Currently, the only place
  -- these are used is in the mini.icons integration!
  -- Please don't use them
  -- if you're porting Ashen to another program -- I can't guarantee
  -- that it'll look good! --ficcdaf
  red = "#C53030", -- Brightest, most intense red
  yellow = "#F4CA64", -- Bright sunflower yellow
  orange = "#D87C4A", -- Bright, glowing orange
  purple = "#7A3D82", -- Rich violet purple
  pink = "#D1728C", -- Deep rose pink
  brown = "#853D3D", -- Muted, earthy brick red
  black = "#121212", -- Deep background black
  white = "#FFFFFF", -- Pure white
  gray = "#A7A7A7", -- Neutral mid-gray
  cyan = "#6E91C4", -- Sky-like cyan
  magenta = "#C9347C", -- Vibrant fuchsia
  lime = "#8CD437", -- Bright lime green
  teal = "#1A3F3F", -- Dark teal
  navy = "#223A70", -- Deep navy blue
  maroon = "#7A2E2E", -- Dark, deep ember red
  olive = "#708238", -- Muted olive green
  indigo = "#502E5F", -- Deep, muted indigo
  violet = "#8E5E93", -- Soft mauve violet
  gold = "#D7A933", -- Rich golden yellow
  silver = "#D5D5D5", -- Soft, muted silver
  beige = "#F5F5DC", -- Light, warm beige
  aqua = "#4AC4C4", -- Bright aqua
  coral = "#E492B4", -- Soft coral pink
}

M.base_30 = {
  white = "#d5d5d5",
  darker_black = "#121212",
  black = "#151515", --  nvim bg
  black2 = "#191919",
  one_bg = "#1d1d1d",
  one_bg2 = "#212121",
  one_bg3 = "#323232",
  grey = "#535353",
  grey_fg = "#737373",
  grey_fg2 = "#949494",
  light_grey = "#a7a7a7",
  red = "#c53030",
  baby_pink = "#c53050",
  pink = "#d57780",
  line = "#333333", -- for lines like vertsplit
  green = "#1e6f54",
  vibrant_green = "#629c7d",
  blue = "#4a8b8b",
  nord_blue = "#3a6e6e",
  yellow = "#d7a933",
  sun = "#f4ca64",
  purple = "#7a3d82",
  dark_purple = "#8e5e93",
  teal = "#1a3f3f",
  orange = "#d87c4a",
  cyan = "#6e91c4",
  statusline_bg = "#212121",
  lightbg = "#00ff00",
  pmenu_bg = "#853d3d",
  folder_bg = "#b14242",
}

M.base_16 = {
  base00 = M.ashen.background, -- default background
  base01 = M.ashen.g_8, -- lighter background (used for status bars, line number, and folding marks)
  base02 = M.ashen.g_9, -- selection background
  base03 = M.ashen.g_6, -- comments, invisibles, line highlighting
  base04 = M.ashen.maroon, -- dark foreground (used for status bars)
  base05 = M.ashen.g_2, -- default foreground, caret, delimiters, operators
  base06 = M.ashen.g_12, -- light foreground (not often used)
  base07 = M.ashen.g_5, -- light background (not often used)
  base08 = M.ashen.g_3, -- variables, xml tags, markup link text, markup lists, diff deleted
  base09 = M.ashen.blue, -- integers, boolean, constants, xml attributes, markup link url
  base0A = M.ashen.yellow, -- classes, markup bold, search text background
  base0B = M.ashen.red_glowing, -- strings, inherited class, markup code, diff inserted
  base0C = M.ashen.red_glowing, -- support, regular expressions, escape characters, markup quotes
  base0D = M.ashen.g_1, -- functions, methods, attribute ids, headings
  base0E = M.ashen.red_ember, -- keywords, storage, selector, markup italic, diff changed
  base0F = M.ashen.g_5, -- deprecated, opening/closing embedded language tags, e.g. <?php ?>
}

M.polish_hl = {
  treesitter = {
    ["@character"] = { fg = M.ashen.red_glowing },
    ["@character.special"] = { fg = M.ashen.red_kindling },
    ["@conditional"] = { fg = M.ashen.g_2 },
    ["@constant.macro"] = { fg = M.ashen.red_ember },
    ["@constructor"] = { fg = M.ashen.g_1 },
    ["@debug"] = { fg = M.ashen.g_2 },
    ["@define"] = { fg = M.ashen.g_2 },
    ["@exception"] = { fg = M.ashen.g_2 },
    ["@field"] = { fg = M.ashen.g_2 },
    ["@float"] = { fg = M.ashen.g_2 },
    ["@function"] = { fg = M.ashen.g_1 },
    ["@function.builtin"] = { fg = M.ashen.g_1 },
    ["@function.call"] = { fg = M.ashen.g_1 },
    ["@function.macro"] = { fg = M.ashen.red_ember },
    ["@include"] = { fg = M.ashen.red_ember },
    ["@keyword"] = { fg = M.ashen.red_ember },
    ["@keyword.function"] = { fg = M.ashen.red_ember },
    ["@keyword.operator"] = { fg = M.ashen.orange_blaze },
    ["@label"] = { fg = M.ashen.red_ember },
    ["@macro"] = { fg = M.ashen.red_ember },
    ["@method"] = { fg = M.ashen.g_1 },
    ["@method.call"] = { fg = M.ashen.g_1 },
    ["@namespace"] = { fg = M.ashen.orange_blaze },
    ["@namespace.builtin"] = { fg = M.ashen.orange_blaze },
    ["@none"] = { fg = M.ashen.g_3 },
    ["@operator"] = { fg = M.ashen.orange_glow },
    ["@parameter"] = { fg = M.ashen.g_2 },
    ["@preproc"] = { fg = M.ashen.g_2 },
    ["@property"] = { fg = M.ashen.g_2 },
    ["@punctuation"] = { fg = M.ashen.g_2 },
    ["@punctuation.bracket"] = { fg = M.ashen.g_6 },
    ["@punctuation.delimiter"] = { fg = M.ashen.orange_smolder },
    ["@punctuation.special"] = { fg = M.ashen.orange_golden },
    ["@repeat"] = { fg = M.ashen.g_2 },
    ["@storageclass"] = { fg = M.ashen.g_2 },
    ["@string"] = { fg = M.ashen.red_glowing },
    ["@string.escape"] = { fg = M.ashen.g_2 },
    ["@string.special"] = { fg = M.ashen.g_2 },
    ["@string.special.url"] = { fg = M.ashen.g_2, underline = true },
    ["@structure"] = { fg = M.ashen.g_2 },
    ["@tag"] = { fg = M.ashen.g_5 },
    ["@diff.plus"] = { fg = M.ashen.g_4 },
    ["@diff.minus"] = { fg = M.ashen.red_ember },
    ["@diff.delta"] = { fg = M.ashen.orange_smolder },
    ["@tag.attribute"] = { fg = M.ashen.g_4 },
    ["@tag.delimiter"] = { fg = M.ashen.g_3 },
    ["@text.literal"] = { fg = M.ashen.red_kindling },
    ["@text.reference"] = { fg = M.ashen.red_kindling },
    ["@text.title"] = { fg = M.ashen.g_2 },
    ["@text.todo"] = { fg = M.ashen.g_2 },
    ["@text.underline"] = { fg = M.ashen.g_2 },
    ["@text.uri"] = { fg = M.ashen.g_2 },
    ["@type"] = { fg = M.ashen.g_2 },
    ["@identifier"] = { fg = M.ashen.g_1 },
    ["@variable.builtin"] = { fg = M.ashen.blue },
    ["@type.definition"] = { fg = M.ashen.g_2 },
    ["@lsp.type.function"] = { fg = M.ashen.g_1 },
    ["@lsp.type.macro"] = { fg = M.ashen.red_ember },
    ["@lsp.type.method"] = { fg = M.ashen.g_1 },
    ["@variable"] = { fg = M.ashen.g_3 },
    ["@variable.member"] = { fg = M.ashen.g_2 },
    ["@constant"] = { fg = M.ashen.orange_blaze },
    ["@constant.builtin"] = { fg = M.ashen.blue },
    ["@type.builtin"] = { fg = M.ashen.blue },
    ["@number"] = { fg = M.ashen.blue },
    ["@comment"] = { fg = M.ashen.g_6 },
    ["@boolean.go"] = { fg = M.ashen.blue },
    ["@boolean"] = { fg = M.ashen.blue },
    ["@keyword.return"] = { fg = M.ashen.red_ember },
  },

  defaults = {
    Normal = { fg = M.ashen.g_3, bg = M.ashen.background },
    ModeMsg = { fg = M.ashen.g_4 },
    SignColumn = { bg = M.ashen.background },
    LineNr = { fg = M.ashen.g_8, bg = M.ashen.background },
    Cursor = { fg = M.ashen.g_12, bg = M.ashen.g_3 },
    CursorColumn = { bg = M.ashen.g_9 },
    CursorLine = { bg = M.ashen.g_9 },
    CursorLineNr = { fg = M.ashen.red_ember, bg = M.ashen.g_9 },
    NonText = { fg = M.ashen.g_7 },
    Comment = { fg = M.ashen.g_6 },
    Boolean = { fg = M.ashen.blue },
    Constant = { fg = M.ashen.orange_blaze },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "ashen")

return M
