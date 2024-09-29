return {
  -- Override plugin definition options

  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
  },

  {
    "nvimtools/none-ls.nvim",
    config = function()
      require "configs.lsp.null-ls"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "configs.lsp.null-ls"
        end,
      },
    },
    config = function()
      require "nvchad.configs.lspconfig"
      require "configs.lsp"
    end, -- Override to setup mason-lspconfig
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "c",
        "markdown",
        "markdown_inline",
        "python",
        "go",
        "rust",
        "json",
        "cpp",
        "cuda",
        "dockerfile",
        "yaml",
        "toml",
        "bash",
        "csv",
        "ocaml",
      },
      indent = {
        enable = true,
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      -- ensure_installed = {
      --   -- markdown
      --   "marksman",
      --   "misspell",

      --   -- lua
      --   "lua-language-server",
      --   "stylua",

      --   -- web dev
      --   "css-lsp",
      --   "html-lsp",
      --   "typescript-language-server",
      --   "deno",
      --   "prettier",

      --   "bash-language-server",

      --   -- docker
      --   "dockerfile-language-server",
      --   "docker-compose-language-service",

      --   -- rust
      --   "rust-analyzer",

      --   -- go
      --   "gopls",
      --   "glint",
      --   "go-debug-adapter",
      --   "goimports",
      --   "goimports-reviser",
      --   "golangci-lint",
      --   "golangci-lint-langserver",
      --   "golines",
      --   "gotests",
      --   "gotestsum",

      --   -- python
      --   "pyright",
      --   "ruff",
      --   "black",
      --   "mypy",
      --   "pydocstyle",
      --   "pylint",
      --   "pyre",
      --   "autoflake",
      --   "autopep8",
      --   "python-lsp-server",

      --   -- yaml
      --   "terraform-ls",
      --   "tflint",
      --   "yaml-language-server",
      --   "yamlfmt",
      --   "yamllint",

      --   -- sql
      --   "sqlfluff",
      --   "sqls",

      --   -- ocaml
      --   "ocaml-lsp",
      --   "ocamlformat",
      -- },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    git = {
      enable = true,
    },

    renderer = {
      highlight_git = true,
      icons = {
        show = {
          git = true,
        },
      },
    },

    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
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

  -- Copilot
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = { "InsertEnter", "BufEnter", "BufRead" },
  --   suggestion = { enabled = false },
  --   panel = { enabled = false },
  --   config = function()
  --     require("copilot").setup {}
  --   end,
  -- },

  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },

  -- Rainbow brackets plugin
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup {
        exclude = {
          filetypes = { "help", "dashboard", "dashpreview", "NvimTree", "vista", "sagahover" },
          buftypes = { "terminal", nofile },
        },
      }
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = {
      sources = {
        { name = "nvim_lsp", group_index = 2 },
        -- { name = "copilot", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 2 },
      },
    },
    dependencies = {
      -- {
      --   "zbirenbaum/copilot-cmp",
      --   config = function()
      --     require("copilot_cmp").setup()
      --   end,
      -- },
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
}
