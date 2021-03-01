-----------------------------------------------------------------------------
-- Provides support for color manipulation in HSL color space.
--
-- http://sputnik.freewisdom.org/lib/colors/
--
-- License: MIT/X
--
-- (c) 2008 Yuri Takhteyev (yuri@freewisdom.org) *
--
-- * rgb_to_hsl() implementation was contributed by Markus Fleck-Graffe.
-----------------------------------------------------------------------------

local M = {}

local Color = {}
local Color_mt = { __metatable = {}, __index = Color }

local rgb_string_to_hsl -- defined below

-----------------------------------------------------------------------------
-- Instantiates a new "color".
--
-- @param H              hue (0-360) _or_ an RGB string ("#930219")
-- @param S              saturation (0.0-1.0)
-- @param L              lightness (0.0-1.0)
-- @return               an instance of Color
-----------------------------------------------------------------------------
local function new(h, s, l)
	if type(h) == "string" and h:sub(1, 1) == "#" and h:len() == 7 then
		h, s, l = rgb_string_to_hsl(h)
	end
	assert(Color_mt)
	return setmetatable({ h = h, s = s, l = l }, Color_mt)
end
M.new = new

M.from_hex = function(hex)
  local	h, s, l = rgb_string_to_hsl(hex)

	return new(h, s, l)
end

