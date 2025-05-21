local status = require("lualine-harpoon.status")
local cfg = require("lualine-harpoon.config")

local req = require("lualine_require")
local Component = req.require("lualine.component")

local M = Component:extend()

function M:init(opts)
	M.super.init(self, opts)
	self.options = vim.tbl_deep_extend("force", cfg, self.options or {})
end

function M:update_status()
	local st = status.get_status()
	if st.total == 0 then
		return ""
	end
	local s = self.options.symbol
	local n = st.current and tostring(st.current) or s.unknown
	return string.format("%s%s%s%d%s", s.open, n, s.separator, st.total, s.close)
end

function M:draw_status()
	local text = self:update_status()
	if self.color_hl and text ~= "" then
		return self.color_hl(text)
	end
	return text
end

return M
