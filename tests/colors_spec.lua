local colors = require("colors")

describe("Color", function()
	it("clamps lightness to 0 when darkened past black", function()
		local c = colors("#3f3442"):dark(0.9)
		local rgb = c:to_rgb()

		assert.are.equal(7, #rgb)
		assert.are.equal("#", rgb:sub(1, 1))
	end)

	it("clamps lightness to 1 when lightened past white", function()
		local c = colors("#3f3442"):light(0.9)
		local rgb = c:to_rgb()

		assert.are.equal(7, #rgb)
		assert.are.equal("#", rgb:sub(1, 1))
	end)

	it("does not overflow to_rgb at maximum lightness", function()
		local c = colors.new(0, 0, 1)
		local rgb = c:to_rgb()

		assert.are.equal("#ffffff", rgb)
	end)
end)
