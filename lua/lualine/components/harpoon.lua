local ok, harpoon = pcall(require, "harpoon")
local Path = require("plenary.path")
local function normalize_path(buf_name, root)
	return Path:new(buf_name):make_relative(root)
end

--- [TODO:description]
---@return table {current}
local function get_status()
	if not ok then
		return { current = nil, total = 0 }
	end

	local list = harpoon:list()
	local total = list:length()

	local bufname = normalize_path(vim.api.nvim_buf_get_name(0), list.config.get_root_dir())
	local _, idx = list:get_by_value(bufname)
	if type(idx) ~= "number" or idx < 1 or idx > total then
		return { current = nil, total = total }
	end
	return { current = idx, total = total }
end

--- Draw function called by lualine
---@return string
local function draw()
	local st = get_status()
	if st.total == 0 then
		return ""
	end
	local idx = st.current and tostring(st.current) or "?"
	return string.format("[%s/%d]", idx, st.total)
end

--- Only show when there is at least one mark
---@return boolean
local function cond()
	return get_status().total > 0
end

return function(opts)
	return draw()
	-- return {
	-- 	draw = draw,
	-- 	cond = opts.cond or cond,
	-- 	color = opts.color or { fg = "#89b4fa", gui = "bold" },
	-- }
end
