set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set hlsearch                " highlight search results
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set tabstop=4               " number of columns occupied by a tab character
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing

let mapleader = " "         " change leader to space (default is backslash)


call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'phaazon/hop.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
call plug#end()


"
" fzf settings
"

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :GFiles<CR>


"
" hop settings
"

lua require'hop'.setup()

nnoremap <leader>s :HopChar1<CR>
nnoremap <leader>l :HopLine<CR>
nnoremap <leader>w :HopWord<CR>


"
" bufferline settings
"

set termguicolors
lua << EOF
require('bufferline').setup({
  options = {
    show_buffer_close_icons = false,
    show_close_icon = false
  }
})
EOF

nnoremap <silent> gb :BufferLinePick<CR>
nnoremap <silent> gc :BufferLinePickClose<CR>


"
" catppuccin settings
"
"

lua require'catppuccin'.setup()

let g:catppuccin_flavour = "mocha"
colorscheme catppuccin
