-- Colorscheme
-- with Treesitter, Typescript, LSP supported
-- colors from colorsx cloud (defunct website)
local colors = require("colors")
local s = require("style")

-- Merge a list of list-like tables togeter
-- { {'x'}, {'y'} } -> {'x', 'y'}
local merge = function(list)
	local acc = {}

	for _, result in ipairs(list) do
		if result ~= nil then
			vim.list_extend(acc, result)
		end
	end

	return acc
end

-- param groups table list of Groups to apply the highlights
local highlight_to_groups = function(highlight)
	-- param highlight table 3 element table { fg colorbuddy.Color, bg colorbuddy.Color, styles colorbuddy.Styles }
	return function(groups)
		local acc = {}

		for _, name in ipairs(groups) do
			if type(name) == "table" then
				-- name
				-- { "TSName", link = "@name" }
				table.insert(acc, { name[0], highlight[1], highlight[2], highlight[3], link = name["link"] })
			else
				-- name
				--  "TSName"
				table.insert(acc, { name, highlight[1], highlight[2], highlight[3] })
			end
		end

		return acc
	end
end

-- Used in tuning colors to be more base 16 based
-- This will allow us to have our scheme work with base 16 colors that could
-- be dynamically added
local default = function()
	return {
		"#282a2e", -- 0
		"#a54242",
		"#8c9440",
		"#de935f",
		"#5f819d", -- 4
		"#85678f",
		"#5e8d87",
		"#707880",
		"#373b41", -- 8
		"#cc6666",
		"#b5bd68",
		"#f0c674",
		"#81a2be", -- 12
		"#b294bb",
		"#8abeb7",
		"#c5c8c6", -- 15
	}
end

local boo_lora = function()
	return {
		"#08413f", -- 0 #08413f
		"#9e1f0a", -- #9e1f0a
		"#074c0e", -- #074c0e
		"#c2ef36", -- #c2ef36
		"#142d5a", -- 4 #142d5a
		"#4a1f61", -- #4a1f61
		"#23d1c5", -- #23d1c5
		"#064341", -- #064341
		"#373b41", -- 8
		"#a32d2e", --  #a32d2e
		"#17bb20", -- #17bb20
		"#c1ff92", -- #c1ff92
		"#f0c674", -- 12 #07262e
		"#5c1847", --    #5c1847
		"#19d190", --    #19d190
		"#13cdc6", -- 15 #13cdc6
	}
end

-- Cloud colors
local cloud = function()
	return {
		"#222827", -- 0
		"#d5a8e4",
		"#9c75dd",
		"#9898ae",
		"#654a96", -- 4
		"#625566",
		"#a9d1df",
		"#e6ebe5",
		"#5d6f74", -- 8
		"#cd749c",
		"#63b0b0",
		"#c0c0dd",
		"#5786bc", -- 12
		"#3f3442",
		"#849da2",
		"#d9d6cf", -- 15
	}
end

local forest_stream = function()
	return {
		"#0d1f0f",
		"#caade1",
		"#7a77cd",
		"#2f594c",
		"#42647f",
		"#3e4d45",
		"#89d9d0",
		"#e8f4e7",
		"#3c7153",
		"#c7566f",
		"#41b193",
		"#a5c1cd",
		"#3788a2",
		"#243528",
		"#609f83",
		"#f0f4e7",
	}
end

local crimson_moonlight = function()
	return {
		"#201c1c",
		"#fca2ae",
		"#e15774",
		"#bc969a",
		"#714e75",
		"#6c494d",
		"#e9bfc4",
		"#f9f1f2",
		"#796769",
		"#dd5571",
		"#d19299",
		"#dfb8bc",
		"#b96a76",
		"#473234",
		"#ab9295",
		"#f9f2f3",
	}
end

local sunset_cloud = function()
	return {
		"#262904",
		"#cd6d91",
		"#947fbc",
		"#8d9a59",
		"#655a7c",
		"#5e4531",
		"#71d17c",
		"#e0ec7a",
		"#5d6f74",
		"#bc5050",
		"#4eae6e",
		"#bbc373",
		"#40719c",
		"#3c2e1a",
		"#809d7b",
		"#dad36d",
	}
end

