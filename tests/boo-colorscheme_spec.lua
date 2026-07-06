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
