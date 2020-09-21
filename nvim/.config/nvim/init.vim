" Lucas's .vimrc

" PLUGINS {{{

call plug#begin()
Plug 'Raimondi/delimitMate'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'
Plug 'christoomey/vim-sort-motion'
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets'
Plug 'jefflund/colorschemer'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'mxw/vim-jsx'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/yajs.vim'
Plug 'rstacruz/sparkup'
Plug 'scrooloose/syntastic'
Plug 'sickill/vim-pasta'
Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" }}}

" PLUGINS CONFIG {{{

" FZF
set rtp+=~/.fzf
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" Hide statusline
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" coc extensions
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-snippets', 'coc-css', 'coc-highlight', 'coc-tsserver', 'coc-emmet', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier']

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

" Editorconfig
let g:EditorConfig_exec_path = '~/.editorconfig'

" }}}

" DEFAULT SETTINGS {{{

let g:python2_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

filetype plugin on " Detect filetype
let mapleader="," " Set leader key to ,
set encoding=utf-8 " Set encoding
set history=5000 " Increase command line history
set nocompatible " Use vim features
set spell " Set spell checking (use 'z=' to view suggestions)"

" Explorer
let g:netrw_banner = 0

if system('uname -s') == "Darwin\n"
  "OSX
  set clipboard=unnamed " Use OS clipboard by default
else
  "Linux
  set clipboard=unnamedplus " Use UNIX clipboard by default
endif

" :Prettier to format current buffer
command! -nargs=0 Prettier :CocCommand prettier.formatFile

set autoindent " Copy indent to the new line
set backupcopy=yes " Prevent VIM from renaming files
set colorcolumn=120
set hidden " Enables changing buffers without saving
set hlsearch " Highlight searches
set ignorecase " Ignore case of searches
set inccommand=split " Live search and replace
set incsearch " Search as characters are entered
set nobackup " Some servers have issues with backup files
set noswapfile
set nowrap " Don't wrap lines
set nowritebackup
set path+=** " Search down into subfolders
set scrolloff=5 " Offset top and bottom lines
set showmatch " Show matching brackets when text indicator is over them
set smartcase
set smartindent
set undodir=~/.config/nvim/undodir
set undofile
set updatetime=50 " You will have bad experience for diagnostic messages when it's default 4000.
set wildmenu " Enhance command-line completion

" Searching for slash as normal text
command! -nargs=1 Ss let @/ = <q-args>|set hlsearch

" Remove trailing white space
autocmd BufWritePre * :call TrimWhitespace()

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

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

" Open explorer pressing -
nnoremap - :Ex<CR>
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
nnoremap Q q
" Multi-mode mappings (Normal, Visual, Operating-pending modes).
noremap Y y$
" Edit vimrc file
nnoremap <leader>ev :edit $MYVIMRC<CR>
" Source vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>
" switch between current and last buffer
nnoremap <leader>. <c-^>
" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR><CR>:<backspace>
" kill all open buffers
nnoremap <leader>bd :bufdo bdelete<CR>
" Search and replace binding
nnoremap <leader>sr :%s/\<<C-r><C-w>\>/
" Edit file, starting in same directory as current file.
nnoremap <leader>e :edit <C-R>=expand('%:p:h') . '/'<CR>
" Toggle undotree
nnoremap <leader>u :UndotreeToggle<CR>
" Project finder
nnoremap <leader>a :Rg<CR>
" History finder
nnoremap <leader>h :History:<CR>
" Buffer finder
nnoremap <leader>b :Buffers<CR>
" Files finder
nnoremap <leader>f :Files<CR>
" Files finder (git)
nnoremap <leader>F :GFiles<CR>
" Find word in file
nnoremap <leader>/ :BLines<CR>
" Snippets finder
nnoremap <leader>s :Snippets<CR>
" gr - go to reference of word under cursor
nmap <silent> gr <Plug>(coc-reference)
" gd - go to definition of word under cursor
nmap <silent> gd <Plug>(coc-definition)
" rename the current word in the cursor
nmap <leader>cr  <Plug>(coc-rename)
" restart when tsserver gets wonky
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
" Show all diagnostics
nnoremap <silent> <leader>ld  :<C-u>CocList diagnostics<cr>
" Find symbol of current document
nnoremap <silent> <leader>ls  :<C-u>CocList outline<cr>
" Prev diagnostic
nmap <silent> <leader>k <Plug>(coc-diagnostic-prev)
" Next diagnostic
nmap <silent> <leader>j <Plug>(coc-diagnostic-next)
" Confirm completion.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" Moves selected line up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

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

" RIP GREP {{{

if executable('rg')
  let g:rg_derive_root='true'
  set grepprg=rg\ --vimgrep\ --smart-case\ --follow
  set grepformat^=%f:%l:%c:%m   " file:line:column:message
endif

" Don't search for file names
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

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

" My Custom Theme
source $HOME/.config/nvim/benokai.vim

set laststatus=2 " Show status line
set showmode " Show what mode you're currently in
set showcmd " Show what commands you're typing
set modelines=1 " Enable modelines
set number " Show line number

" display indentation guides
set list
set showbreak=↪\
set listchars=tab:┊\ ,eol:¬,nbsp:␣,trail:·,extends:»,precedes:«,nbsp:×

set title " Show file title in terminal tab
set cursorline " Highlight current line
set ruler " Show cursor position

" }}}

" Set manualy foldmethod to marker specifically for .vimrc
" vim:foldmethod=marker
