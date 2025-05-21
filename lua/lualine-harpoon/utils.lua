local ok_path, Path = pcall(require, "plenary.path")
local M = {}

--- Normalize `buf` relative to `root`, if plenary.path is available.
---@param buf string
---@param root string
---@return string
function M.normalize(buf, root)
	if ok_path then
		return Path:new(buf):make_relative(root)
	else
		return buf
	end
end

return M
