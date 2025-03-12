return {
  {
    "sainnhe/sonokai",
    config = function()
      vim.g.sonokai_style = "andromeda"
      vim.cmd.colorscheme("sonokai")
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    -- config = function()
    --   vim.cmd.colorscheme("kanagawa-lotus")
    -- end,
  },

  {
    "sainnhe/gruvbox-material",
    -- config = function()
    --   vim.cmd.colorscheme("gruvbox-material")
    -- end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  -- stylua: ignore
  keys = {
    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
  },

  {
    "eandrju/cellular-automaton.nvim",
    event = "VeryLazy",
  },

  {
    "alec-gibson/nvim-tetris",
    event = "VeryLazy",
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ocamllsp = {
          mason = false,
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ocaml = { "ocamlformat" },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              build = {
                executable = "tectonic",
                args = {
                  "-X",
                  "compile",
                  "%f",
                  "--synctex",
                  "--keep-logs",
                  "--keep-intermediates",
                  "-Z",
                  "shell-escape",
                },
                onSave = true,
                forwardSearchAfter = true,
              },
              forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
              },
              chktex = {
                onOpenAndSave = true,
                onEdit = true,
              },
            },
          },
        },
      },
    },
  },

  -- {
  --   "lervag/vimtex",
  --   config = function()
  --     vim.g.vimtex_view_method = "zathura"
  --     vim.g.vimtex_compiler_method = "tectonic"
  --     vim.g.vimtex_compiler_tectonic = {
  --       options = { "-Z", "shell-escape" },
  --     }
  --   end,
  -- },
}
