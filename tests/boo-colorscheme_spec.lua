local cs = require("boo-colorscheme")

describe("colorscheme", function()
	it("should not error", function()
		assert.has_no.errors(cs.setup)
	end)
end)

describe("links", function()
	local links = require("boo-colorscheme")._links

	it("returns a tuple per name pointing at the primary group", function()
		local result = links("TSPunctDelimiter", { "TSPunctBracket", "TSPunctSpecial" })

		assert.are.same({
			{ "TSPunctBracket", "TSPunctDelimiter" },
			{ "TSPunctSpecial", "TSPunctDelimiter" },
		}, result)
	end)

	it("returns an empty list when given no names", function()
		local result = links("TSPunctDelimiter", {})

		assert.are.same({}, result)
	end)
end)

describe("highlight_to_groups", function()
	local highlight_to_groups = require("boo-colorscheme")._highlight_to_groups

	it("applies the same highlight tuple to every plain string name", function()
		local result = highlight_to_groups({ "red", "blue", "bold" })({ "GroupA", "GroupB" })

		assert.are.same({
			{ "GroupA", "red", "blue", "bold" },
			{ "GroupB", "red", "blue", "bold" },
		}, result)
	end)
end)

describe("treesitter punctuation groups", function()
	it("links TSPunctBracket to the real @punctuation.bracket definition", function()
		local colors = require("colors")

		local cloud_map = cs.find_theme_colors({})()
		local c = { none = "none" }
		for i, hex in ipairs(cloud_map) do
			c["cloud" .. i - 1] = colors(hex)
		end
		c.fg = colors("#e4dcec")
		c.bg = colors("#111113"):lighten_to(0.05)

		local result = cs._treesitter(c)

		local by_name = {}
		for _, entry in ipairs(result) do
			by_name[entry[1]] = entry
		end

		-- @punctuation.bracket holds the real color definition
		assert.is_not_nil(by_name["@punctuation.bracket"])
		assert.is_not.equal("string", type(by_name["@punctuation.bracket"][2]))

		-- TSPunctBracket links to it
		assert.are.same({ "TSPunctBracket", "@punctuation.bracket" }, by_name["TSPunctBracket"])

		-- untouched names still resolve exactly as before
		assert.are.same({ "TSPunctDelimiter", "@punctuation.delimiter" }, by_name["TSPunctDelimiter"])
		assert.are.same({ "TSPunctSpecial", "@punctuation.special" }, by_name["TSPunctSpecial"])
	end)
end)

describe("M.apply", function()
	it("does not strip long link target names", function()
		cs.apply({ "TestLinkGroup", "@punctuation.bracket" })

		local hl = vim.api.nvim_get_hl(0, { name = "TestLinkGroup" })
		assert.are.equal("@punctuation.bracket", hl.link)
	end)

	it("still sets a normal fg color correctly", function()
		local colors = require("colors")
		cs.apply({ "TestColorGroup", colors("#a3b4c5") })

		local hl = vim.api.nvim_get_hl(0, { name = "TestColorGroup" })
		assert.is_not_nil(hl.fg)
	end)
end)
