" ========================================================
" Global
" ========================================================
set nocompatible
filetype plugin on
set encoding=utf-8
set fileencoding=utf-8
set clipboard=unnamed
syntax on
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set shiftround
set number
set belloff=all
set mouse=a
set hidden
set ignorecase
set smartcase
set undofile
set termguicolors
set background=dark
set cursorline

highlight clear Pmenu
highlight Pmenu cterm=inverse
highlight clear PmenuSel

" ========================================================
" Remove trailing whitespace
" ========================================================
autocmd BufWritePre * :%s/\s\+$//e

" ========================================================
" vimplug
" ========================================================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'                            " Git gutter
Plug 'github/copilot.vim'                                " Github Copilot
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }      " File searching
Plug 'junegunn/fzf.vim'                                  " |
Plug 'junegunn/gv.vim'					 " Git commit browser
Plug 'lervag/vimtex'					 " LaTeX support
Plug 'neoclide/coc.nvim', {'branch': 'release'}          " Nice coc, bro
Plug 'rust-lang/rust.vim'                                " Rust
Plug 'tpope/vim-commentary'                              " Comments!
Plug 'tpope/vim-endwise' 				 " Auto end control flow
Plug 'tpope/vim-fugitive'                                " Git integration
Plug 'tpope/vim-sensible'                                " Sensible defaults
Plug 'tpope/vim-sleuth'                                  " Detect indent settings
Plug 'tpope/vim-surround'                                " () {} []
Plug 'vim-airline/vim-airline'                           " Cool bar
Plug 'nvim-lua/plenary.nvim'				 " Plenary
Plug 'nvim-tree/nvim-web-devicons'			 " Icons
Plug 'MunifTanjim/nui.nvim'				 " Nui
Plug 'nvim-neo-tree/neo-tree.nvim'			 " Neo tree
Plug 'lukas-reineke/indent-blankline.nvim'		 " Indent lines
Plug 'antoinemadec/coc-fzf'

call plug#end()

" ========================================================
" vimtex
" ========================================================
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0

" ========================================================
" CoC
" ========================================================
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <F2> <Plug>(coc-rename)

inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" ========================================================
" Airline
" ========================================================
set laststatus=2
let g:airline_detect_modified=1
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'

" ========================================================
" Keymaps
" ========================================================
nmap <Leader>wt :call setline(".", getline(".") . strftime("%F"))<CR>$
nmap gs :CocFzfList symbols<CR>
nmap ge :CocFzfList diagnostics<CR>

nnoremap <C-p> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <C-f> :Rg<CR>

map <C-j> :tabp<CR>
map <C-l> :tabn<CR>
map <C-k> :tabnew<CR>

map <C-n> :Neotree toggle<CR>
