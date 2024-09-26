---@type MappingsConfig
local M = {}

M.general = {
    n = {
        -- Run the current file
        ["<leader>ru"] = {":w<CR>:!clang % -o %:r && ./%:r<CR>", "Run the current file"},
    }
}

return M
