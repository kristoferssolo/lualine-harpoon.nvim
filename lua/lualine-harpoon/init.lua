local component = require("lualine-harpoon.component")
local cfg = require("lualine-harpoon.config")

---@class LualineHarpoonPlugin
---@field component LualineHarpoonComponent
local M = {
	component = component,
}

---@param opts LualineHarpoonConfig?
---@return nil
function M.setup(opts)
	opts = opts or {}

	-- Validate options
	if opts.cache_timeout and type(opts.cache_timeout) ~= "number" then
		vim.notify("lualine-harpoon: cache_timeout must be a number", vim.log.levels.WARN)
		opts.cache_timeout = nil
	end

	if opts.format and type(opts.format) ~= "function" then
		vim.notify("lualine-harpoon: format must be a function", vim.log.levels.WARN)
		opts.format = nil
	end

	---@type LualineHarpoonConfig
	local updated_cfg = vim.tbl_deep_extend("force", cfg, opts)

	component.upadte_config(updated_cfg)
end

return M
