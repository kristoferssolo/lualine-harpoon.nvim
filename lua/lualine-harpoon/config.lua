---@class LualineHarpoonConfig
---@field symbol LualineHarpoonSymbols
---@field icon string
---@field show_when_empty boolean
---@field show_icon boolean
---@field format function?
---@field colors LualineHarpoonColors
---@field cache_timeout integer

---@class LualineHarpoonSymbols
---@field open string
---@field close string
---@field separator string
---@field unknown string

---@class LualineHarpoonColors
---@field active string?
---@field inactive string?

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
	show_icon = true,
	format = nil,
	colors = {
		active = nil,
		inactive = nil,
	},
	cache_timeout = 100,
}

return M
