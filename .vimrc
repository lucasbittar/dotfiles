" Lucas's .vimrc

" Set manualy foldmethod to marker specifically for .vimrc
" vim:fdm=marker : foldlevel=0

" VUNDLE PLUGINS {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
call vundle#end() 
" }}}

" DEFAULT SETTINGS {{{
" Detect filetype
filetype plugin on
" Use vim features
set nocompatible
set encoding=utf-8
" Increase command line history
set history=5000
" Set leader key to ,
let mapleader="," 
" Use OS clipboard by default
set clipboard=unnamed
" Copy indent to the new line
set autoindent
" Enhance command-line completion
set wildmenu
" Make tabs as wide as two spaces
set tabstop=2
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Search as characters are entered
set incsearch
" Show matching brackets when text indicator is over them
set showmatch
" No sound errors
set noerrorbells
set novisualbell
" Auto indent
set ai
" Smart indent
set si
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
" }}}

" FOLDING {{{
" Enable folding
set foldenable
" Open most folds by default
set foldlevelstart=10
" 10 nested fold max
set foldnestmax=10
" Fold based on indent level
set foldmethod=indent
" }}}

" VISUAL {{{
" Enable syntax highlight
syntax on
" Show status line
set laststatus=2
" Show what mode you're currently in
set showmode
" Show what commands you're typing
set showcmd
" Enable modelines
set modelines=1
" Show line number
set number
" Show file title in terminal tab
set title
" Highlight current line
set cursorline
" Show cursor position
set ruler
" Set status line
set statusline=Filename:\ %F%m%r%h\ %w\ \ 
set statusline+=Directory:\ %r%{getcwd()}%h\ \ \ 
set statusline+=%=   " align right 
set statusline+=Line:\ %l\ \ 
set statusline+=%{&fileformat}\ \ 
set statusline+=%{strlen(&ft)?&ft:'none'}\ 
" Change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=5 gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
endif
" }}}
