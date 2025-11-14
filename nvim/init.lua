vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 8
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "·", extends = "⟩", precedes = "⟨", nbsp = "␣" }
vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set("i", "<C-h>", "<Left>",  { silent = true })
vim.keymap.set("i", "<C-j>", "<Down>",  { silent = true })
vim.keymap.set("i", "<C-k>", "<Up>",    { silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { silent = true })

vim.pack.add({
    {src = "https://github.com/sainnhe/sonokai"},
    {src = "https://github.com/neovim/nvim-lspconfig"},
    {src = "https://github.com/nvim-treesitter/nvim-treesitter"},
    {src = "https://github.com/folke/flash.nvim"},
    {src = "https://github.com/saghen/blink.cmp"},
    {src = "https://github.com/nvim-mini/mini.pairs"},
    {src = "https://github.com/folke/which-key.nvim"},
    {src = "https://github.com/Eandrju/cellular-automaton.nvim"},
    {src = "https://github.com/ibhagwan/fzf-lua"}
})
require "flash".setup()
require("mini.pairs").setup()
require('blink.cmp').setup({
    fuzzy = { implementation = "lua" },
})
require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua","python","rust","ocaml","c" },
      highlight = { enable = false },
    })

-- fzf zoxide is followed with a fzf files
require('fzf-lua').setup({
  zoxide = {
    actions = {
      ["default"] = function(selected)
        local path = selected[1]
        require("fzf-lua").files({ cwd = path })
      end,
    },
  },
})


vim.keymap.set({ "n","x","o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set({ "n","x","o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set('n', '<leader>ff', ":FzfLua global<CR>")
vim.keymap.set('n', '<leader>fh', ":FzfLua helptags<CR>")
vim.keymap.set('n', '<leader>fj', ":FzfLua live_grep<CR>")
vim.keymap.set('n', '<leader>fd', ":FzfLua diagnostics_document<CR>")
vim.keymap.set('n', '<leader>fz', ":FzfLua zoxide<CR>")
vim.keymap.set('n', 'gr', vim.lsp.buf.references,    {desc='Refs'})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition,    {desc='Definition'})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,   {desc='Declaration'})
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,{desc='Implementation'})
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename,{desc='Rename'})
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action,{desc='Code action'})
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'Line diagnostics' })
vim.keymap.set('n', '<leader>li', function()
  local b = 0
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = b }), { bufnr = b })
end, { desc = 'Toggle inlay hints' })

vim.cmd [[set completeopt+=menuone,noselect,popup]]

vim.lsp.enable({"lua_ls", "clangd", "ocamllsp", "texlab"})

-- Needed because treesitter's highlight = false stops it from starting the parser
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "lua", "python", "rust", "ocaml" },
  callback = function()
    local ok, lang = pcall(vim.treesitter.language.get_lang, vim.bo.filetype)
    vim.treesitter.start(0, ok and lang or vim.bo.filetype)
  end,
})

vim.g.sonokai_style = 'andromeda'
vim.cmd("colorscheme sonokai")

-- Breaking bad muscle memory
vim.keymap.set({ "n","i","v","x","s","o","t","c" }, "<Up>", "<Nop>", { silent = true })
vim.keymap.set({ "n","i","v","x","s","o","t","c" }, "<Down>", "<Nop>", { silent = true })
vim.keymap.set({ "n","i","v","x","s","o","t","c" }, "<Left>", "<Nop>", { silent = true })
vim.keymap.set({ "n","i","v","x","s","o","t","c" }, "<Right>", "<Nop>", { silent = true })
vim.opt.mouse = ""
