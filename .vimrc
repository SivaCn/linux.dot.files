"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

" Set the color Scheme
colorscheme wombat256mod

"activate pathogen
call pathogen#infect()

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
    let &colorcolumn="79,99,".join(range(119,999),",")
endif

"default indent settings
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=15
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

"statusline setup
set laststatus=2  " Show the status line always.
"
" Check for the Trailing White spaces in the opened file.
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[** Error: Trailing Space: use: ,dws **]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning


" Delete all Blank Lines
fun! DelTrailingWhiteSpaces()
   let _s=@/
   let l = line(".")
   let c = col(".")
   :%s/\s\+$//
   let @/=_s
   call cursor(l, c)
endfun

map <special> <leader>dws :keepjumps call DelTrailingWhiteSpaces()<cr>

" jamessan's
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=[\ Siva\ Cn\ ]\                " Tag
set statusline+=[\ File:\                      " Label
set statusline+=%f\ ]\                         " file name
set statusline+=%h%m%r%w                       " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},\   " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc},\  " encoding
set statusline+=%{&fileformat}]                " file format
set statusline+=%=                             " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                     " current char
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=\                              " Empty white space
set statusline+=%-14.(%l,%c%V%)\ %<%P          " offset

" ---------------------- START: CUSTOM FUNCTIONS ---------------------
function! InsertInlineComment()
  let trace = "#\n"
  let trace = trace . "# "
  execute "normal O".trace
endfunction

function! InsertPDB()
  let trace = expand("import pdb; pdb.set_trace() ## XXX: Remove This")
  execute "normal O".trace
endfunction

function! InsertDocStr()
  let trace = append('.', [
          \"'''DocStr.",
          \"",
          \"Usage:",
          \"",
          \"Note:",
          \"",
          \"Args:",
          \"",
          \"Raises:",
          \"",
          \"Returns:",
          \"",
          \"'''",
          \""])[1]

  execute "normal O".trace
endfunction

function! InsertStr()
  let trace = append('.', [
          \"    def __repr__(self):",
          \"        '''Overridden str method implementation.",
          \"        '''",
          \"",
          \"        return '''{}'''.format()",
          \""])[1]

  return trace
endfunction

function! InsertRepr()
  let trace = append('.', [
          \"    def __repr__(self):",
          \"        '''Overridden repr method implementation.",
          \"        '''",
          \"",
          \"        return '''<ClassName({})>'''.format()",
          \""])[1]

  return trace
endfunction

function! InsertInit()
  let trace = append('.', [
          \"    def __init__(self):",
          \"        '''Initialization Block.",
          \"",
          \"        Usage:",
          \"",
          \"        Note:",
          \"",
          \"        Args:",
          \"",
          \"        Raises:",
          \"",
          \"        Returns:",
          \"",
          \"        '''",
          \"",
          \"        pass",
          \""])[1]

  return trace
endfunction

function! InsertCall()
  let trace = append('.', [
          \"    def __call__(self):",
          \"        '''Making instance callable.",
          \"",
          \"        Usage:",
          \"",
          \"        Note:",
          \"",
          \"        Args:",
          \"",
          \"        Raises:",
          \"",
          \"        Returns:",
          \"",
          \"        '''",
          \"",
          \"        pass",
          \""])[1]

  return trace
endfunction

function! InsertInstanceMethod()
  let trace = append('.', [
          \"def func(self):",
          \"    '''Instance method for.",
          \"",
          \"    Usage:",
          \"",
          \"    Note:",
          \"",
          \"    Args:",
          \"",
          \"    Raises:",
          \"",
          \"    Returns:",
          \"",
          \"    '''",
          \"",
          \"    pass",
          \""])[1]

  execute "normal O".trace
endfunction

function! InsertClassMethod()
  let trace = append('.', [
          \"@classmethod",
          \"def func(cls):",
          \"    '''Class method for.",
          \"",
          \"    Usage:",
          \"",
          \"    Note:",
          \"",
          \"    Args:",
          \"",
          \"    Raises:",
          \"",
          \"    Returns:",
          \"",
          \"    '''",
          \"",
          \"    return",
          \""])[1]

  execute "normal O".trace
endfunction

function! InsertClass()
  let trace = [
          \"class ClassName(object):\n".
          \"'''A Class for .'''".
          \InsertRepr()[1].
          \InsertStr()[1].
          \InsertCall()[1].
          \InsertInit()[1]][0]

  execute "normal O".trace
endfunction
" ---------------------- END: CUSTOM FUNCTIONS ---------------------

" Custom Key bindings
map <Leader>pdb :call InsertPDB()<CR>
map <Leader>c :call InsertClass()<CR>
map <Leader>cm :call InsertClassMethod()<CR>
map <Leader>ds :call InsertDocStr()<CR>
map <Leader>im :call InsertInstanceMethod()<CR>
map <Leader>com :call InsertInlineComment()<CR>

nmap <F8> :TagbarToggle<CR>
