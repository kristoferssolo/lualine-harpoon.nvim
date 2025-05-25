---@class LualineHarpoonUtils
local M = {}

---Normalize `buf` relative to `root` using Neovim built-ins
---@param buf string Absolute path to buffer
---@param root string Root directory path
---@return string Normalized path relative to root
function M.normalize(buf, root)
	if not buf or buf == "" then
		return ""
	end

	if not root or root == "" then
		return buf
	end

	-- Use vim.fs.normalize for consistent path separators (Neovim 0.8+)
	if vim.fs and vim.fs.normalize then
		buf = vim.fs.normalize(buf)
		root = vim.fs.normalize(root)
	end

	-- Use vim.fn.fnamemodify to make path relative
	local relative = vim.fn.fnamemodify(buf, ":p:.")

	-- If the buffer is within the root directory, make it relative to root
	if buf:find("^" .. vim.pesc(root), 1) then
		relative = buf:sub(#root + 1)
		-- Remove leading path separator
		relative = relative:gsub("^[/\\]", "")
		return relative ~= "" and relative or "."
	end

	return relative
end

return M
