set nocompatible
filetype plugin on

" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-endwise'        " Automatically end control flow
Plug 'scrooloose/nerdtree'      " NerdTree
Plug 'vim-airline/vim-airline'  " Cool bar
Plug 'tpope/vim-surround'       " () {} []
Plug 'lervag/vimtex'            " LaTeX integration
Plug 'morhetz/gruvbox'          " Ugly color scheme
Plug 'junegunn/goyo.vim'        " Writing longform
Plug 'neoclide/coc.nvim' , {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'         " File searching
Plug 'vimwiki/vimwiki'          " Wiki Organization for notes

call plug#end()

" ---- Rest of the vim stuff ----

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

" vimwiki
let g:vimwiki_list = [{'path':'~/Documents/school/waterloo', 'path_html':'~/Documents/school/waterloo/export'}]

" Encoding
set encoding=utf-8
set fileencoding=utf-8

" Clipboard
set clipboard=unnamed

" Map Ctrl N to NerdTree
map <C-n> :NERDTreeToggle<CR>

" Close everything if :q is called when NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Function to strip trailing whitespace
function! StripTrailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

autocmd BufWritePre * :call StripTrailingWhitespace()

" coc
" -- Always show sign column
if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

" -- Tab for completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" colorscheme
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
syntax on

" Compton / transparency
hi Normal guibg=NONE ctermbg=NONE

" Tabs --> 4 Spaces
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set shiftround

" Always split to the right side of the screen
set splitright

" Performance
set lazyredraw

" Show line numbers (hybrid mode)
set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Airline
set laststatus=2
let g:airline_detect_modified=1
let g:airline_powerline_fonts=1

" No more bells
set belloff=all

" Keymaps
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>W :wq<CR>
nnoremap <Leader>Q :q!<CR>
nnoremap <C-p> :Files<CR>

nmap <Leader>gd <Plug>(coc-definition)
nmap <Leader>gr <Plug>(coc-references)

nmap <Leader>wt :call setline(".", getline(".") . strftime("%F"))<CR>$

nmap <Leader>t :vertical term <CR><C-w>w :execute "vertical resize" . string(&columns * 0.75)<CR><C-w>w

imap <C-Space> <Esc>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

map <C-j> :tabp<CR>
map <C-l> :tabn<CR>
map <C-k> :tabnew<CR>

map <silent><F11> :Goyo<CR>:set linebreak<CR>:set wrap<CR> :setlocal spell! spelllang=en_gb<CR>
