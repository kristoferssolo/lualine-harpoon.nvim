---@class LualineHarpoonConfig
---@field symbol LualineHarpoonSymbols
---@field icon string
---@field show_when_empty boolean
---@field format function?
---@field empty_text string?
---@field cache_timeout integer

---@class LualineHarpoonSymbols
---@field open string
---@field close string
---@field separator string
---@field unknown string

---@type LualineHarpoonConfig
local M = {
	symbol = {
		open = "[",
		close = "]",
		separator = "/",
		unknown = "?",
	},
	icon = "󰀱",
	show_when_empty = false,
	format = nil,
	empty_text = nil,
	cache_timeout = 100,
}

return M
