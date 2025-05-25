---@class LualineHarpoonHealth
local M = {}

---@return nil
function M.check()
	vim.health.start("lualine-harpoon")

	-- Check for required dependencies
	local has_lualine, lualine_version = pcall(require, "lualine")
	if has_lualine then
		vim.health.ok("lualine is installed")
		if lualine_version and lualine_version.version then
			vim.health.info("lualine version: " .. lualine_version.version)
		end
	else
		vim.health.error("lualine is not installed")
	end

	local has_harpoon, harpoon_module = pcall(require, "harpoon")
	if has_harpoon then
		vim.health.ok("harpoon is installed")
		-- Check if it's harpoon 2.x
		if harpoon_module and harpoon_module.list then
			vim.health.info("harpoon 2.x detected")
		else
			vim.health.warn("harpoon 1.x detected - may not be fully compatible")
		end
	else
		vim.health.warn("harpoon is not installed - component will show empty")
	end

	-- Check Neovim version
	local nvim_version = vim.version()
	if nvim_version.major == 0 and nvim_version.minor < 8 then
		vim.health.error("Neovim 0.8+ is required")
	else
		vim.health.ok(string.format("Neovim %d.%d.%d", nvim_version.major, nvim_version.minor, nvim_version.patch))
	end
end

return M
