# Boo

Sorry, didn't mean to scare you.

Boo is a colorscheme for Neovim with handcrafted-artisanal support for LSP, Treesitter.

![Full Screen](https://user-images.githubusercontent.com/15027/178179115-3e238800-8c53-4160-962f-90b9d1ad3747.png)

[![Action Status](https://github.com/rockerBOO/boo-colorscheme-nvim/workflows/Tests/badge.svg)](https://github.com/rockerBOO/boo-colorscheme-nvim/actions)

## Goal

- To use subtle changes in colors to help lessen the syntax noise.
- Brightness range on syntax to ramp up to values and variables.

## Requirements

- Neovim 0.4
- `termguicolors` required (`:h 'termguicolors'`)

`vimscript`

```vimscript
if (has("termguicolors"))
  set termguicolors
endif
```

`lua`

```lua
if vim.fn.has("termguicolors") then
  vim.opt.termguicolors = true
end
```

## Install

### Plug

```vimscript
Plug 'rockerBOO/boo-colorscheme-nvim'
```

### Packer

```lua
use 'rockerBOO/boo-colorscheme-nvim'
```

Then in your `init.vim` or `init.lua` you can set it to use it as your color scheme.

```vimscript
colorscheme boo
```

Or in lua with the use function. This allows you to pass options like `{ theme = "radioactive_waste" }`.

```lua
require("boo-colorscheme").use({})
```

## Options

```lua
require("boo-colorscheme").use({
	italic = true, -- toggle italics
	theme = "boo"
})
```

or in vimscript

```vimscript
let g:boo_colorscheme_italic = true
```

## Themes

- [`sunset_cloud`](#sunset_cloud)
- [`radioactive_waste`](#radioactive_waste)
- [`forest_stream`](#forest_stream)
- [`crimson_moonlight`](#crimson_moonlight)

```lua
require('boo-colorscheme').use({ theme = 'sunset_cloud' })
```

or

```vimscript
let g:boo_colorscheme_theme = 'sunset_cloud'
```

### `sunset_cloud`

![Screenshot of the source code showing sunset_cloud](https://user-images.githubusercontent.com/15027/162499722-a703531e-e9ac-461e-befb-dc9040234869.png)

### `radioactive_waste`

![Screenshot of the source code showing radioactive waste](https://user-images.githubusercontent.com/15027/178177587-620c2623-c31a-469a-944f-e2c5bbc1bea6.png)

### `forest_stream`

![Screenshot of the source code showing forest stream](https://user-images.githubusercontent.com/15027/178177588-cfe53f8c-08a3-49af-b44a-6667574b1fda.png)

### `crimson_moonlight`

![Screenshot of the source code showing crimson_moonlight](https://user-images.githubusercontent.com/15027/178177589-bcfe7280-9c43-4d41-abf4-f40e56be9803.png)

## Support

### Typescript/TSX/JSX

![typescript](https://user-images.githubusercontent.com/15027/178179116-15203812-037b-458c-b27e-3ce3f1663a51.png)

### Rust

![rust](https://user-images.githubusercontent.com/15027/178296453-9b0cc27b-417f-46e4-8bc1-a4d47d49788e.png)

### Lua

![lua](https://user-images.githubusercontent.com/15027/98894334-9505f780-2472-11eb-9b73-b76b2b1f68b9.png)

### Go

![go](https://user-images.githubusercontent.com/15027/101699325-ef31b280-3a48-11eb-94e8-a89152204358.png)

### Telescope

![telescope](https://user-images.githubusercontent.com/15027/197878218-9d976b7d-2c47-4242-b5ca-1fb4db5ac803.png)

## Colors

![Colors Used](https://user-images.githubusercontent.com/15027/112667058-321a6900-8e33-11eb-9c06-7c15ab5b7b18.png)

## Development

### Tests

Requires a busted supported test runner.

- `make test` -
