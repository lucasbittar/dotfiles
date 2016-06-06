" Lucas's .vimrc

" VUNDLE PLUGINS {{{

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Utilities
Plugin 'Raimondi/delimitMate'
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'christoomey/vim-sort-motion'
Plugin 'flazz/vim-colorschemes'
Plugin 'kien/ctrlp.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'sickill/vim-pasta'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Language-specific plugin
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'gavocanov/vim-js-indent'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'ap/vim-css-color'
Plugin 'digitaltoad/vim-pug'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'mattn/emmet-vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'othree/yajs.vim'
Plugin 'rstacruz/sparkup'
Plugin 'scrooloose/syntastic'
call vundle#end() 

" }}}

" PLUGINS CONFIG {{{

" CtrlP
let g:ctrlp_cmd='CtrlPMixed'
let g:ctrlp_dotfiles=1
let g:ctrlp_working_path_mode = 'ra'

" Vim Indent Guides
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=2
let g:indent_guides_auto_colors=0

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=16

" Vim Airline
let g:airline_theme='hybridline'
let g:airline_powerline_fonts=1
let g:airline_skip_empty_sections = 1

" }}}

" DEFAULT SETTINGS {{{

filetype plugin on " Detect filetype
set nocompatible " Use vim features
set encoding=utf-8 " Set encoding
set history=5000 " Increase command line history
let mapleader="," " Set leader key to ,
set clipboard=unnamed " Use OS clipboard by default
set autoindent " Copy indent to the new line
set wildmenu " Enhance command-line completion
set tabstop=2 " Make tabs as wide as two spaces
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set incsearch " Search as characters are entered
set showmatch " Show matching brackets when text indicator is over them

" No sound errors
set noerrorbells
set novisualbell
set ai " Auto indent
set si " Smart indent

" Use relative numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif

" }}}

" KEY REMAPING {{{

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Space opens/closes folds
nnoremap <space> za
" Replace ESC key
inoremap jk <ESC>
" disable Ex mode
noremap Q <NOP>
" switch between current and last buffer
nmap <leader>. <c-^>

" Quick panel navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick tabs switching
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Line navigation ignores line wrap
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" }}}

" FOLDING {{{

set foldenable " Enable folding
set foldlevelstart=10 " Open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=indent " Fold based on indent level

" }}}

" TAB {{{

set expandtab " insert spaces for tabbed content
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=2 " the visible width of tabs
set softtabstop=2 " edit as if the tabs are 2 characters wide
set shiftwidth=2 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'
set completeopt+=longest

" Defines indentation for HTML files
autocmd FileType html setlocal expandtab shiftwidth=4 softtabstop=4

" }}}

" VISUAL {{{

syntax on " Enable syntax highlight

" Set theme
set t_Co=256
colorscheme Benokai
highlight Normal term=bold cterm=NONE ctermfg=white ctermbg=NONE

set laststatus=2 " Show status line
set showmode " Show what mode you're currently in
set showcmd " Show what commands you're typing
set modelines=1 " Enable modelines
set number " Show line number

" Hightlight line color
hi CursorLine cterm=NONE ctermbg=234

" Custom line number theme
highlight LineNr term=bold cterm=NONE ctermfg=242 ctermbg=234

set title " Show file title in terminal tab
set cursorline " Highlight current line
set ruler " Show cursor position

" Set status line
" set statusline=Filename:\ %F%m%r%h\ %w\ \ 
" set statusline+=Directory:\ %r%{getcwd()}%h\ \ \ 
" set statusline+=%=   " align right 
" set statusline+=%{fugitive#statusline()}\ \ " git status
" set statusline+=Line:\ %l\ \ 
" set statusline+=%{&fileformat}\ \ 
" set statusline+=%{strlen(&ft)?&ft:'none'}\ 

" Change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=60 ctermfg=231
  au InsertLeave * hi StatusLine term=reverse ctermfg=255 ctermbg=0
endif
 
" default the statusline to green when entering Vim
hi statusline ctermfg=255 ctermbg=0
 
" }}}

" Set manualy foldmethod to marker specifically for .vimrc
" vim:foldmethod=marker:foldlevel=0
