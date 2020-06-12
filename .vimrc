
" encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible


" -------------------------=== Plugin Setups ===-----------------------------

filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

    " let Vundle manage Vundle, required
    " This must be cloned first to begin with.
    " clone https://github.com/VundleVim/Vundle.vim.git this repo into ~/.vim/bundle/Vundle.vim
    Plugin 'VundleVim/Vundle.vim'               " https://github.com/VundleVim/Vundle.vim.git

    Plugin 'bling/vim-airline'                  " Lean & mean status/tabline for vim
    Plugin 'vim-airline/vim-airline-themes'     " Themes for airline
    Plugin 'Lokaltog/powerline'                 " {'rtp': 'powerline/bindings/vim/'}   Powerline fonts plugin

    Plugin 'tpope/vim-commentary'               " Comment stuff out
    Plugin 'terryma/vim-multiple-cursors'

    Plugin 'scrooloose/syntastic'               " Syntax checking plugin for Vim

call vundle#end()

filetype on


" Set the color Scheme
colorscheme wombat256mod

" Map a leader Key.
let mapleader = ","

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set number      "show line numbers

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:\ ,nbsp:\

set incsearch   "find the next match as we type the search
set hlsearch!    "hilight searches by default
set ignorecase  " Ignore Case while search
set smartcase

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Toggle Search Highlights
nnoremap <F3> :set hlsearch!<CR>

" paste by default
set paste
" Toggle paste.
set pastetoggle=<F2>

" Highlight CursorLine and CursorColumn
set cursorline
set cursorcolumn

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Habit Breaker
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

set wrap        "dont wrap lines
set linebreak   "wrap lines at convenient points

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile

    " set colorcolumn=79,99,119 "mark the ideal max text width
    let &colorcolumn="79,99,119"
endif

"default indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"default text width during paragraph formating
set textwidth=100

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=100       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=10
set sidescrolloff=10
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"some stuff to get the mouse going in term
"set mouse=a
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

" ----------------------=== Customizations ===----------------------------
"=====================================================
"" AirLine settings
"=====================================================
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#formatter='unique_tail'
" let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#formatter = 'default'
" let g:airline_theme='luna'

" 切换 buffer
nnoremap <C-N> :bn<CR> 
nnoremap <C-P> :bp<CR> 

" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 1 
let g:airline#extensions#whitespace#symbol = '!' 
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

"  " powerline symbols
"  let g:airline_left_sep = ''
"  let g:airline_left_alt_sep = ''
"  let g:airline_right_sep = ''
"  let g:airline_right_alt_sep = ''
"  let g:airline_symbols.branch = ''
"  let g:airline_symbols.readonly = ''
"  let g:airline_symbols.linenr = '☰'
"  let g:airline_symbols.maxlinenr = ''



"""""""""""" Start Powerline Settings """"""""""""""""

" set guifont=Inconsolata\ for\ Powerline:h15
set guifont=Source\ Code\ Pro\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

if has("gui_running")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set guifont=Source\ Code\ Pro\ for\ Powerline:h15
        colorscheme PaperColor              " set color scheme
    endif
endif

""""""""""" END of PowerLine Settings """""""""""""""

" syntastic
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1
let g:syntastic_check_on_wq=0
let g:syntastic_aggregate_errors=1
let g:syntastic_loc_list_height=5
let g:syntastic_error_symbol='X'
let g:syntastic_style_error_symbol='X'
let g:syntastic_warning_symbol='x'
let g:syntastic_style_warning_symbol='x'
let g:syntastic_python_checkers=['flake8', 'pydocstyle', 'python3.6']



" Multi Cursor
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'



" ---------------------- START: CUSTOM FUNCTIONS ---------------------

function! InsertPDB()
  let trace = expand("import pdb; pdb.set_trace() ## XXX: Remove This")
  execute "normal O".trace
endfunction

" Delete all Blank Lines
fun! DelTrailingWhiteSpaces()
   let _s=@/
   let l = line(".")
   let c = col(".")
   :%s/\s\+$//
   let @/=_s
   call cursor(l, c)
endfun

" ---------------------- END: CUSTOM FUNCTIONS ---------------------

" Insert python pdb
map <Leader>pdb :call InsertPDB()<CR>

" Delete all trailing white spaces
map <special> <leader>dws :keepjumps call DelTrailingWhiteSpaces()<cr>

nmap <F8> :TagbarToggle<CR>

