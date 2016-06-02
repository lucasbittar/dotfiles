" Lucas's .vimrc

" VUNDLE PLUGINS {{{

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'christoomey/vim-sort-motion'
Plugin 'flazz/vim-colorschemes'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
call vundle#end() 

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

" }}}

" FOLDING {{{

set foldenable " Enable folding
set foldlevelstart=10 " Open most folds by default
set foldnestmax=10 " 10 nested fold max
set foldmethod=syntax " Fold based on indent level

" }}}

" VISUAL {{{

syntax on " Enable syntax highlight

" Set theme
set t_Co=256
colorscheme Benokai
highlight Normal term=bold cterm=NONE ctermfg=white ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

set laststatus=2 " Show status line
set showmode " Show what mode you're currently in
set showcmd " Show what commands you're typing
set modelines=1 " Enable modelines
set number " Show line number

" Custom line number theme
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=0 gui=NONE guifg=DarkGrey guibg=NONE

set title " Show file title in terminal tab
set cursorline " Highlight current line
set ruler " Show cursor position

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

" Set manualy foldmethod to marker specifically for .vimrc
" vim:foldmethod=marker:foldlevel=0