local radioactive = function()
	return {
		"#282822",
		"#e3e3a8",
		"#56417a",
		"#aeae98",
		"#7b6c97",
		"#666655",
		"#dfdfa9",
		"#a39778",
		"#74745d",
		"#cd749c",
		"#a38c78",
		"#bbbc57",
		"#bbbc57",
		"#424234",
		"#a2a284",
		"#d9d9cf",
	}
end

local vimscript = function(c)
	return {
		{ "vimcommand", c.cloud4 },
		{ "vimmap", c.cloud4 },
		{ "vimbracket", c.cloud10 },
		{ "vimmapmodkey", c.cloud6 },
		{ "vimnotation", c.cloud6 },
		{ "vimmaplhs", c.cloud10 },
		{ "vimiscommand", c.cloud10:light() },
		{ "vimFilter", c.cloud7 },
		{ "vimMapRhs", c.cloud15:dark(0.1) },
		{ "vimMapRhsExtend", c.cloud15:dark(0.1) },

		{ "vimlet", c.cloud4:dark() },
		{ "vimnotfunc", c.cloud4:dark() },
		{ "vimAutoCmdSfxList", c.cloud6 },
		{ "vimUserFunc", c.cloud10 },
		{ "vimSetEqual", c.cloud6 },
	}
end

local diagnostics = function(c)
	return {
		{ "DiagnosticHint", c.cloud13:saturate(0.05):light(0.1), c.cloud13:dark(0.9) },
		{
			"DiagnosticError",
			c.cloud1:saturate(0.05):lighten_to(0.7),
			c.none,
		},
		{
			"DiagnosticWarn",
			c.cloud11,
			c.none,
		},
		{ "DiagnosticInfo", c.fg },
		-- {
		-- 	"DiagnosticUnderlineHint",
		-- 	c.none,
		-- 	c.none,
		-- 	s.underline,
		-- 	c.cloud13:saturate(0.05):lighten_to(0.2),
		-- },
		-- {
		-- 	"DiagnosticUnderlineError",
		-- 	c.none,
		-- 	c.none,
		-- 	s.underline,
		-- 	c.cloud1:saturate(0.05):lighten_to(0.9),
		-- },
		-- {
		-- 	"DiagnosticUnderlineWarn",
		-- 	c.none,
		-- 	c.none,
		-- 	s.underline,
		-- 	c.cloud6:lighten_to(0.9),
		-- },
		-- {
		-- 	"DiagnosticUnderlineInfo",
		-- 	c.none,
		-- 	c.none,
		-- 	s.underline,
		-- 	c.fg:lighten_to(0.1),
		-- },
	}
end

local diff = function(c)
	return {
		{ "diffAdded", c.none, c.cloud6:lighten_to(0.1):desaturate_to(0.2) },
		{ "diffRemoved", c.none, c.cloud1:lighten_to(0.1):desaturate_to(0.2) },
		{ "diffChanged", c.none, c.cloud2:lighten_to(0.1):desaturate_to(0.2) },
		{ "DiffAdd", c.none, c.cloud6:lighten_to(0.1):desaturate_to(0.2) },
		{ "DiffDelete", c.none, c.cloud1:lighten_to(0.1):desaturate_to(0.2) },
		{ "DiffChange", c.none, c.cloud2:lighten_to(0.1):desaturate_to(0.2) },
		{ "DiffText", c.cloud7 },
	}
end

local lsp = function(c)
	return {
		{ "LspReferenceText", c.cloud6:lighten_to(0.9):desaturate_to(0.5) },
		{ "LspReferenceRead", c.none, c.cloud12:lighten_to(0.1) },
		{ "LspReferenceWrite", c.none, c.cloud12:lighten_to(0.1) },

		{ "LspInlayHint", c.cloud12:lighten_to(0.3):desaturate_to(0.3) },
	}
end

local lsp_semantic_tokens = function()
	return {
		{ "LspParameter", nil, nil, s.italic },
	}
end

local cmp = function(c)
	return {
		{ "CmpItemMenu", c.cloud0:dark(0.01) },
		{ "CmpItemAbbr", c.cloud4 },
		{ "CmpItemAbbrMatch", c.cloud2 },
		{ "CmpItemAbbrMatchFuzzy", c.cloud2 },
		{ "CmpItemKind", c.cloud0:dark(0.01) },
	}
end

