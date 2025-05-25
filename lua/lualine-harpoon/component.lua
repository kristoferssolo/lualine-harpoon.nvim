local status = require("lualine-harpoon.status")
local cfg = require("lualine-harpoon.config")

local req = require("lualine_require")
local Component = req.require("lualine.component")

---@class LualineHarpoonComponent
---@field cache LualineHarpoonCache
---@field options LualineHarpoonConfig
local M = Component:extend()

---@class LualineHarpoonCache
---@field result string?
---@field is_valid boolean
---@field last_buf string?
---@field last_changedtick integer?
---@field last_status_hash string?

---@param opts table?
function M:init(opts)
	M.super:init(opts)
	self.options = vim.tbl_deep_extend("force", cfg, self.options or {})

	self.cache = {
		result = nil,
		is_valid = false,
		last_buf = nil,
		last_changedtick = nil,
		last_status_hash = nil,
	}

	self:setup_cache_invalidation()
end

---@private
function M:setup_cache_invalidation()
	local group_name = "LualineHarpoon_" .. tostring(self)
	local group = vim.api.nvim_create_augroup(group_name, { clear = true })

	vim.api.nvim_create_autocmd({
		"BufEnter",
		"BufWritePost",
		"User",
	}, {
		group = group,
		callback = function()
			self.cache.is_valid = false
		end,
	})
end

---@param st HarpoonStatus
---@return string
function M:hash_status(st)
	return string.format("%s:%s", tostring(st.current or "nil"), st.total)
end

---@return boolean
function M:is_cache_valid()
	if not self.cache.is_valid then
		return false
	end

	local current_buf = vim.api.nvim_buf_get_name(0)
	local current_changetick = vim.api.nvim_buf_get_changedtick(0)

	if self.cache.last_buf ~= current_buf or self.cache.last_changedtick ~= current_changetick then
		return false
	end

	local current_status = status.get_status()
	local current_hash = self:hash_status(current_status)

	return self.cache.last_status_hash == current_hash
end

---@param new_cfg LualineHarpoonConfig
function M.upadte_config(new_cfg)
	cfg = new_cfg
end

---@param result string
---@private
function M:update_cache(result)
	local current_status = status.get_status()

	self.cache.result = result
	self.cache.is_valid = true
	self.cache.last_buf = vim.api.nvim_buf_get_name(0)
	self.cache.last_changedtick = vim.api.nvim_buf_get_changedtick(0)
	self.cache.last_status_hash = self:hash_status(current_status)
end

---@return string
function M:update_status()
	if self:is_cache_valid() then
		return self.cache.result
	end

	local st = status.get_status()
	local result = ""

	-- Handle custom format function
	if type(self.options.format) == "function" then
		result = self.options.format(st.current, st.total)
	elseif st.total > 0 then
		-- Default formatting when we have marks
		local s = self.options.symbol
		local n = st.current and tostring(st.current) or s.unknown
		result = string.format("%s%s%s%d%s", s.open, n, s.separator, st.total, s.close)
	elseif self.options.show_when_empty then
		-- Show something when no marks exist, but only if show_when_empty is true
		local s = self.options.symbol
		if type(self.options.empty_text) == "string" then
			result = self.options.empty_text
		end
		result = string.format("%s0%s0%s", s.open, s.separator, s.close)
	end

	self:update_cache(result)
	return result
end

---@return string
function M:draw_status()
	local text = self:update_status()
	if self.color_hl and text ~= "" then
		return self.color_hl(text)
	end
	return text
end

return M
