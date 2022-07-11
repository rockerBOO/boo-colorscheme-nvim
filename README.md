# Boo

Sorry, didn't mean to scare you.

Boo is a colorscheme for Neovim with handcrafted-artisanal support for LSP, Treesitter.

![Full Screen](https://user-images.githubusercontent.com/15027/98894239-5bcd8780-2472-11eb-9ca4-a2c3142a848a.png)

[![Action Status](https://github.com/rockerBOO/boo-colorscheme-nvim/workflows/Tests/badge.svg)](https://github.com/rockerBOO/boo-colorscheme-nvim/actions)

## Goal

- To use subtle changes in colors to help lessen the syntax noise.
- Brightness range on syntax to ramp up to values and variables.

## Requirements

- Neovim 0.4
- termguicolors required (`:h 'termguicolors'`)

```vimscript
if (has("termguicolors"))
  set termguicolors
endif
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

## Themes

- [`sunset_cloud`](#sunset_cloud)
- [`radioactive_waste`](#radioactive_waste)
- [`forest_stream`](#forest_stream)
- [`crimson_moonlight`](#crimson_moonlight)

```lua
vim.g.boo_colorscheme_theme = 'sunset_cloud'
```

or

```lua
require('boo-colorscheme').use({ theme = 'sunset_cloud' })
```

or

```vimscript
let g:boo_colorscheme_theme = 'sunset_cloud'
```

![Screenshot of the source code showing sunset_cloud](https://user-images.githubusercontent.com/15027/162499722-a703531e-e9ac-461e-befb-dc9040234869.png)

### `radioactive_waste`

![Screenshot of the source code showing radioactive waste]()

### `forest_stream`

![Screenshot of the source code showing forest stream]()

### `crimson_moonlight`

![Screenshot of the source code showing crimson_moonlight]()

## Support

### Typescript/TSX/JSX

![typescript](https://user-images.githubusercontent.com/15027/98894240-5c661e00-2472-11eb-9bbe-96cca05c5590.png)

### Lua

![lua](https://user-images.githubusercontent.com/15027/98894334-9505f780-2472-11eb-9b73-b76b2b1f68b9.png)

### Go

![go](https://user-images.githubusercontent.com/15027/101699325-ef31b280-3a48-11eb-94e8-a89152204358.png)

### Telescope

![telescope](https://user-images.githubusercontent.com/15027/130393678-526e0fd2-d50f-4db7-8d76-337475e4e125.png)

## Colors

![Colors Used](https://user-images.githubusercontent.com/15027/112667058-321a6900-8e33-11eb-9c06-7c15ab5b7b18.png)

## Development

### Tests

Requires a busted supported test runner.

- `make test` -