local telescope = function(c)
	return {
		{ "TelescopeBorder", c.bg:lighten_to(0.3) },
		{ "TelescopeNormal", c.cloud0:light(0.3) },
		{ "TelescopePromptPrefix", c.cloud10:dark(0.2) },

		{ "TelescopeSelection", c.cloud10:light(), c.cloud8:dark(0.2), s.bold },
		{ "TelescopeMatching", c.cloud4:light() },
	}
end

local markdown = function(c)
	local to_groups = highlight_to_groups({ c.cloud5:lighten_by(1), c.cloud5:lighten_to(0.2) })
	local delimiters = to_groups({
		"markdownH1Delimiter",
		"markdownH2Delimiter",
		"markdownH3Delimiter",
		"markdownH4Delimiter",
		"markdownH5Delimiter",
		"markdownH6Delimiter",
	})

	local hbg = c.cloud0:lighten_by(1)

	return merge({
		delimiters,
		{
			{ "markdownh1", c.cloud6:light():saturate(0.7), hbg, s.bold },
			{ "markdownh2", c.cloud6:saturate(0.7), hbg, s.bold },
			{ "markdownh3", c.cloud6:dark(), hbg, s.bold },
			{ "markdownh4", c.cloud6:dark(), hbg, s.bold },
			{ "markdownh5", c.cloud6:dark(), hbg, s.bold },

			{ "markdownCodeDelimiter", c.cloud8:dark(), c.cloud0:dark(0.1) },
			{ "markdownCode", c.cloud4, c.cloud0:dark(0.1) },
			{ "markdownUrl", c.cloud14 },
			{ "markdownLinkText", c.cloud10 },

			{ "markdownLinkTextDelimiter", c.cloud8 },
			{ "markdownLinkDelimiter", c.cloud8 },
		},
	})
end

local symbols_outline = function(c)
	return {
		{ "FocusedSymbol", c.none, c.cloud10:dark(0.4):desaturate_to(0.1), s.bold },
	}
end

local nvim_dap_virtual_text = function(c)
	return {

		{ "NvimDapVirtualText", c.cloud4:lighten_to(0.4), c.none, s.italic },
	}
end

local nvim_dap_ui = function(c)
	return {
		{ "DapUIValue", "@variable" },
		{ "DapUIFrameName", "Normal" },
		{ "DapUIVariable", "@variable" },

		{ "DapUIScope", c.cloud14:light(0.1) },
		{ "DapUIType", c.cloud13:lighten_to(0.4) },
		{ "DapUIModifiedValue", c.cloud14:light(0.1), c.none, s.bold },
		{ "DapUIDecoration", c.cloud14:light(0.1) },
		{ "DapUIThread", c.cloud11 },
		{ "DapUIStoppedThread", c.cloud14 },
		{ "DapUISource", c.cloud13 },
		{ "DapUILineNumber", c.cloud14:light(0.1) },
		{ "DapUIFloatBorder", c.cloud14:light(0.1) },
		{ "DapUIWatchesEmpty", c.cloud9 },
		{ "DapUIWatchesValue", c.cloud10 },
		{ "DapUIWatchesError", c.cloud9 },
		{ "DapUIBreakpointsPath", c.cloud14:light(0.1) },
		{ "DapUIBreakpointsInfo", c.cloud10 },
		{ "DapUIBreakpointsCurrentLine", c.cloud10, c.none, s.bold },
		{ "DapUIBreakpointsDisabledLine", c.cloud15 },

		{ "DapUIBreakpointsLine", "DapUILineNumber" },
	}
end

local harpoon = function(c)
	return {
		{ "HarpoonBorder", c.bg:lighten_to(0.3) },
	}
end