-----------------------------------------------------------------------------
-- Converts an HSL triplet to RGB
-- (see http://homepages.cwi.nl/~steven/css/hsl.html).
--
-- @param H              hue (0-360)
-- @param S              saturation (0.0-1.0)
-- @param L              lightness (0.0-1.0)
-- @return               an R, G, and B component of RGB
-----------------------------------------------------------------------------

local function hsl_to_rgb(h, s, l)
	h = h / 360
	local q, p
	if l <= 0.5 then
		q = l * (s + 1)
	else
		q = l + s - l * s
	end
	p = l * 2 - q

	local function _h2rgb(m1, m2, m3)
		if m3 < 0 then
			m3 = m3 + 1
		end
		if m3 > 1 then
			m3 = m3 - 1
		end
		if m3 * 6 < 1 then
			return m1 + (m2 - m1) * m3 * 6
		elseif m3 * 2 < 1 then
			return m2
		elseif m3 * 3 < 2 then
			return m1 + (m2 - m1) * (2 / 3 - m3) * 6
		else
			return m1
		end
	end

	return _h2rgb(p, q, h + 1 / 3), _h2rgb(p, q, h), _h2rgb(p, q, h - 1 / 3)
end
M.hsl_to_rgb = hsl_to_rgb

-----------------------------------------------------------------------------
-- Converts an RGB triplet to HSL.
-- (see http://easyrgb.com)
--
-- @param r              red (0.0-1.0)
-- @param g              green (0.0-1.0)
-- @param b              blue (0.0-1.0)
-- @return               corresponding H, S and L components
-----------------------------------------------------------------------------

local function rgb_to_hsl(r, g, b)
	--r, g, b = r/255, g/255, b/255
	local min = math.min(r, g, b)
	local max = math.max(r, g, b)
	local delta = max - min

	local h, s, l = 0, 0, ((min + max) / 2)

	if l > 0 and l < 0.5 then
		s = delta / (max + min)
	end
	if l >= 0.5 and l < 1 then
		s = delta / (2 - max - min)
	end

	if delta > 0 then
		if max == r and max ~= g then
			h = h + (g - b) / delta
		end
		if max == g and max ~= b then
			h = h + 2 + (b - r) / delta
		end
		if max == b and max ~= r then
			h = h + 4 + (r - g) / delta
		end
		h = h / 6
	end

	if h < 0 then
		h = h + 1
	end
	if h > 1 then
		h = h - 1
	end

	return h * 360, s, l
end
M.rgb_to_hsl = rgb_to_hsl

-- already local, see at the bottom
function rgb_string_to_hsl(rgb)
	return rgb_to_hsl(
		tonumber(rgb:sub(2, 3), 16) / 256,
		tonumber(rgb:sub(4, 5), 16) / 256,
		tonumber(rgb:sub(6, 7), 16) / 256
	)
end
M.rgb_string_to_hsl = rgb_string_to_hsl

-----------------------------------------------------------------------------
-- Converts the color to an RGB string.
--
-- @return               a 6-digit RGB representation of the color prefixed
--                       with "#" (suitable for inclusion in HTML)
-----------------------------------------------------------------------------

function Color:to_rgb()
	-- local r, g, b = hsl_to_rgb(self.h, self.s, self.l)
	local rgb = { hsl_to_rgb(self.h, self.s, self.l) }
	local buffer = "#"
	for _, v in ipairs(rgb) do
		buffer = buffer .. string.format("%02x", math.floor(v * 256 + 0.5))
	end
	return buffer
end

-----------------------------------------------------------------------------
-- Creates a new color with hue different by delta.
--
-- @param delta          a delta for hue.
-- @return               a new instance of Color.
-----------------------------------------------------------------------------
function Color:hue_offset(delta)
	return new((self.h + delta) % 360, self.s, self.l)
end

-----------------------------------------------------------------------------
-- Creates a complementary color.
--
-- @return               a new instance of Color
-----------------------------------------------------------------------------
function Color:complementary()
	return self:hue_offset(180)
end

-----------------------------------------------------------------------------
-- Creates two neighboring colors (by hue), offset by "angle".
--
-- @param angle          the difference in hue between this color and the
--                       neighbors
-- @return               two new instances of Color
-----------------------------------------------------------------------------
function Color:neighbors(angle)
	angle = angle or 30
	return self:hue_offset(angle), self:hue_offset(360 - angle)
end

-----------------------------------------------------------------------------
-- Creates two new colors to make a triadic color scheme.
--
-- @return               two new instances of Color
-----------------------------------------------------------------------------
function Color:triadic()
	return self:neighbors(120)
end

-----------------------------------------------------------------------------
-- Creates two new colors, offset by angle from this colors complementary.
--
-- @param angle          the difference in hue between the complementary and
--                       the returned colors
-- @return               two new instances of Color
-----------------------------------------------------------------------------
function Color:split_complementary(angle)
	return self:neighbors(180 - (angle or 30))
end

-----------------------------------------------------------------------------
-- Creates a new color with saturation set to a new value.
--
-- @param saturation     the new saturation value (0.0 - 1.0)
-- @return               a new instance of Color
-----------------------------------------------------------------------------
function Color:desaturate_to(saturation)
	return new(self.h, saturation, self.l)
end

-----------------------------------------------------------------------------
-- Creates a new color with saturation set to a old saturation times r.
--
-- @param r              the multiplier for the new saturation
-- @return               a new instance of Color
-----------------------------------------------------------------------------
function Color:desaturate_by(r)
	return new(self.h, self.s * r, self.l)
end

function Color:saturate(r)
	return new(self.h, self.s + r, self.l)
end

function Color:desaturate(r)
	return new(self.h, self.s - r, self.l)
end

-----------------------------------------------------------------------------
-- Creates a new color with lightness set to a new value.
--
-- @param lightness      the new lightness value (0.0 - 1.0)
-- @return               a new instance of Color
-----------------------------------------------------------------------------
function Color:lighten_to(lightness)
	return new(self.h, self.s, lightness)
end

-----------------------------------------------------------------------------
-- Creates a new color with lightness set to a old lightness times r.
--
-- @param r              the multiplier for the new lightness
-- @return               a new instance of Color
-----------------------------------------------------------------------------
function Color:lighten_by(r)
	return new(self.h, self.s, self.l * r)
end

function Color:dark(r)
	r = r or 0
	return new(self.h, self.s, self.l - r)
end

function Color:light(r)
	r = r or 0
	return new(self.h, self.s, self.l + r)
end

-----------------------------------------------------------------------------
-- Creates n variations of this color using supplied function and returns
-- them as a table.
--
-- @param f              the function to create variations
-- @param n              the number of variations
-- @return               a table with n values containing the new colors
-----------------------------------------------------------------------------
function Color:variations(f, n)
	n = n or 5
	local results = {}
	for i = 1, n do
		table.insert(results, f(self, i, n))
	end
	return results
end

-----------------------------------------------------------------------------
-- Creates n tints of this color and returns them as a table
--
-- @param number         the number of tints
-- @return               a table with n values containing the new colors
-----------------------------------------------------------------------------
function Color:tints(number)
	local f = function(color, i, n)
		return color:lighten_to(color.L + (1 - color.L) / n * i)
	end
	return self:variations(f, number)
end

-----------------------------------------------------------------------------
-- Creates n shades of this color and returns them as a table
--
-- @param number         the number of shades
-- @return               a table with n values containing the new colors
-----------------------------------------------------------------------------
function Color:shades(number)
	local f = function(color, i, n)
		return color:lighten_to(color.L - color.L / n * i)
	end
	return self:variations(f, number)
end

function Color:tint(r)
	return self:lighten_to(self.l + (1 - self.l) * r)
end

function Color:shade(r)
	return self:lighten_to(self.l - self.l * r)
end

Color_mt.__tostring = Color.to_rgb

-- allow to use `colors(...)` instead of `colors.new(...)`
setmetatable(M, { __call = function(_, ...)
	return new(...)
end })

return M
