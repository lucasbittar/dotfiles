" Lucas's .vimrc

" PLUGINS {{{

call plug#begin()
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-sort-motion'
Plug 'editorconfig/editorconfig-vim'
Plug 'edkolev/tmuxline.vim'
Plug 'elzr/vim-json'
Plug 'honza/vim-snippets'
Plug 'jefflund/colorschemer'
Plug 'junegunn/fzf.vim'
Plug 'mxw/vim-jsx'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
Plug 'rstacruz/sparkup'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" }}}

" PLUGINS CONFIG {{{

" Setup FZF
set rtp+=/usr/local/opt/fzf

" coc extensions
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-snippets', 'coc-highlight', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']

" ultisnips
let g:UltiSnipsExpandTrigger = "<tab>"

" indentLine
let g:indentLine_enabled = 1
let g:indentLine_char = '⎸'
let g:indentLine_color_term = 236

" Vim Airline
" Top picks: angr, dark, dark_minimal, durant, minimalist, onedark, ravenpower, term
let g:airline_theme='dark'
let g:airline_powerline_fonts=1
let g:airline_skip_empty_sections=0
let g:airline#extensions#coc#enabled = 1
" let g:airline_extensions = ['hunks', 'branch', 'ale']

" Editorconfig
let g:EditorConfig_exec_path = '~/.editorconfig'

" GitGutter
autocmd VimEnter,Colorscheme * :hi GitGutterAdd ctermbg=233 ctermfg=41 guibg=#121212 guifg=#00d75f
autocmd VimEnter,Colorscheme * :hi GitGutterChange ctermbg=233 ctermfg=184 guibg=#121212 guifg=#d7d700
autocmd VimEnter,Colorscheme * :hi GitGutterDelete ctermbg=233 ctermfg=167 guibg=#121212 guifg=#d75f5f
autocmd VimEnter,Colorscheme * :hi GitGutterChangeDelete ctermbg=233 ctermfg=30 guibg=#121212 guifg=#008787

" }}}

" DEFAULT SETTINGS {{{

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

filetype plugin on " Detect filetype
set nocompatible " Use vim features
set encoding=utf-8 " Set encoding
set history=5000 " Increase command line history
let mapleader="," " Set leader key to ,

if system('uname -s') == "Darwin\n"
  "OSX
  set clipboard=unnamed " Use OS clipboard by default
else
  "Linux
  set clipboard=unnamedplus " Use UNIX clipboard by default
endif

set nobackup " Some servers have issues with backup files
set nowritebackup
set updatetime=300 " You will have bad experience for diagnostic messages when it's default 4000.
set hidden " Enables changing buffers without saving
set inccommand=split " Live search and replace
set autoindent " Copy indent to the new line
set wildmenu " Enhance command-line completion
set path+=** " Search down into subfolders
set tabstop=2 " Make tabs as wide as two spaces
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set incsearch " Search as characters are entered
set showmatch " Show matching brackets when text indicator is over them
set backupcopy=yes " Prevent VIM from renaming files
set scrolloff=5 " Offset top and bottom lines

" Searching for slash as normal text
command! -nargs=1 Ss let @/ = <q-args>|set hlsearch

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

" Pulls completions from current file, other buffers (closed or still open),
" and from the current tags file
set complete=.,b,u,]

" }}}

" KEY REMAPING {{{

" Edit vimrc file
nmap <leader>ev :edit $MYVIMRC<CR>
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<CR> 
" switch between current and last buffer
nmap <leader>. <c-^>
" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR><CR>:<backspace>
" kill all open buffers
nnoremap <leader>bd :bufdo bdelete<CR>
" Search and replace binding
nnoremap <Leader>sr :%s/\<<C-r><C-w>\>/
" Edit file, starting in same directory as current file.
nnoremap <Leader>e :edit <C-R>=expand('%:p:h') . '/'<CR>
" Space opens/closes folds
nnoremap <space> za
" Replace ESC key
inoremap jk <ESC>
" disable Ex mode
noremap Q <NOP>
" next quicklist result
nnoremap ]q :cnext<CR>
" previuos quicklist result
nnoremap [q :cprev<CR>
" Avoid unintentional switches to Ex mode.
nmap Q q
" Multi-mode mappings (Normal, Visual, Operating-pending modes).
noremap Y y$
" Project finder
nmap <Leader>a :Ag<CR>
" Buffer finder
nmap <Leader>b :Buffers<CR>
" Files finder
nmap <Leader>f :Files<CR>
" Snippets finder
nmap <Leader>s :Snippets<CR>
" gd - go to definition of word under cursor
nmap <silent> gd <Plug>(coc-definition)
" rename the current word in the cursor
nmap <leader>cr  <Plug>(coc-rename)
" restart when tsserver gets wonky
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Show all diagnostics
nnoremap <silent> <Leader>ld  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <Leader>ls  :<C-u>CocList outline<cr>
" Prev diagnostic
nmap <silent> <Leader>k <Plug>(coc-diagnostic-prev)
" Next diagnostic
nmap <silent> <Leader>j <Plug>(coc-diagnostic-next)
" Confirm completion.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'

" Repurpose cursor keys for quicklist navigation.
nnoremap <silent> <Up> :cprevious<CR>
nnoremap <silent> <Down> :cnext<CR>
nnoremap <silent> <Left> :cpfile<CR>
nnoremap <silent> <Right> :cnfile<CR>

" Quick panel navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Store relative line number jumps in the jumplist if they exceed a threshold.
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : '') . 'j'

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