local treesitter = function(c)
	local error = { "TSError" }

	local punctuation = {
		"TSPunctDelimiter",
		"TSPunctBracket",
		"TSPunctSpecial",
		"@punctuation.delimiter",
		"@punctuation.bracket",
		"@punctuation.special",
	}

	local constants = {
		"TSConstant",
		"TSConstBuiltin",
		"TSConstMacro",
		"@constant",
		"@constant.builtin",
		"@constant.macro",
	}

	local constructors = { "TSConstructor", "@constructor" }

	local string = {
		"TSStringRegex",
		"TSString",
		"TSStringEscape",
		"TSStringSpecial",
		"@string.regex",
		"@string",
		"@string.escape",
		"@string.special",
	}

	local boolean = { "TSBoolean", "@boolean" }

	local functions = {
		"TSFunction",
		"TSFuncBuiltin",
		"TSFuncMacro",
		"@function",
		"@function.builtin",
		"@function.macro",
	}

	local function_calls = { "@function.call" }

	local attributes = { "@attribute" }

	local methods = { "TSMethod", "@method", "@method.call" }
	--
	-- local fields = { "TSField", "TSProperty", "@field", "@property" }
	--
	-- local number = { "TSNumber", "TSFloat", "@number", "@float" }

	local parameters = { "TSParameter", "TSParameterReference", "@parameter", "@parameter.reference" }

	-- local operators = { "TSOperator", "@operator" }

	local forwords = { "TSConditional", "TSRepeat", "@conditional", "@repeat" }

	local keyword = {
		"TSKeyword",
		"TSKeywordFunction",
		"TSKeywordReturn",
		"TSKeywordOperator",
		"@keyword",
		"@keyword.function",
		"@keyword.operator",
		"@keyword.return",
	}

	-- local labels = { "TSLabel", "@label" }

	local types = { "TSType", "TSTypeBuiltin", "@type", "@type.builtin", "@type.qualifier", "@type.defintion" }

	local namespaces = { "TSNamespace", "@namespace" }

	local includes = { "TSInclude", "@include" }

	local variables = { "TSVariable", "TSVariableBuiltin", "@variable", "@variable.builtin" }

	local tags = { "TSTag", "TSTagDelimiter", "@tag" }

	local tag_punctuation = { "@tag.delimiter" }
	local tag_fields = { "@tag.attribute" }

	local text = {
		"TSText",
		"TSStrong",
		"TSEmphasis",
		"TSUnderline",
		"TSLiteral",
		"TSURI",
		"@text",
		"@text.string",
		"@text.emphassis",
		"@text.underline",
		"@text.strike",
		"@text.title",
		"@text.literal",
		"@text.math",
		"@text.reference",
		"@text.environment",
		"@text.environment.name",
	}

	local uri = { "@text.uri" }

	local title = { "TSTitle" }

	local groups = {
		{ attributes, c.cloud7:lighten_to(0.4):desaturate(0.3) },
		{ error, c.cloud1:light(), c.cloud9:dark(0.5), s.none },
		{ punctuation, c.cloud3:lighten_to(0.4):desaturate(0.1) },
		{ constants, c.cloud5:light(0.1) },
		{ string, c.cloud10:lighten_to(0.9):desaturate_to(0.5) },
		{ uri, c.cloud10:lighten_to(0.4):desaturate_to(0.3) },
		{ boolean, c.cloud2:light(0.1) },
		-- { functions, c.cloud14:saturate(0.2) },
		{ { "@function" }, c.cloud14:desaturate_to(0.2), c.none, s.italic },
		{ function_calls, c.cloud14:lighten_to(0.5):desaturate_to(0.4), c.none, s.italic },

		{ methods, c.cloud14:lighten_to(0.5):desaturate_to(0.4), c.none, s.italic },
		-- { fields, c.cloud10:lighten_to(0.5):desaturate_to(0.1) },
		-- { number, c.cloud6:lighten_to(0.8):desaturate_to(0.1) },
		{ parameters, c.cloud6:dark() },
		-- { operators, c.cloud3:lighten_to(0.4):desaturate(0.1) },
		{ forwords, c.cloud8:saturate(0.1), c.none },
		{ keyword, c.cloud4:lighten_to(0.45), c.none, s.italic },
		{ { "@keyword.function" }, c.cloud4:lighten_to(0.45), c.none, s.italic },

		{ constructors, c.cloud10 },
		{ types, c.cloud10 },
		{ includes, c.cloud4 },
		-- { labels, c.cloud4 },
		{ namespaces, c.cloud14:light(0.1) },
		{ variables, c.cloud6:lighten_to(0.7):desaturate_to(0.4) },
		{ tags, c.cloud10:light(0.1) },
		{ tag_punctuation, c.cloud3:lighten_to(0.4):desaturate(0.1) },
		{ tag_fields, c.cloud10:lighten_to(0.5):desaturate_to(0.1) },
		{ text, c.fg },
		{ title, c.cloud10:desaturate_to(0.1) },
	}

	local highlights = {}

	-- Apply grouping to each color group
	for _, group in ipairs(groups) do
		highlights = merge({ highlights, highlight_to_groups({ group[2], group[3], group[4] })(group[1]) })
	end

	return merge({
		highlights,
		{
			{ "@punctuation.delimiter", c.cloud3:desaturate_to(0.05):lighten_to(0.4) },
			{ "@punctuation.special", c.cloud12:desaturate_to(0.1):lighten_to(0.5) },
			{ "@tag.delimiter", c.cloud8:dark(0.15) },
			{ "@variable.builtin", c.cloud6:dark(), c.none, s.bold },
			{ "@constant.builtin", c.cloud6:dark(0.3), c.none, s.bold },

			{ "@function.builtin", c.cloud10:dark(0.2), c.none, s.bold },
			{ "@type.builtin", c.cloud8:light(0.1), c.none, s.bold },

			{ "@variable.builtin", c.cloud12:lighten_to(0.4) },
			-- { "@field", c.cloud7 },

			{ "TSPunctDelimiter", "@punctuation.delimiter" },
			{ "TSPunctSpecial", "@punctuation.special" },

			{ "TSTagDelimiter", "@tag.delimiter" },

			{ "TSConstBuiltin", "@constant.builtin" },
			{ "TSVariableBuiltin", "@variable.builtin" },

			{ "TSFuncBuiltin", "@function.builtin" },
			{ "TSTypeBuiltin", "@type.builtin" },

			{ "TSVariableBuiltin", "@variable.builtin" },

			-- { "TSField", "@field" },

			-- { "TSNodeKey", c.cloud10 },
			-- { "TSNodeUnmatched", c.cloud8:dark(0.2) },
		},
	})
