---@class ChadrcConfig
local M = {}

M.ui = { theme = "tokyonight", transparency = false, nvdash = { load_on_startup = true } }

M.plugins = "plugins"

M.mappings = require "mappings"

return M
