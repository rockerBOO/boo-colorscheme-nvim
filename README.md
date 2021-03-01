# Boo

Sorry, didn't mean to scare you.

Boo is a colorscheme for Neovim with handcrafted-artisanal support for LSP, Treesitter.


![Full Screen](https://user-images.githubusercontent.com/15027/98894239-5bcd8780-2472-11eb-9ca4-a2c3142a848a.png)

[![Action Status](https://github.com/rockerBOO/boo-colorscheme-nvim/workflows/Tests/badge.svg)](https://github.com/rockerBOO/boo-colorscheme-nvim/actions)

## Goal

- To use subtle changes in colors to help lessen the syntax noise.
- Brightness range on syntax to ramp up to values and variables.

## Requirements

* Neovim 0.4
* termguicolors required (`:h 'termguicolors'`) 

```vimscript
if (has("termguicolors"))
  set termguicolors
endif
```

## Install

```vimscript
Plug 'rockerBOO/boo-colorscheme-nvim', { 'branch': 'main' }
```

Then in your `init.vim` you can set it to use it as your color scheme.

```vimscript
lua require'boo-colorscheme'.use{}
```

## Tests

Requires a busted supported test runner. 

- `make test` - 


## Support

### Typescript/TSX/JSX

![typescript](https://user-images.githubusercontent.com/15027/98894240-5c661e00-2472-11eb-9bbe-96cca05c5590.png)

### Lua

![lua](https://user-images.githubusercontent.com/15027/98894334-9505f780-2472-11eb-9b73-b76b2b1f68b9.png)

### Go

![go](https://user-images.githubusercontent.com/15027/101699325-ef31b280-3a48-11eb-94e8-a89152204358.png)

