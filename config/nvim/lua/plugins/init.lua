return {
  {
    "notchum/ui",
    lazy = false,
    branch = "dev",
    config = function()
      require "nvchad"
    end,
  },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = { scope = { enabled = false } },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        delete = { text = "_", show_count = true },
        topdelete = { show_count = true },
        changedelete = { text = "~" },
      },
      signs_staged = {
        delete = { show_count = true },
        topdelete = { show_count = true },
      },
      count_chars = {
        "₁",
        "₂",
        "₃",
        "₄",
        "₅",
        "₆",
        "₇",
        "₈",
        "₉",
        ["+"] = "₊",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function()
      require "configs.nvim-dap"
    end,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
  },

  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim", lazy = true },
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install && git restore .",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "c",
        "cpp",
        "rust",
        "bash",
        "python",
        "make",
      },
    },
  },

  {
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    config = function()
      require("aerial").setup()
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
}
