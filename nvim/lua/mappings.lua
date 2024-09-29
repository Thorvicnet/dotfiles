require "nvchad.mappings"
---@type MappingsConfig
local M = {}

M.general = {
    n = {
        -- Run the current c/cpp file
        ["<leader>ru"] = {":w<CR>:!clang % -o %:r && ./%:r<CR>", "Run the current c/cpp file"},
        -- Run the current ocaml file
        ["<leader>ro"] = {":w<CR>:!ocaml %<CR>", "Run the current ocaml file"},
    }
}

return M
