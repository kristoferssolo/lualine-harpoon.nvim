local M = {}

function M.check()
	vim.health.start("lualine-harpoon")

	local has_lualine = pcall(require, "lualine")
	if has_lualine then
		vim.health.ok("lualine is installed")
	else
		vim.health.error("lualine is not installed")
	end

	local has_harpoon = pcall(require, "harpoon")
	if has_harpoon then
		vim.health.ok("harpoon is installed")
	else
		vim.health.warn("harpoon is not installed - component will show empty")
	end

	local has_plenary = pcall(require, "plenary.path")
	if has_plenary then
		vim.health.ok("plenary.nvim is installed (recommended)")
	else
		vim.health.warn("plenary.nvim is not installed - path normalization disabled")
	end
end

return M
