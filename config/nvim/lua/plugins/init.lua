return {
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
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      {
        "<leader>dt",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
        nowait = true,
        remap = false,
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
        nowait = true,
        remap = false,
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
        nowait = true,
        remap = false,
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
        nowait = true,
        remap = false,
      },
      {
        "<leader>du",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
        nowait = true,
        remap = false,
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "Open REPL",
        nowait = true,
        remap = false,
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Run Last",
        nowait = true,
        remap = false,
      },
      {
        "<leader>dq",
        function()
          require("dap").terminate()
          require("dapui").close()
          require("nvim-dap-virtual-text").toggle()
        end,
        desc = "Terminate",
        nowait = true,
        remap = false,
      },
      {
        "<leader>db",
        function()
          require("dap").list_breakpoints()
        end,
        desc = "List Breakpoints",
        nowait = true,
        remap = false,
      },
      {
        "<leader>de",
        function()
          require("dap").set_exception_breakpoints { "all" }
        end,
        desc = "Set Exception Breakpoints",
        nowait = true,
        remap = false,
      },
    },
    config = function()
      local mason_dap = require "mason-nvim-dap"
      local dap = require "dap"
      local ui = require "dapui"
      local dap_virtual_text = require "nvim-dap-virtual-text"

      -- Dap Virtual Text
      dap_virtual_text.setup()
      mason_dap.setup {
        ensure_installed = { "cppdbg", "python" },
        automatic_installation = true,
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      }

      -- Configurations
      dap.configurations = {
        c = {
          {
            name = "Launch file",
            type = "cppdbg",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopAtEntry = false,
            MIMode = "lldb",
          },
          {
            name = "Attach to lldbserver :1234",
            type = "cppdbg",
            request = "launch",
            MIMode = "lldb",
            miDebuggerServerAddress = "localhost:1234",
            miDebuggerPath = "/usr/bin/lldb",
            cwd = "${workspaceFolder}",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
          },
        },
        python = {
          {
            name = "Python Debugger: Current File",
            type = "python",
            request = "launch",
            program = "${file}",
            pythonPath = function()
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
              elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                return cwd .. "/.venv/bin/python"
              else
                return "/usr/bin/python"
              end
            end,
          },
          {
            name = "Debug Discord Bot",
            type = "python",
            request = "launch",
            program = "${workspaceFolder}/launcher.py",
            justMyCode = false,
            pythonPath = function()
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
              elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                return cwd .. "/.venv/bin/python"
              else
                return "/usr/bin/python"
              end
            end,
          },
        },
      }

      -- Dap UI
      ui.setup()
      vim.fn.sign_define("DapBreakpoint", { text = "🐞" })
      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },

  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim", lazy = true },
    keys = {
      {
        "<leader>-",
        mode = { "n", "v" },
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
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
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
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
}