end

--[[ How this works:
--  We create a data structure that is a list of 4 item tables
--  { { group, fg, bg, styles }, ... }
--]]
local colorscheme = function(c)
	local vim_groups = {
		{ "Normal", c.fg:dark(0.01), c.bg:light(0.01) },

		-- Conceal
		{ "Conceal", c.cloud3:light() },

		{ "VertSplit", c.cloud0 },

		{ "Function", c.cloud8, c.none, s.bold },

		{ "Error", c.cloud9, c.none, s.bold },
		{ "ErrorMsg", c.cloud1:dark():saturate(0.1), c.cloud1:dark(0.7):saturate(0.1):dark(0.05) },

		{
			"WarningMsg",
			c.cloud11,
			-- c.cloud12:dark(0.3)
		},
		{ "Exception", c.cloud9 },

		{ "Boolean", c.cloud2:dark() },
		{ "Character", c.cloud14 },
		{ "Comment", c.cloud14:desaturate_to(0.2):lighten_to(0.5) },
		{ "Conditional", c.cloud10 },
		{ "Constant", c.cloud4 },

		{ "Float", c.cloud4 },

		{ "NormalFloat", c.cloud6:desaturate_to(0.8), c.cloud0:lighten_to(0.05):desaturate_to(0.0) },

		-- Search
		{ "IncSearch", c.cloud10:light(), c.cloud10:dark(0.5), s.italic },
		{ "Search", c.none, c.cloud10:dark(0.4):desaturate_to(0.1), s.bold },

		-- Numbers
		{ "Number", c.cloud15 },

		{ "Define", c.cloud10 },

		{ "Delimiter", c.cloud3:dark():dark():saturate(0.1) },

		{ "Directory", c.cloud4 },

		{ "Function", c.cloud8 },

		-- Folds
		{ "Folded", c.cloud3:dark(0.3) },
		{ "FoldColumn", c.cloud3:light() },

		-- Diff
		{ "DiffAdd", c.none, c.cloud10 },
		{ "DiffChange", c.none, c.cloud12 },
		{ "DiffDelete", c.none, c.cloud9 },
		{ "DiffText", c.none, c.cloud3 },

		{ "Identifier", c.cloud14 },
		{ "Structure", c.cloud10 },

		{ "Include", c.cloud10 },

		{ "Keyword", c.cloud4, c.none, s.italic },

		{ "Label", c.cloud10, c.none, s.italic },

		{ "Operator", c.cloud3:lighten_to(0.4):desaturate(0.1) },

		{ "PreProc", c.cloud10 },

		{ "Repeat", c.cloud12:dark() },

		{ "Statement", c.cloud10 },
		{ "StorageClass", c.cloud10 },
		{ "String", c.cloud14 },
		{ "Tag", c.cloud4 },

		{ "Title", c.cloud4, c.none },

		{ "Todo", c.cloud13 },

		{ "Type", c.cloud10:light(), c.none, s.italic },
		{ "Typedef", c.cloud10 },

		-- Side Column
		{ "CursorColumn", c.cloud4:desaturate_to(0.1), c.none, s.NONE, "20" },
		{ "LineNr", c.cloud10:desaturate_to(0.05):lighten_to(0.3) },
		{ "CursorLineNr", c.cloud5 },
		{ "Line", c.cloud12 },
		{ "SignColumn", c.none },

		{ "ColorColumn", c.none, c.cloud4:desaturate_to(0.1):lighten_to(0.1) },
		{ "Cursor", c.cloud0, c.cloud4 },
		{ "CursorLine", c.none, c.cloud0 },
		{ "iCursor", c.cloud0, c.cloud4 },

		{ "EndOfBuffer", c.cloud3, c.none },

		{ "MatchParen", c.none, c.cloud13:dark() },

		{ "NonText", c.bg:light(0.1), c.none },
		{ "Whitespace", c.bg:light(0.1), c.none },

		-- Popup Menu
		{ "PMenu", c.cloud2:light(), c.cloud5:dark(0.3) },
		{ "PmenuSbar", c.cloud4, c.cloud0:dark() },
		{ "PMenuSel", c.none, c.cloud0:lighten_to(0.15) },
		{ "PmenuThumb", c.cloud8, c.cloud3 },

		-- Special
		{ "Special", c.cloud4 },
		{ "SpecialChar", c.cloud13 },
		{ "SpecialKey", c.cloud13 },
		{ "SpecialComment", c.cloud8 },

		-- Spell
		{ "SpellBad", c.cloud11, c.none, s.undercurl },
		{ "SpellCap", c.cloud13, c.none, s.undercurl },
		{ "SpellLocal", c.cloud5, c.none, s.undercurl },
		{ "SpellRare", c.cloud6, c.none, s.undercurl },

		-- Statusline
		{ "StatusLine", c.cloud10, c.cloud8:dark(0.2) },
		{ "StatusLineNC", c.cloud4, c.cloud8:dark(0.3) },

		-- Tabline
		{ "TabLine", c.cloud2, c.cloud0:dark() },
		{ "TabLineSel", c.cloud10:light(), c.cloud13, s.bold },
		{ "TabLineFill", c.cloud2, c.cloud0:dark() },

		{ "Question", c.cloud10, c.none, s.bold },

		-- Visual
		{ "Visual", c.cloud10, c.cloud13:dark(0.2) },
		{ "VisualNOS", c.cloud2, c.cloud1 },
	}

	-- M:ale()

	return merge({
		vim_groups,
		lsp(c),
		lsp_semantic_tokens(),
		diagnostics(c),
		treesitter(c),
		markdown(c),
		vimscript(c),
		cmp(c),
		telescope(c),
		harpoon(c),
		symbols_outline(c),
		nvim_dap_virtual_text(c),
		nvim_dap_ui(c),
		diff(c),
	})
