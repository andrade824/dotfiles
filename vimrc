" ****************** VUNDLE STUFF ******************
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Indent line plugin
Plugin 'Yggdroot/indentline'

" Vim airline (better status bar)
Plugin 'bling/vim-airline'

" Molokai theme
Plugin 'tomasr/molokai'

" Automatically inserts matching parens (and other chars)
Plugin 'Townk/vim-autoclose'

" Make dealing with swap files easier
Plugin 'autoswap.vim'

" NERDTree
Plugin 'scrooloose/nerdtree'

" Easy alignment
Plugin 'junegunn/vim-easy-align'

" Syntastic
Plugin 'scrooloose/syntastic'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" " Put your non-Plugin stuff after this line

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Configure syntastic syntax checking to check on open as well as save

" Vim Airline (better status bar) config (:help airline)
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1 " Need to install powerline-fonts-git from AUR and set terminal font to Inconsolita-powerline
let g:airline_section_y = "" " No file encoding
let g:airline#extensions#whitespace#enabled = 0

" Configure molokai theme
let g:rehash256 = 1

" Configure NERDTree
map <leader>f :NERDTreeToggle<CR>

" Easy alignment config
vmap <CR> <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" Configure Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_cpp_compiler_options = ' -std=c++11'

" Set the default YouCompleteMe config file
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" Many of these options were taken from http://amix.dk/vim/vimrc.html
" He explains many of these options nicely

syntax on
set number

set smarttab
set tabstop=4
set shiftwidth=4
set expandtab

set smartindent
set cindent
set backspace=2
set ruler

set laststatus=2

" Format the status line (if not using airline)
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l/%L\ \ Column:\ %c\ \ Percent:\ %P

set showcmd
set showmode
set hidden
set autowrite
set autoread
set sw=4
set clipboard=unnamedplus
set mouse=a
set nostartofline
set confirm
set cmdheight=2
set wildmenu
set wildmode=longest:full,full
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set lazyredraw
set magic
set showmatch
set mat=2
set encoding=utf8

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

colorscheme molokai
set background=dark
set t_Co=256

set incsearch
set hlsearch
set ignorecase

" 'a' moves to beginning of line and enters insert
nmap a I

" Save and Quit set to ,s
nmap <leader>s :wq<cr>

map <leader>h <C-W>h
map <leader>l <C-W>l
map <leader>j <C-W>j
map <leader>k <C-W>k

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Useful mappings for managing buffers
map <leader>n :bn<cr>
map <leader>p :bp<cr>
map <leader>d :bd<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Insert a new line after the current line by pressing Enter
" (Shift-Enter for inserting a line before the current line)
nmap <CR> o<Esc>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction
