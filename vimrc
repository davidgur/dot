set nocompatible
filetype off

" vim-plug

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-fugitive'       " Git
Plug 'scrooloose/nerdtree'      " NerdTree
Plug 'itchyny/lightline.vim'    " Cool bar
Plug 'tpope/vim-surround'       " () {} []
Plug 'airblade/vim-gitgutter'   " More git
Plug 'lervag/vimtex'            " LaTeX integration
Plug 'tpope/vim-endwise'        " Automatically end control-flow statements
Plug 'morhetz/gruvbox'          " Ugly color scheme
Plug 'vim-python/python-syntax' " Python syntax highlighting
Plug 'junegunn/goyo.vim'        " Writing longform
Plug 'mbbill/undotree'          " UndoTree
Plug 'jeaye/color_coded'        " C/C++ syntax highlighting

call plug#end()

" ---- Rest of the vim stuff ----

" Git project CtrlP stuff
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
" End Git project CtrlP stuff

" Ensure :q to quit even whe Goyo is active
function! s:goyo_enter()
    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
    " Quit vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
            qa!
        else
            qa
        endif
    endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" Encoding
set encoding=utf-8
set fileencoding=utf-8

" Clipboard
set clipboard=unnamed

" Map Ctrl N to NerdTree
map <C-n> :NERDTreeToggle<CR>

" Close everything if :q is called when NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" colorscheme
syntax on
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
let python_highlight_all=1


" Compton / transparency
hi Normal guibg=NONE ctermbg=NONE

" Tabs --> 4 Spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Show line numbers
set number

" Something to do with lightline
set laststatus=2

" No more bells
set belloff=all
" Use I block
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' | 
    \   silent execute '!echo -ne "\e[5 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[3 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

" Keymaps
let mapleader = "\<Space>"

nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>O :CtrlP<CR>
nnoremap <Leader>W :w<CR>
nnoremap <Leader>Q :q<CR>
nnoremap <Leader>u :UndotreeToggle<CR>
nnoremap <Leader>U :UndotreeToggle<CR>

imap <C-Space> <Esc>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa


map <C-j> :tabp<CR>
map <C-l> :tabn<CR>
map <C-k> :tabnew<CR>

map <silent><F11> :Goyo<CR>:set linebreak<CR>:set wrap<CR> :setlocal spell! spelllang=en_gb<CR>