end

local M = {}

-- TODO: Simplify what happens at this stage if we are using nvim_set_hi
-- we can define the styles, fg, bg and others by their name
M.apply = function(c)
	-- local cmd = string.format("highlight %s guifg=%s guibg=%s gui=%s guisp=%s", c[1], c[2], c[3], c[4], c[5])
	-- if c[6] then
	-- cmd = string.format("%s blend=%s", cmd, c[6])
	-- end
	-- vim.cmd(cmd)
	local val = {}

	if c[2] ~= nil and c[2] ~= "none" then
		-- are we using a link or a color?
		-- links are discovered by being a string currently
		if type(c[2]) == "string" then
			val["link"] = c[2]
		else
			val["fg"] = c[2]:to_rgb()
		end
	end

	if c[3] ~= nil and c[3] ~= "none" then
		val["bg"] = c[3]:to_rgb()
	end

	if c[4] ~= nil and c[4] ~= "none" then
		val[c[4]] = true
	end

	if c[5] ~= nil and c[5] ~= "none" then
		if type(c[5]) ~= "string" then
			val["sp"] = c[5]:to_rgb()
		end
	end

	if c[6] ~= nil and c[6] ~= "none" then
		val["blend"] = c[6]:to_rgb()
	end

	for k, v in pairs(val) do
		if type(v) == "string" and #v > 7 then
			val[k] = nil
		end
	end

	if c["link"] ~= nil and c["link"] ~= "none" then
		val["link"] = c["link"]
	end

	-- invalid data coming in
	if c[1] == nil then
		return
	end

	vim.api.nvim_set_hl(0, c[1], val)