" SILVER SEARCHER {{{

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
  set grepformat^=%f:%l:%c:%m   " file:line:column:message
endif

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
autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2

" }}}

" VISUAL {{{

syntax on " Enable syntax highlight

" Set theme
set t_Co=256
set termguicolors

set background=dark

if exists("syntax_on")
  syntax reset
endif

" Benokai
hi Cursor ctermfg=235 ctermbg=231 cterm=NONE guifg=#262626 guibg=#ffffff gui=NONE
hi Visual ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#5f5f5f gui=NONE
hi CursorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3a3a3a gui=NONE
hi ColorColumn ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3a3a3a gui=NONE
hi VertSplit ctermfg=241 ctermbg=241 cterm=NONE guifg=#626262 guibg=#626262 gui=NONE
hi MatchParen ctermfg=197 ctermbg=NONE cterm=underline guifg=#ff005f guibg=NONE gui=underline
hi StatusLine ctermfg=231 ctermbg=241 cterm=bold guifg=#ffffff guibg=#626262 gui=bold
hi StatusLineNC ctermfg=231 ctermbg=241 cterm=NONE guifg=#ffffff guibg=#626262 gui=NONE
hi Pmenu ctermfg=250 ctermbg=235 cterm=NONE guifg=#bcbcbc guibg=#262626 gui=NONE
hi PmenuSel ctermfg=255 ctermbg=237 cterm=bold guifg=#eeeeee guibg=#3a3a3a gui=NONE
hi IncSearch ctermfg=235 ctermbg=186 cterm=NONE guifg=#262626 guibg=#d7d787 gui=NONE
hi Directory ctermfg=141 ctermbg=NONE cterm=NONE guifg=#ae81ff guibg=NONE gui=NONE
hi Folded ctermfg=242 ctermbg=235 cterm=NONE guifg=#75715e guibg=#262626 gui=NONE
hi Boolean ctermfg=141 ctermbg=NONE cterm=italic,bold guifg=#af87ff guibg=NONE gui=italic,bold
hi Character ctermfg=141 ctermbg=NONE cterm=NONE guifg=#af87ff guibg=NONE gui=NONE
hi Comment ctermfg=242 ctermbg=NONE cterm=italic guifg=#75715e guibg=NONE gui=italic
hi Conditional ctermfg=197 ctermbg=NONE cterm=NONE guifg=#ff005f guibg=NONE gui=NONE
hi Constant ctermfg=NONE ctermbg=NONE cterm=bold guifg=NONE guibg=NONE gui=NONE
hi Define ctermfg=197 ctermbg=NONE cterm=NONE guifg=#ff005f guibg=NONE gui=NONE
hi DiffAdd ctermfg=231 ctermbg=64 cterm=bold guifg=#ffffff guibg=#5f8700 gui=bold
hi DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#870000 guibg=NONE gui=NONE
hi DiffChange ctermfg=231 ctermbg=23 cterm=NONE guifg=#ffffff guibg=#005f5f gui=NONE
hi DiffText ctermfg=231 ctermbg=24 cterm=bold guifg=#ffffff guibg=#005f87 gui=bold
hi ErrorMsg ctermfg=231 ctermbg=197 cterm=NONE guifg=#ffffff guibg=#ff005f gui=NONE
hi WarningMsg ctermfg=231 ctermbg=197 cterm=NONE guifg=#ffffff guibg=#ff005f gui=NONE
hi Float ctermfg=141 ctermbg=NONE cterm=NONE guifg=#af87ff guibg=NONE gui=NONE
hi Function ctermfg=148 ctermbg=NONE cterm=bold guifg=#afd700 guibg=NONE gui=bold
hi Identifier ctermfg=81 ctermbg=NONE cterm=bold,italic guifg=#5fd7ff guibg=NONE gui=bold,italic
hi Keyword ctermfg=197 ctermbg=NONE cterm=NONE guifg=#ff005f guibg=NONE gui=NONE
hi Label ctermfg=186 ctermbg=NONE cterm=NONE guifg=#d7d787 guibg=NONE gui=NONE
hi Number ctermfg=141 ctermbg=NONE cterm=bold guifg=#af87ff guibg=NONE gui=bold
hi Structure ctermfg=141 ctermbg=NONE cterm=NONE guifg=#af87ff guibg=NONE gui=NONE
hi Operator ctermfg=197 ctermbg=NONE cterm=NONE guifg=#ff005f guibg=NONE gui=NONE
hi PreProc ctermfg=197 ctermbg=NONE cterm=NONE guifg=#ff005f guibg=NONE gui=NONE
hi Special ctermfg=231 ctermbg=NONE cterm=NONE guifg=#ffffff guibg=NONE gui=NONE
hi Statement ctermfg=197 ctermbg=NONE cterm=bold guifg=#ff005f guibg=NONE gui=bold
hi StorageClass ctermfg=81 ctermbg=NONE cterm=NONE guifg=#5fd7ff guibg=NONE gui=italic
hi String ctermfg=186 ctermbg=NONE cterm=NONE guifg=#d7d787 guibg=NONE gui=NONE
hi Tag ctermfg=197 ctermbg=NONE cterm=bold guifg=#ff005f guibg=NONE gui=bold
hi Title ctermfg=231 ctermbg=NONE cterm=bold guifg=#ffffff guibg=NONE gui=bold
hi Todo ctermfg=95 ctermbg=NONE cterm=inverse,bold guifg=#75715e guibg=NONE gui=inverse,bold
hi Type ctermfg=231 ctermbg=NONE cterm=NONE guifg=#ffffff guibg=NONE gui=NONE
hi Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
hi htmlH1 ctermfg=231 ctermbg=NONE cterm=NONE guifg=#ffffff guibg=NONE gui=NONE
hi htmlH2 ctermfg=254 ctermbg=NONE cterm=NONE guifg=#e4e4e4 guibg=NONE gui=NONE
hi htmlH3 ctermfg=252 ctermbg=NONE cterm=NONE guifg=#d0d0d0 guibg=NONE gui=NONE
hi htmlH4 ctermfg=251 ctermbg=NONE cterm=NONE guifg=#c6c6c6 guibg=NONE gui=NONE
hi htmlH5 ctermfg=250 ctermbg=NONE cterm=NONE guifg=#bcbcbc guibg=NONE gui=NONE
hi htmlH6 ctermfg=249 ctermbg=NONE cterm=NONE guifg=#b2b2b2 guibg=NONE gui=NONE
hi htmlSpecialChar ctermfg=141 ctermbg=NONE cterm=NONE guifg=#af87ff guibg=NONE gui=NONE
hi yamlKey ctermfg=197 ctermbg=NONE cterm=NONE guifg=#ff005f guibg=NONE gui=NONE
hi yamlAnchor ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlAlias ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
hi yamlDocumentHeader ctermfg=186 ctermbg=NONE cterm=NONE guifg=#d7d787 guibg=NONE gui=NONE
" hi cssURL ctermfg=208 ctermbg=NONE cterm=NONE guifg=#fd971f guibg=NONE gui=italic
" hi cssFunctionName ctermfg=81 ctermbg=NONE cterm=NONE guifg=#5fd7ff guibg=NONE gui=NONE
" hi cssColor ctermfg=141 ctermbg=NONE cterm=NONE guifg=#af87ff guibg=NONE gui=NONE
" hi cssPseudoClassId ctermfg=148 ctermbg=NONE cterm=NONE guifg=#afd700 guibg=NONE gui=NONE
" hi cssClassName ctermfg=148 ctermbg=NONE cterm=NONE guifg=#afd700 guibg=NONE gui=NONE
" hi cssValueLength ctermfg=141 ctermbg=NONE cterm=NONE guifg=#af87ff guibg=NONE gui=NONE
" hi cssCommonAttr ctermfg=81 ctermbg=NONE cterm=NONE guifg=#5fd7ff guibg=NONE gui=NONE
" hi cssBraces ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

