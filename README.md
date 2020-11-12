# Boo

Sorry, didn't mean to scare you.

Boo is a colorscheme for Neovim with handcrafted support for LSP, Treesitter.

![Full Screen](https://user-images.githubusercontent.com/15027/98894239-5bcd8780-2472-11eb-9ca4-a2c3142a848a.png)

## Goal

To use sutle changes in colors to help lessen the syntax noise.
Brightness range on syntax to ramp up to values and variables.

## Requirements

Neovim 0.4
[colorbuddy.nvim](https://github.com/tjdevries/colorbuddy.nvim)

## Install

```vimscript
Plug 'tjdevries/colorbuddy.nvim'
Plug 'rockerBOO/boo-colorscheme-nvim'
```

Then in your `init.vim` you can set it to use it as color scheme.

```vimscript
lua require'boo-colorscheme'.use{}
```

## Support

Typescript/TSX/JSX:
![typescript](https://user-images.githubusercontent.com/15027/98894240-5c661e00-2472-11eb-9bbe-96cca05c5590.png)

Lua
![lua](https://user-images.githubusercontent.com/15027/98894334-9505f780-2472-11eb-9b73-b76b2b1f68b9.png)

