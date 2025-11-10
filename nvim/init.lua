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
vim.opt.winborder = "rounded"

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y<CR>')
vim.keymap.set({'n', 'v'}, '<leader>d', '"+d<CR>')

vim.pack.add({
		{src = "https://github.com/sainnhe/sonokai"},
		-- {src = "https://github.com/stevearc/oil.nvim"},
		{src = "https://github.com/nvim-mini/mini.pick"},
		{src = "https://github.com/neovim/nvim-lspconfig"},
		{src = "https://github.com/nvim-treesitter/nvim-treesitter"},
		{src = "https://github.com/folke/flash.nvim"},
		{src = "https://github.com/saghen/blink.cmp"},
		{src = "https://github.com/nvim-mini/mini.pairs"}
})
require "mini.pick".setup()
-- require "oil".setup()
require "flash".setup()
require("mini.pairs").setup()
require('blink.cmp').setup({
				fuzzy = { implementation = "lua" },
})
require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua","python","rust","ocaml","c" },
      highlight = { enable = false },
    })

vim.keymap.set({ "n","x","o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set({ "n","x","o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
vim.keymap.set('n', '<leader>e', ":Oil<CR>")
vim.lsp.enable({"lua_ls", "clangd", "ocamllsp"})
vim.keymap.set('n', 'gr', vim.lsp.buf.references,    {desc='Refs'})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition,    {desc='Definition'})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,   {desc='Declaration'})
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,{desc='Implementation'})
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename,{desc='Rename'})
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action,{desc='Code action'})
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>li', function()
  local b = 0
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = b }), { bufnr = b })
end, { desc = 'Toggle inlay hints' })

vim.cmd [[set completeopt+=menuone,noselect,popup]]

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
