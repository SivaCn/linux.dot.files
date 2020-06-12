"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

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

