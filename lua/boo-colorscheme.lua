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

-- Cloud colors
local cloud = function()
	return {
		"#222827",
		"#d5a8e4",
		"#9c75dd",
		"#9898ae",
		"#654a96",
		"#625566",
		"#a9d1df",
		"#e6ebe5",
		"#5d6f74",
		"#cd749c",
		"#63b0b0",
		"#c0c0dd",
		"#5786bc",
		"#3f3442",
		"#849da2",
		"#d9d6cf",
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
		-- "#9d4e5c",
		-- "#42647f",
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
		{
			"DiagnosticUnderlineHint",
			c.none,
			c.none,
			s.underline,
			c.cloud13:saturate(0.05):lighten_to(0.2),
		},
		{
			"DiagnosticUnderlineError",
			c.none,
			c.none,
			s.underline,
			c.cloud1:saturate(0.05):lighten_to(0.2),
		},
		{
			"DiagnosticUnderlineWarn",
			c.none,
			c.none,
			s.underline,
			c.cloud6:dark(0.3),
		},
		{
			"DiagnosticUnderlineInfo",
			c.none,
			c.none,
			s.underline,
			c.fg,
		},
		{},
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
		{ "LspReferenceText", c.cloud6:lighten_to(0.9):desaturate_to(0.8) },
		{ "LspReferenceRead", c.cloud14:lighten_to(0.9):desaturate_to(0.8) },
		{ "LspReferenceWrite", c.cloud12:lighten_to(0.9):desaturate_to(0.8) },
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
		{ "DapUIValue", "TSVariable" },
		{ "DapUIFrameName", "Normal" },
		{ "DapUIVariable", "TSVariable" },

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
	}

	local constants = {
		"TSConstant",
		"TSConstBuiltin",
		"TSConstMacro",
	}

	local constructors = { "TSConstructor" }

	local string = { "TSStringRegex", "TSString", "TSStringEscape", "TSStringSpecial" }

	local boolean = { "TSBoolean" }

	local functions = { "TSFunction", "TSFuncBuiltin", "TSFuncMacro" }

	local methods = { "TSMethod" }

	local fields = { "TSField", "TSProperty" }

	local number = { "TSNumber", "TSFloat" }

	local parameters = { "TSParameter", "TSParameterReference" }

	local operators = { "TSOperator" }

	local forwords = { "TSConditional", "TSRepeat" }

	local keyword = { "TSKeyword", "TSKeywordFunction", "TSKeywordReturn", "TSKeywordOperator" }

	local types = { "TSType", "TSTypeBuiltin" }

	local labels = { "TSLabel" }

	local namespaces = { "TSNamespace" }

	local includes = { "TSInclude" }

	local variables = { "TSVariable", "TSVariableBuiltin" }

	local tags = { "TSTag", "TSTagDelimiter" }

	local text = { "TSText", "TSStrong", "TSEmphasis", "TSUnderline", "TSLiteral", "TSURI" }

	local title = { "TSTitle" }

	local groups = {
		{ error, c.cloud1:light(), c.cloud9:dark(0.5), s.none },
		{ punctuation, c.cloud3:lighten_to(0.4):desaturate(0.1) },
		{ constants, c.cloud5:light(0.1) },
		{ string, c.cloud10:lighten_to(0.8):desaturate_to(0.5) },
		{ boolean, c.cloud2:light(0.1) },
		{ functions, c.cloud14:saturate(0.2) },
		{ methods, c.cloud14:light(0.1), c.none, s.italic },
		{ fields, c.cloud10:lighten_to(0.5):desaturate_to(0.1) },
		{ number, c.cloud6:lighten_to(0.8):desaturate_to(0.1) },
		{ parameters, c.cloud6:dark() },
		{ operators, c.cloud3:lighten_to(0.4):desaturate(0.1) },
		{ forwords, c.cloud8:saturate(0.1), c.none },
		{ keyword, c.cloud4:lighten_to(0.45), c.none, s.italic },
		{ constructors, c.cloud10 },
		{ types, c.cloud10 },
		{ includes, c.cloud4 },
		{ labels, c.cloud4:light(0.1) },
		{ namespaces, c.cloud14:light(0.1) },
		{ variables, c.cloud10:lighten_to(0.7) },
		{ tags, c.cloud10:light(0.1) },
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
			{ "TSPunctDelimiter", c.cloud3:dark():dark():saturate(0.1) },
			{ "TSTagDelimiter", c.cloud8:dark(0.15) },

			{ "TSPunctSpecial", c.cloud12:desaturate_to(0.1):lighten_to(0.5) },
			{ "TSVariableBuiltin", c.cloud6:dark(), c.none, s.bold },

			-- null
			{ "TSConstBuiltin", c.cloud6:dark(0.3), c.none, s.bold },

			{ "TSTypeBuiltin", c.cloud10:dark(0.2), c.none, s.bold },
			{ "TSFuncBuiltin", c.cloud8:light(0.1), c.none, s.bold },

			{ "TSVariableBuiltin", c.cloud12:lighten_to(0.4) },

			{ "TSField", c.cloud8 },

			{ "TSNodeKey", c.cloud10 },
			{ "TSNodeUnmatched", c.cloud8:dark(0.2) },
		},
	})
