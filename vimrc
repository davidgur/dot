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

" ========================================================
" vimplug
" ========================================================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'                                " Sensible defaults
Plug 'tpope/vim-endwise' 				                 " Auto end control flow
Plug 'tpope/vim-commentary'                              " Comments!
Plug 'scrooloose/nerdtree'                               " NerdTree
Plug 'vim-airline/vim-airline'                           " Cool bar
Plug 'tpope/vim-surround'                                " () {} []
Plug 'tpope/vim-fugitive'                                " Git integration
Plug 'lervag/vimtex'                                     " LaTeX integration
Plug 'neoclide/coc.nvim', {'branch': 'release'}          " Nice coc, bro
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }      " File searching
Plug 'junegunn/fzf.vim'                                  " |
Plug 'anufrievroman/vim-angry-reviewer'                  " Angry reviewer
Plug 'github/copilot.vim'                                " Github Copilot

call plug#end()

" ========================================================
" vimtex
" ========================================================
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0

" ========================================================
" NERDTree
" ========================================================
" Map Ctrl N to NERDTree
map <C-n> :NERDTreeToggle<CR>

" Close everything if :q is called when NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ========================================================
" CoC
" ========================================================
nmap <Leader>gd <Plug>(coc-definition)
nmap <Leader>gr <Plug>(coc-references)

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
" Angry Reviewer
" ========================================================
let g:AngryReviewerEnglish = 'british'

" ========================================================
" Keymaps
" ========================================================
nmap <Leader>wt :call setline(".", getline(".") . strftime("%F"))<CR>$

nnoremap <C-p> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>

map <C-j> :tabp<CR>
map <C-l> :tabn<CR>
map <C-k> :tabnew<CR>

nnoremap <Leader>ar :AngryReviewer<CR>