end

-- Use this function in your config
-- @param opts table
M.use = function(opts)
	vim.g.termguicolors = true
	vim.g.colors_name = "boo"
	local colormap = M.setup(opts)

	for _, group in ipairs(colormap) do
		local check_none = function(none_resp)
			return function(x)
				return not x and none_resp or x
			end
		end

		local cNone = check_none("none")
		local sNone = check_none(s.none)

		if sNone(group[4]) == s.italic and opts.italic == false or vim.g.boo_colorscheme_italic == false then
			group[4] = s.none
		end

		M.apply({ group[1], cNone(group[2]), cNone(group[3]), sNone(group[4]), cNone(group[5]) })
	end

	-- treesitter_migrate()
end

local find_theme_colors = function(opts)
	if opts ~= nil and opts["theme"] ~= nil then
		if opts["theme"] == "sunset_cloud" then
			return sunset_cloud
		end

		if opts["theme"] == "radioactive_waste" then
			return radioactive
		end

		if opts["theme"] == "forest_stream" then
			return forest_stream
		end

		if opts["theme"] == "crimson_moonlight" then
			return crimson_moonlight
		end

		if opts["theme"] == "default" then
			return default
		end

		if opts["theme"] == "boo_lora" then
			return boo_lora
		end
	end

	if vim.g.boo_colorscheme_theme == "sunset_cloud" then
		return sunset_cloud
	end

	if vim.g.boo_colorscheme_theme == "radioactive_waste" then
		return radioactive
	end

	if vim.g.boo_colorscheme_theme == "forest_stream" then
		return forest_stream
	end

	if vim.g.boo_colorscheme_theme == "crimson_moonlight" then
		return crimson_moonlight
	end

	if vim.g.boo_colorscheme_theme == "default" then
		return default
	end

	if vim.g.boo_colorscheme_theme == "boo_lora" then
		return boo_lora
	end

	return cloud
end

M.setup = function(opts)
	local cloud_map = find_theme_colors(opts)()

	local color_map = { none = "none" }

	-- cloud0 to cloud16 for all the available colors.
	for i, c in ipairs(cloud_map) do
		color_map["cloud" .. i - 1] = colors(c)
	end

	color_map["fg"] = colors("#e4dcec")
	color_map["bg"] = colors("#111113"):lighten_to(0.05)

	if opts ~= nil and opts["theme"] ~= nil and opts["theme"] == "sunset_cloud" then
		color_map["fg"] = colors("#ffffcf")
		color_map["bg"] = colors("#0e0f06")
	end

	if opts ~= nil and opts["theme"] ~= nil and opts["theme"] == "forest_stream" then
		color_map["fg"] = colors("#e3f5e7")
		color_map["bg"] = colors("#0b0c0b")
	end

	if opts ~= nil and opts["theme"] ~= nil and opts["theme"] == "crimson_moonlight" then
		color_map["fg"] = colors("#f9f2f3")
		color_map["bg"] = colors("#0f0e0e")
	end

	if opts ~= nil and opts["theme"] ~= nil and opts["theme"] == "sunset_cloud" then
		color_map["fg"] = colors("#ffffcf")
		color_map["bg"] = colors("#0e0f06")
	end

	if opts ~= nil and opts["theme"] ~= nil and opts["theme"] == "default" then
		color_map["fg"] = colors("#c5c8c6")
		color_map["bg"] = colors("#1d1f21")
	end

	if opts ~= nil and opts["theme"] ~= nil and opts["theme"] == "boo_lora" then
		color_map["fg"] = colors("#e4dcec")
		color_map["bg"] = colors("#111113"):lighten_to(0.05)
	end

	return colorscheme(color_map)
end

return M