end

-- Temporary migration until we port over to the new names (and backport for older versions of Neovim)
local treesitter_migrate = function()
	local map = {
		["annotation"] = "TSAnnotation",

		["attribute"] = "TSAttribute",

		["boolean"] = "TSBoolean",

		["character"] = "TSCharacter",
		["character.special"] = "TSCharacterSpecial",

		["comment"] = "TSComment",

		["conditional"] = "TSConditional",

		["constant"] = "TSConstant",
		["constant.builtin"] = "TSConstBuiltin",
		["constant.macro"] = "TSConstMacro",

		["constructor"] = "TSConstructor",

		["debug"] = "TSDebug",
		["define"] = "TSDefine",

		["error"] = "TSError",
		["exception"] = "TSException",

		["field"] = "TSField",

		["float"] = "TSFloat",

		["function"] = "TSFunction",
		["function.call"] = "TSFunctionCall",
		["function.builtin"] = "TSFuncBuiltin",
		["function.macro"] = "TSFuncMacro",

		["include"] = "TSInclude",

		["keyword"] = "TSKeyword",
		["keyword.function"] = "TSKeywordFunction",
		["keyword.operator"] = "TSKeywordOperator",
		["keyword.return"] = "TSKeywordReturn",

		["label"] = "TSLabel",

		["method"] = "TSMethod",
		["method.call"] = "TSMethodCall",

		["namespace"] = "TSNamespace",

		["none"] = "TSNone",
		["number"] = "TSNumber",

		["operator"] = "TSOperator",

		["parameter"] = "TSParameter",
		["parameter.reference"] = "TSParameterReference",

		["preproc"] = "TSPreProc",

		["property"] = "TSProperty",

		["punctuation.delimiter"] = "TSPunctDelimiter",
		["punctuation.bracket"] = "TSPunctBracket",
		["punctuation.special"] = "TSPunctSpecial",

		["repeat"] = "TSRepeat",

		["storageclass"] = "TSStorageClass",

		["string"] = "TSString",
		["string.regex"] = "TSStringRegex",
		["string.escape"] = "TSStringEscape",
		["string.special"] = "TSStringSpecial",

		["symbol"] = "TSSymbol",

		["tag"] = "TSTag",
		["tag.attribute"] = "TSTagAttribute",
		["tag.delimiter"] = "TSTagDelimiter",

		["text"] = "TSText",
		["text.strong"] = "TSStrong",
		["text.emphasis"] = "TSEmphasis",
		["text.underline"] = "TSUnderline",
		["text.strike"] = "TSStrike",
		["text.title"] = "TSTitle",
		["text.literal"] = "TSLiteral",
		["text.uri"] = "TSURI",
		["text.math"] = "TSMath",
		["text.reference"] = "TSTextReference",
		["text.environment"] = "TSEnvironment",
		["text.environment.name"] = "TSEnvironmentName",

		["text.note"] = "TSNote",
		["text.warning"] = "TSWarning",
		["text.danger"] = "TSDanger",

		["todo"] = "TSTodo",

		["type"] = "TSType",
		["type.builtin"] = "TSTypeBuiltin",
		["type.qualifier"] = "TSTypeQualifier",
		["type.definition"] = "TSTypeDefinition",

		["variable"] = "TSVariable",
		["variable.builtin"] = "TSVariableBuiltin",
	}

	for capture, hlgroup in pairs(map) do
		vim.api.nvim_set_hl(0, "@" .. capture, { link = hlgroup, default = true })
	end

	local defaults = {
		TSNone = { default = true },
		TSPunctDelimiter = { link = "Delimiter", default = true },
		TSPunctBracket = { link = "Delimiter", default = true },
		TSPunctSpecial = { link = "Delimiter", default = true },

		TSConstant = { link = "Constant", default = true },
		TSConstBuiltin = { link = "Special", default = true },
		TSConstMacro = { link = "Define", default = true },
		TSString = { link = "String", default = true },
		TSStringRegex = { link = "String", default = true },
		TSStringEscape = { link = "SpecialChar", default = true },
		TSStringSpecial = { link = "SpecialChar", default = true },
		TSCharacter = { link = "Character", default = true },
		TSCharacterSpecial = { link = "SpecialChar", default = true },
		TSNumber = { link = "Number", default = true },
		TSBoolean = { link = "Boolean", default = true },
		TSFloat = { link = "Float", default = true },

		TSFunction = { link = "Function", default = true },
		TSFunctionCall = { link = "TSFunction", default = true },
		TSFuncBuiltin = { link = "Special", default = true },
		TSFuncMacro = { link = "Macro", default = true },
		TSParameter = { link = "Identifier", default = true },
		TSParameterReference = { link = "TSParameter", default = true },
		TSMethod = { link = "Function", default = true },
		TSMethodCall = { link = "TSMethod", default = true },
		TSField = { link = "Identifier", default = true },
		TSProperty = { link = "Identifier", default = true },
		TSConstructor = { link = "Special", default = true },
		TSAnnotation = { link = "PreProc", default = true },
		TSAttribute = { link = "PreProc", default = true },
		TSNamespace = { link = "Include", default = true },
		TSSymbol = { link = "Identifier", default = true },

		TSConditional = { link = "Conditional", default = true },
		TSRepeat = { link = "Repeat", default = true },
		TSLabel = { link = "Label", default = true },
		TSOperator = { link = "Operator", default = true },
		TSKeyword = { link = "Keyword", default = true },
		TSKeywordFunction = { link = "Keyword", default = true },
		TSKeywordOperator = { link = "TSOperator", default = true },
		TSKeywordReturn = { link = "TSKeyword", default = true },
		TSException = { link = "Exception", default = true },
		TSDebug = { link = "Debug", default = true },
		TSDefine = { link = "Define", default = true },
		TSPreProc = { link = "PreProc", default = true },
		TSStorageClass = { link = "StorageClass", default = true },

		TSTodo = { link = "Todo", default = true },

		TSType = { link = "Type", default = true },
		TSTypeBuiltin = { link = "Type", default = true },
		TSTypeQualifier = { link = "Type", default = true },
		TSTypeDefinition = { link = "Typedef", default = true },

		TSInclude = { link = "Include", default = true },

		TSVariableBuiltin = { link = "Special", default = true },

		TSText = { link = "TSNone", default = true },
		TSStrong = { bold = true, default = true },
		TSEmphasis = { italic = true, default = true },
		TSUnderline = { underline = true },
		TSStrike = { strikethrough = true },

		TSMath = { link = "Special", default = true },
		TSTextReference = { link = "Constant", default = true },
		TSEnvironment = { link = "Macro", default = true },
		TSEnvironmentName = { link = "Type", default = true },
		TSTitle = { link = "Title", default = true },
		TSLiteral = { link = "String", default = true },
		TSURI = { link = "Underlined", default = true },

		TSComment = { link = "Comment", default = true },
		TSNote = { link = "SpecialComment", default = true },
		TSWarning = { link = "Todo", default = true },
		TSDanger = { link = "WarningMsg", default = true },

		TSTag = { link = "Label", default = true },
		TSTagDelimiter = { link = "Delimiter", default = true },
		TSTagAttribute = { link = "TSProperty", default = true },
	}

	for group, val in pairs(defaults) do
		vim.api.nvim_set_hl(0, group, val)
	end
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

		{ "WarningMsg", c.cloud4:light(0.3), c.cloud12:dark(0.3) },
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

		{ "Identifier", c.cloud2 },
		{ "Include", c.cloud10 },

		{ "Keyword", c.cloud4, c.none, s.italic },

		{ "Label", c.cloud10, c.none, s.italic },

		{ "Operator", c.cloud12:dark() },

		{ "PreProc", c.cloud10 },

		{ "Repeat", c.cloud12:dark() },

		{ "Statement", c.cloud10 },
		{ "StorageClass", c.cloud10 },
		{ "String", c.cloud14 },
		{ "Structure", c.cloud10 },
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
		lsp_semantic_tokens(c),
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
		val.bg = c[3]:to_rgb()
	end

	if c[4] ~= nil and c[4] ~= "none" then
		val[c[4]] = true
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
	-- vim.cmd("hi! clear")
	local colormap = M.setup(opts)

	for _, group in ipairs(colormap) do
		local check_none = function(none_resp)
			return function(x)
				return not x and none_resp or x
			end
		end

		local cNone = check_none("none")
		local sNone = check_none(s.none)

		M.apply({ group[1], cNone(group[2]), cNone(group[3]), sNone(group[4]), cNone(group[5]) })
	end

	treesitter_migrate()
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

	return colorscheme(color_map)
end

return M
