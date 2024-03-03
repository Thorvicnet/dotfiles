local plugins = {
  -- Override plugin definition options

  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "custom.plugins.lsp.null-ls"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.plugins.lsp.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lsp"
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
      },
      indent = {
        enable = true,
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- markdown
        "marksman",
        "misspell",

        -- lua
        "lua-language-server",
        "stylua",

        -- web dev
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "prettier",

        -- docker
        "dockerfile-language-server",
        "docker-compose-language-service",

        -- rust
        "rust-analyzer",
        "rustfmt",

        -- go
        "gopls",
        "glint",
        "go-debug-adapter",
        "goimports",
        "goimports-reviser",
        "golangci-lint",
        "golangci-lint-langserver",
        "golines",
        "gotests",
        "gotestsum",

        -- python
        "pyright",
        "flake8",
        "black",
        "mypy",
        "pydocstyle",
        "pylint",
        "pyre",
        "autoflake",
        "autopep8",
        "python-lsp-server",

        -- yaml
        "terraform-ls",
        "tflint",
        "yaml-language-server",
        "yamlfmt",
        "yamllint",

        -- sql
        "sqlfluff",
        "sqls",
      },
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
  },

  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "InsertEnter", "BufEnter", "BufRead" },
    suggestion = { enabled = false },
    panel = { enabled = false },
    config = function()
      require("copilot").setup {}
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Rainbow brackets plugin
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("indent_blankline").setup {
        use_treesitter = true,
        filetype_exclude = { "help", "dashboard", "dashpreview", "NvimTree", "vista", "sagahover" },
        buftype_exclude = { "terminal", "nofile" },
      }
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = {
      sources = {
        { name = "nvim_lsp", group_index = 2 },
        { name = "copilot", group_index = 2 },
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 2 },
      },
    },
    dependencies = {
      {
        "zbirenbaum/copilot-cmp",
        config = function()
          require("copilot_cmp").setup()
        end,
      },
    },
  },
}

return plugins