highlight clear SignColumn

highlight Normal cterm=bold ctermfg=white ctermbg=NONE guifg=#ffffff guibg=NONE

set laststatus=2 " Show status line
set showmode " Show what mode you're currently in
set showcmd " Show what commands you're typing
set modelines=1 " Enable modelines
set number " Show line number

" display indentation guides
set list
set showbreak=↪\
set listchars=tab:┊\ ,eol:¬,nbsp:␣,trail:·,extends:»,precedes:«,nbsp:×

"Invisible character colors
hi NonText ctermfg=238 guifg=#444444
hi SpecialKey ctermfg=238 guifg=#444444

" Hightlight line color
hi CursorLine cterm=NONE ctermbg=234 guibg=#1c1c1c

" Hightlight search result
hi Search ctermbg=NONE ctermfg=227 guibg=#303030 guifg=#ffff5f

hi TabLineFill ctermfg=231 ctermbg=16 guifg=#ffffff
hi TabLine ctermfg=250 ctermbg=16 guifg=#bcbcbc
hi TabLineSel ctermfg=231 ctermbg=240 guifg=#ffffff

" Custom line number theme
hi LineNr cterm=bold ctermfg=242 ctermbg=233 guifg=#6c6c6c guibg=#121212 gui=bold

set title " Show file title in terminal tab
set cursorline " Highlight current line
set ruler " Show cursor position

" }}}


" Set manualy foldmethod to marker specifically for .vimrc
" vim:foldmethod=marker
