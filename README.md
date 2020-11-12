# Boo 

Sorry, didn't mean to scare you.

Boo is a colorscheme for Neovim with handcrafted support for LSP, Treesitter.

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


