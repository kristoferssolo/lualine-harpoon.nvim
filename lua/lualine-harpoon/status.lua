local ok, harpoon = pcall(require, "harpoon")
local utils = require("lualine-harpoon.utils")
local M = {}

--- Get current 1-based index and total Harpoon marks
---@return { current: integer?, total: integer }
function M.get_status()
	if not ok then
		return { current = nil, total = 0 }
	end

	local list = harpoon:list()
	local total = list:length()

	if total == 0 then
		return { current = nil, total = 0 }
	end

	local root = list.config.get_root_dir()
	local buf = vim.api.nvim_buf_get_name(0)
	local rel_buf = utils.normalize(buf, root)

	local _, idx = list:get_by_value(rel_buf)
	if type(idx) ~= "number" or idx < 1 or idx > total then
		idx = nil
	end
	return { current = idx, total = total }
end

return M
