local cs = require'boo-colorscheme'

describe('colorscheme', function() 
  it("should not error", function() 
    cs.setup()
    assert.has_no.errors(cs.colors)
  end)
end)
