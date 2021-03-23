" Vim Color File
" Name:     boo
" Built On: 12/18/2020

hi! clear

if exists('syntax on') 
  syntax reset 
endif

lua require"boo-colorscheme".use({})
