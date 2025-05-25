local ok, harpoon = pcall(require, "harpoon")
local utils = require("lualine-harpoon.utils")

---@class HarpoonStatus
---@field current integer? 1-based index of current file in harpoon list
---@field total integer Total number of files in harpoon list

---@class LualineHarpoonStatus
local M = {}

--- Get current 1-based index and total Harpoon marks
---@return HarpoonStatus
function M.get_status()
	if not ok then
		return { current = nil, total = 0 }
	end

	local success, list = pcall(function()
		return harpoon:list()
	end)

	if not success or not list then
		return { current = nil, total = 0 }
	end

	local total = list:length()
	if total == 0 then
		return { current = nil, total = 0 }
	end

	local success_root, root = pcall(function()
		return list.config.get_root_dir()
	end)

	if not success_root then
		return { current = nil, total = 0 }
	end

	local buf = vim.api.nvim_buf_get_name(0)
	local rel_buf = utils.normalize(buf, root)

	local success_get, idx = pcall(function()
		local _, index = list:get_by_value(rel_buf)
		return index
	end)
	if not success_get or type(idx) ~= "number" or idx < 1 or idx > total then
		idx = nil
	end
	return { current = idx, total = total }
end

return M
