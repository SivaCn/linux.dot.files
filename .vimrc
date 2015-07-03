" ~/.vimrc

if filereadable(expand('~/src/vim/bundle/vim-pathogen/autoload/pathogen.vim'))
  source ~/src/vim/bundle/vim-pathogen/autoload/pathogen.vim
endif
if has("win32")
  let &runtimepath = substitute(&runtimepath,'\(Documents and Settings\|Users\)[\\/][^\\/,]*[\\/]\zsvimfiles\>','.vim','g')
endif
silent! execute pathogen#infect("~/src/vim/vendor/{}")
silent! execute pathogen#infect("~/src/vim/bundle/{}")

" Section: Options {{{1
" ---------------------

" Rebind <Leader> key
" " I like to have it here becuase it is easier to reach than the default and
" " it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>


" Quicksave command
"" noremap <C-Z> :update<CR>
"" vnoremap <C-Z> <C-C>:update<CR>
"" inoremap <C-Z> <C-O>:update<CR>


" Quick quit command
"" noremap <Leader>e :quit<CR>  " Quit current window
"" noremap <Leader>E :qa!<CR>   " Quit all windows


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>


" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Highlight the Text Excceding column 80 in RED.
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on

" For highlighted numbers:
let python_highlight_numbers = 1
"
" For highlighted builtin functions:
let python_highlight_builtins = 1
"
" For highlighted standard exceptions:
let python_highlight_exceptions = 1
"
" Highlight erroneous whitespace:
let python_highlight_space_errors = 1
"
" If you want all possible Python highlighting (the same as setting the
" preceding options):
let python_highlight_all = 1

" -------- Python Folding -----------
set foldmethod=indent

" Showing line numbers and length
set number  " show line numbers
""set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
" set colorcolumn=80
highlight ColorColumn ctermbg=233


" easier formatting of paragraphs
vmap Q gq
nmap Q gqap


" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

set number
set nocompatible
set autoindent
set autowrite       " Automatically save before commands like :next and :make
set backspace=2
if has("balloon_eval") && has("unix")
  set ballooneval
endif
if exists("&breakindent")
  set breakindent showbreak=+++
endif
set cmdheight=2
set commentstring=#\ %s
set complete-=i     " Searching includes can be slow
set dictionary+=/usr/share/dict/words
set display=lastline
if has("eval")
  let &fileencodings = substitute(&fileencodings,"latin1","cp1252","")
endif
set fileformats=unix,dos,mac
set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude=tags
if has("eval")
  let &highlight = substitute(&highlight,'NonText','SpecialKey','g')
endif
set incsearch       " Incremental search
set laststatus=2    " Always show status line
set lazyredraw
if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
  let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
  let &fillchars = "vert:\u259a,fold:\u00b7"
else
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<
endif
set mousemodel=popup
set pastetoggle=<F2>
set scrolloff=1
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set smartcase       " Case insensitive searches become sensitive with capitals
"set smarttab        " sw at the start of the line, sts everywhere else
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

set cursorline
"set cursorcolumn

if exists("+spelllang")
  set spelllang=en_us
endif
set spellfile=~/.vim/spell/en.utf-8.add
set splitbelow      " Split windows at bottom
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{SL('CapsLockStatusline')}%y%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P
" set suffixes+=.aux,.dvi,.swo  " Lower priority in wildcards
set tags+=../tags;/
set timeoutlen=1200 " A little bit more time for macros
set ttimeoutlen=50  " Make Esc work faster
if exists('+undofile')
  set undofile
endif
if v:version >= 700
  set viminfo=!,'20,<50,s10,h
endif
set visualbell
set virtualedit=block
set wildmenu
set wildmode=longest:full,full
set wildignore+=tags
set winaltkeys=no

if v:version >= 600
  set autoread
  set foldmethod=marker
  set printoptions=paper:letter
  set sidescrolloff=5
  set mouse=nvi
endif


if !has("gui_running") && $DISPLAY == '' || !has("gui")
  set mouse=
endif

if $TERM =~ '^screen'
  if exists("+ttymouse") && &ttymouse == ''
    set ttymouse=xterm
  endif
  if $TERM != 'screen.linux' && &t_Co == 8
    set t_Co=16
  endif
endif

if has("dos16") || has("dos32") || has("win32") || has("win64")
  if $PATH =~? 'cygwin' && ! exists("g:no_cygwin_shell")
    set shell=bash
    set shellpipe=2>&1\|tee
    set shellslash
  endif
elseif has("mac")
  set backupskip+=/private/tmp/*
endif

" ----------------------------------------------------------------------
"  USEFUL SETTINGS
" ----------------------------------------------------------------------
set scrolloff=8

" Following are some useful mappings to make search results appear in the
" middle of the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Plugin Settings {{{2

if v:version >= 700
  let g:is_bash = 1
  let g:sh_noisk = 1
  let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh', 'sh']
  let g:liquid_highlight_types = g:markdown_fenced_languages + ['jinja=liquid', 'html+erb=eruby.html', 'html+jinja=liquid.html']
  let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'

  let g:CSApprox_verbose_level = 0
  let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
  let g:NERDTreeHijackNetrw = 0
  let g:ragtag_global_maps = 1
  let g:space_disable_select_mode = 1
  let g:VCSCommandDisableMappings = 1
  let g:showmarks_enable = 0
  let g:surround_{char2nr('-')} = "<% \r %>"
  let g:surround_{char2nr('=')} = "<%= \r %>"
  let g:surround_{char2nr('8')} = "/* \r */"
  let g:surround_{char2nr('s')} = " \r"
  let g:surround_{char2nr('^')} = "/^\r$/"
  let g:surround_indent = 1

  function! s:try(cmd, default)
    if exists(':' . a:cmd) && !v:count
      let tick = b:changedtick
      exe a:cmd
      if tick == b:changedtick
        execute 'normal! '.a:default
      endif
    else
      execute 'normal! '.v:count.a:default
    endif
  endfunction

  nnoremap <silent> gJ :<C-U>call <SID>try('SplitjoinJoin', 'gJ')<CR>
  nnoremap <silent>  J :<C-U>call <SID>try('SplitjoinJoin', 'J')<CR>
  nnoremap <silent> gS :SplitjoinSplit<CR>
  nnoremap <silent>  S :<C-U>call <SID>try('SplitjoinSplit', 'S')<CR>
  nnoremap <silent> r<CR> :<C-U>call <SID>try('SplitjoinSplit', "r\015")<CR>

endif

" }}}2
" Section: Commands {{{1
" -----------------------

if has("eval")
function! SL(function)
  if exists('*'.a:function)
    return call(a:function,[])
  else
    return ''
  endif
endfunction

command! -bar -nargs=1 -complete=file E :exe "edit ".substitute(<q-args>,'\(.*\):\(\d\+\):\=$','+\2 \1','')
command! -bar -nargs=? -bang Scratch :silent enew<bang>|set buftype=nofile bufhidden=hide noswapfile buflisted filetype=<args> modifiable
command! -bar -count=0 RFC     :e http://www.ietf.org/rfc/rfc<count>.txt|setl ro noma
function! s:scratch_maps() abort
  nnoremap <silent> <buffer> == :Scratch<CR>
  nnoremap <silent> <buffer> =" :Scratch<Bar>put<Bar>1delete _<Bar>filetype detect<CR>
  nnoremap <silent> <buffer> =* :Scratch<Bar>put *<Bar>1delete _<Bar>filetype detect<CR>
  nnoremap          <buffer> =f :Scratch<Bar>setfiletype<Space>
endfunction

function! Synname()
  if exists("*synstack")
    return map(synstack(line('.'),col('.')),'synIDattr(v:val,"name")')
  else
    return synIDattr(synID(line('.'),col('.'),1),'name')
  endif
endfunction

command! -bar Invert :let &background = (&background=="light"?"dark":"light")

function! Fancy()
  if &number
    if has("gui_running")
      let &columns=&columns-12
    endif
    windo set nonumber foldcolumn=0
    if exists("+cursorcolumn")
      set nocursorcolumn nocursorline
    endif
  else
    if has("gui_running")
      let &columns=&columns+12
    endif
    windo set number foldcolumn=4
    if exists("+cursorcolumn")
      set cursorline
    endif
  endif
endfunction
command! -bar Fancy :call Fancy()

function! OpenURL(url)
  if has("win32")
    exe "!start cmd /cstart /b ".a:url.""
  elseif $DISPLAY !~ '^\w'
    exe "silent !tpope browse \"".a:url."\""
  elseif exists(':Start')
    exe "Start tpope browse -T \"".a:url."\""
  else
    exe "!tpope browse -T \"".a:url."\""
  endif
  redraw!
endfunction
command! -nargs=1 OpenURL :call OpenURL(<q-args>)
" open URL under cursor in browser
nnoremap gb :OpenURL <cfile><CR>
nnoremap gA :OpenURL http://www.answers.com/<cword><CR>
nnoremap gG :OpenURL http://www.google.com/search?q=<cword><CR>
nnoremap gW :OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<cword><CR>

  0verbose runtime! plugin/matchit.vim
  0verbose runtime! macros/matchit.vim
endif

" Section: Mappings {{{1
" ----------------------

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

if has('digraphs')
  digraph ./ 8230
endif

nnoremap Y  y$
if exists(":nohls")
  nnoremap <silent> <C-L> :nohls<CR><C-L>
endif
inoremap <C-C> <Esc>`^

vnoremap     <M-<> <gv
vnoremap     <M->> >gv
vnoremap     <Space> I<Space><Esc>gv

inoremap <C-X>^ <C-R>=substitute(&commentstring,' \=%s\>'," -*- ".&ft." -*- vim:set ft=".&ft." ".(&et?"et":"noet")." sw=".&sw." sts=".&sts.':','')<CR>

cnoremap <C-O>      <Up>
inoremap <M-o>      <C-O>o
inoremap <M-O>      <C-O>O
inoremap <M-i>      <Left>
inoremap <M-I>      <C-O>^
inoremap <M-A>      <C-O>$
noremap! <C-J>      <Down>
noremap! <C-K><C-K> <Up>
if has("eval")
  command! -buffer -bar -range -nargs=? Slide :exe 'norm m`'|exe '<line1>,<line2>move'.((<q-args> < 0 ? <line1>-1 : <line2>)+(<q-args>=='' ? 1 : <q-args>))|exe 'norm ``'
endif

map  <F1>   <Esc>
map! <F1>   <Esc>
if has("gui_running")
  map <F2>  :Fancy<CR>
endif
nmap <silent> <F6> :if &previewwindow<Bar>pclose<Bar>elseif exists(':Gstatus')<Bar>exe 'Gstatus'<Bar>else<Bar>ls<Bar>endif<CR>
nmap <silent> <F7> :if exists(':Lcd')<Bar>exe 'Lcd'<Bar>elseif exists(':Cd')<Bar>exe 'Cd'<Bar>else<Bar>lcd %:h<Bar>endif<CR>
map <F8>    :Make<CR>
map <F9>    :Dispatch<CR>
map <F10>   :Start<CR>

noremap  <S-Insert> <MiddleMouse>
noremap! <S-Insert> <MiddleMouse>

imap <C-L>          <Plug>CapsLockToggle
imap <C-G>c         <Plug>CapsLockToggle
nmap du             <Plug>SpeedDatingNowUTC
nmap dx             <Plug>SpeedDatingNowLocal
map <Leader>v  :so ~/.vimrc<CR>

inoremap <silent> <C-G><C-T> <C-R>=repeat(complete(col('.'),map(["%Y-%m-%d %H:%M:%S","%a, %d %b %Y %H:%M:%S %z","%Y %b %d","%d-%b-%y","%a %b %d %T %Z %Y"],'strftime(v:val)')+[localtime()]),0)<CR>

" Section: Autocommands {{{1
" --------------------------

if has("autocmd")
  filetype plugin indent on

  augroup Misc " {{{2
    autocmd!

    autocmd FileType netrw nnoremap <buffer> gr :grep <C-R>=shellescape(fnamemodify(expand('%').'/'.getline('.'),':.'),1)<CR><Home><C-Right> -r<Space>
    autocmd FileType netrw call s:scratch_maps()
    autocmd FileType gitcommit if getline(1)[0] ==# '#' | call s:scratch_maps() | endif
    autocmd FocusLost   * silent! wall
    autocmd FocusGained * if !has('win32') | silent! call fugitive#reload_status() | endif
    autocmd SourcePre */macros/less.vim set laststatus=0 cmdheight=1
    if v:version >= 700 && isdirectory(expand("~/.trash"))
      autocmd BufWritePre,BufWritePost * if exists("s:backupdir") | set backupext=~ | let &backupdir = s:backupdir | unlet s:backupdir | endif
      autocmd BufWritePre ~/*
            \ let s:path = expand("~/.trash").strpart(expand("<afile>:p:~:h"),1) |
            \ if !isdirectory(s:path) | call mkdir(s:path,"p") | endif |
            \ let s:backupdir = &backupdir |
            \ let &backupdir = escape(s:path,'\,').','.&backupdir |
            \ let &backupext = strftime(".%Y%m%d%H%M%S~",getftime(expand("<afile>:p")))
    endif

    autocmd User Rails let b:dispatch = ':Rake' | let b:start = ':Rserver'
    autocmd User Fugitive
          \ if filereadable(fugitive#buffer().repo().dir('fugitive.vim')) |
          \   source `=fugitive#buffer().repo().dir('fugitive.vim')` |
          \ endif

    autocmd BufNewFile */init.d/*
          \ if filereadable("/etc/init.d/skeleton") |
          \   keepalt read /etc/init.d/skeleton |
          \   1delete_ |
          \ endif |
          \ set ft=sh

    autocmd BufReadPost * if getline(1) =~# '^#!' | let b:dispatch = getline(1)[2:-1] . ' %' | let b:start = b:dispatch | endif
    autocmd BufReadPost ~/.Xdefaults,~/.Xresources let b:dispatch = 'xrdb -load %'
    autocmd BufWritePre,FileWritePre /etc/* if &ft == "dns" |
          \ exe "normal msHmt" |
          \ exe "gl/^\\s*\\d\\+\\s*;\\s*Serial$/normal ^\<C-A>" |
          \ exe "normal g`tztg`s" |
          \ endif
    autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
      \ if !$VIMSWAP && isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
  augroup END " }}}2
  augroup FTCheck " {{{2
    autocmd!
    autocmd BufNewFile,BufRead *named.conf*       set ft=named
    autocmd BufNewFile,BufRead *.txt,README,INSTALL,NEWS,TODO if &ft == ""|set ft=text|endif
  augroup END " }}}2
  augroup FTOptions " {{{2
    autocmd!
    autocmd FileType c,cpp,cs,java          setlocal commentstring=//\ %s
    autocmd Syntax   javascript             setlocal isk+=$
    autocmd FileType xml,xsd,xslt,javascript setlocal ts=2
    autocmd FileType text,txt,mail          setlocal ai com=fb:*,fb:-,n:>
    autocmd FileType sh,zsh,csh,tcsh        inoremap <silent> <buffer> <C-X>! #!/bin/<C-R>=&ft<CR>
    autocmd FileType sh,zsh,csh,tcsh        let &l:path = substitute($PATH, ':', ',', 'g')
    autocmd FileType perl,python,ruby       inoremap <silent> <buffer> <C-X>! #!/usr/bin/env<Space><C-R>=&ft<CR>
    autocmd FileType c,cpp,cs,java,perl,javscript,php,aspperl,tex,css let b:surround_101 = "\r\n}"
    autocmd FileType apache       setlocal commentstring=#\ %s
    autocmd FileType cucumber let b:dispatch = 'cucumber %' | imap <buffer><expr> <Tab> pumvisible() ? "\<C-N>" : (CucumberComplete(1,'') >= 0 ? "\<C-X>\<C-O>" : (getline('.') =~ '\S' ? ' ' : "\<C-I>"))
    autocmd FileType git,gitcommit setlocal foldmethod=syntax foldlevel=1
    autocmd FileType gitcommit setlocal spell
    autocmd FileType gitrebase nnoremap <buffer> S :Cycle<CR>
    autocmd FileType help setlocal ai fo+=2n | silent! setlocal nospell
    autocmd FileType help nnoremap <silent><buffer> q :q<CR>
    autocmd FileType html setlocal iskeyword+=~ | let b:dispatch = ':OpenURL %'
    autocmd FileType java let b:dispatch = 'javac %'
    autocmd FileType lua  setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.lua'
    autocmd FileType perl let b:dispatch = 'perl -Wc %'
    autocmd FileType ruby setlocal tw=79 comments=:#\  isfname+=:
    autocmd FileType ruby
          \ let b:start = executable('pry') ? 'pry -r "%:p"' : 'irb -r "%:p"' |
          \ if expand('%') =~# '_test\.rb$' |
          \   let b:dispatch = 'testrb %' |
          \ elseif expand('%') =~# '_spec\.rb$' |
          \   let b:dispatch = 'rspec %' |
          \ else |
          \   let b:dispatch = 'ruby -wc %' |
          \ endif
    autocmd FileType liquid,markdown,text,txt setlocal tw=78 linebreak nolist
    autocmd FileType tex let b:dispatch = 'latex -interaction=nonstopmode %' | setlocal formatoptions+=l
    autocmd FileType vim  setlocal keywordprg=:help |
          \ if exists(':Runtime') |
          \   let b:dispatch = ':Runtime' |
          \   let b:start = ':Runtime|PP' |
          \ else |
          \   let b:dispatch = ":unlet! g:loaded_{expand('%:t:r')}|source %" |
          \ endif
    autocmd FileType timl let b:dispatch = ':w|source %' | let b:start = b:dispatch . '|TLrepl'
    autocmd FileType * if exists("+omnifunc") && &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
    autocmd FileType * if exists("+completefunc") && &completefunc == "" | setlocal completefunc=syntaxcomplete#Complete | endif
  augroup END "}}}2
endif " has("autocmd")

" }}}1
" Section: Visual {{{1
" --------------------

" Switch syntax highlighting on, when the terminal has colors
if (&t_Co > 2 || has("gui_running")) && has("syntax")
  function! s:initialize_font()
    if exists("&guifont")
      if has("mac")
        set guifont=Monaco:h12
      elseif has("unix")
        if &guifont == ""
          set guifont=bitstream\ vera\ sans\ mono\ 10
        endif
      elseif has("win32")
        set guifont=Consolas:h11,Courier\ New:h10
      endif
    endif
  endfunction

  command! -bar -nargs=0 Bigger  :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)+1','')
  command! -bar -nargs=0 Smaller :let &guifont = substitute(&guifont,'\d\+$','\=submatch(0)-1','')
  noremap <M-,>        :Smaller<CR>
  noremap <M-.>        :Bigger<CR>

  if exists("syntax_on") || exists("syntax_manual")
  else
    syntax on
  endif
  set listchars=tab:>\ ,trail:\ ,extends:>,precedes:<
  set list
  if !exists('g:colors_name')
    if filereadable(expand("~/.vim/colors/wombat256mod.vim"))
      colorscheme wombat256mod
    elseif filereadable(expand("~/.vim/colors/wombat256mod.vim"))
      colorscheme wombat256mod
    endif
  endif

  " Set Transparent Background
  hi Normal ctermfg=NONE ctermbg=NONE

  augroup RCVisual
    autocmd!

    autocmd VimEnter *  if !has("gui_running") | set background=dark notitle noicon | endif
    autocmd GUIEnter *  set background=light title icon cmdheight=2 lines=25 columns=80 guioptions-=T guioptions-=m guioptions-=e guioptions-=r guioptions-=L
    autocmd GUIEnter *  if has("diff") && &diff | set columns=165 | endif
    autocmd GUIEnter *  silent! colorscheme wombat256mod
    autocmd GUIEnter *  call s:initialize_font()
    autocmd GUIEnter *  let $GIT_EDITOR = 'false'
    autocmd Syntax sh   syn sync minlines=500
    autocmd Syntax css  syn sync minlines=50
    autocmd Syntax csh  hi link cshBckQuote Special | hi link cshExtVar PreProc | hi link cshSubst PreProc | hi link cshSetVariables Identifier
  augroup END
endif

" }}}1
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Section: Additiional Methods {{{3
" ---------------------------------
" ===========================================================================
" Custom Functions
" ===========================================================================
" Delete multiple Blank lines
fun! DelMultiBlank()
   let _s=@/
   let l = line(".")
   let c = col(".")
   :g/^\n\{2,}/d
   let @/=_s
   call cursor(l, c)
   endfun
map <special> <leader>dml :keepjumps call DelMultiBlank()<cr>

" Delete all Blank Lines
fun! DelBlank()
   let _s=@/
   let l = line(".")
   let c = col(".")
   :g/^$/d
   let @/=_s
   call cursor(l, c)
endfun
map <special> <leader>dl :keepjumps call DelBlank()<cr>

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

" Open links on Browser
function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!konqueror ".line
endfunction
map <Leader>w :call Browser ()<CR>

" ToDo list menu
function! TodoListMode()
   e ~/.todo.otl
   Calendar
   wincmd l
   set foldlevel=1
   tabnew ~/.notes.txt
   tabfirst
   " or 'norm! zMzr'
endfunction
nnoremap <silent> <Leader>todo :execute TodoListMode()<CR>


" Settings for vim-powerline
set ls=2 " Always show status line
let g:last_mode=""

" Color Scheme Settings
" You can redefine these in your .vimrc

" Black on Green
if !exists('g:NeatStatusLine_color_normal') | let g:NeatStatusLine_color_normal = 'guifg=#000000 guibg=#7dcc7d gui=NONE ctermfg=0 ctermbg=2 cterm=NONE' | endif
" White on Red
if !exists('g:NeatStatusLine_color_insert') | let g:NeatStatusLine_color_insert = 'guifg=#ffffff guibg=#ff0000 gui=bold ctermfg=15 ctermbg=9 cterm=bold' | endif
" Yellow on Blue
if !exists('g:NeatStatusLine_color_replace') | let g:NeatStatusLine_color_replace = 'guifg=#ffff00 guibg=#5b7fbb gui=bold ctermfg=190 ctermbg=67 cterm=bold' | endif
" White on Purple
if !exists('g:NeatStatusLine_color_visual') | let g:NeatStatusLine_color_visual = 'guifg=#ffffff guibg=#810085 gui=NONE ctermfg=15 ctermbg=53 cterm=NONE' | endif
" White on Black
if !exists('g:NeatStatusLine_color_position') | let g:NeatStatusLine_color_position = 'guifg=#ffffff guibg=#000000 ctermfg=15 ctermbg=0' | endif
" White on Pink
if !exists('g:NeatStatusLine_color_modified') | let g:NeatStatusLine_color_modified = 'guifg=#ffffff guibg=#ff00ff ctermfg=15 ctermbg=5' | endif
" Pink on Black
if !exists('g:NeatStatusLine_color_line') | let g:NeatStatusLine_color_line = 'guifg=#ff00ff guibg=#000000 gui=bold ctermfg=207 ctermbg=0 cterm=bold' | endif
" Black on Cyan
if !exists('g:NeatStatusLine_color_filetype') | let g:NeatStatusLine_color_filetype = 'guifg=#000000 guibg=#00ffff gui=bold ctermfg=0 ctermbg=51 cterm=bold' | endif

if !exists('g:NeatStatusLine_separator') | let g:NeatStatusLine_separator = '|' | endif

"==============================================================================
"==============================================================================

" Set up the colors for the status bar
function! SetNeatstatusColorscheme()

" Basic color presets
    exec 'hi User1 '.g:NeatStatusLine_color_normal
    exec 'hi User2 '.g:NeatStatusLine_color_replace
    exec 'hi User3 '.g:NeatStatusLine_color_insert
    exec 'hi User4 '.g:NeatStatusLine_color_visual
    exec 'hi User5 '.g:NeatStatusLine_color_position
    exec 'hi User6 '.g:NeatStatusLine_color_modified
    exec 'hi User7 '.g:NeatStatusLine_color_line
    exec 'hi User8 '.g:NeatStatusLine_color_filetype

endfunc

" pretty mode display - converts the one letter status notifiers to words
function! Mode()
    redraw
    let l:mode = mode()

    if mode ==# "n" | exec 'hi User1 '.g:NeatStatusLine_color_normal | return "NORMAL"
    elseif mode ==# "i" | exec 'hi User1 '.g:NeatStatusLine_color_insert | return "INSERT"
    elseif mode ==# "R" | exec 'hi User1 '.g:NeatStatusLine_color_replace | return "REPLACE"
    elseif mode ==# "v" | exec 'hi User1 '.g:NeatStatusLine_color_visual | return "VISUAL"
    elseif mode ==# "V" | exec 'hi User1 '.g:NeatStatusLine_color_visual | return "V-LINE"
    elseif mode ==# "" | exec 'hi User1 '.g:NeatStatusLine_color_visual | return "V-BLOCK"
    else | return l:mode
    endif
endfunc

"==============================================================================
"==============================================================================

if has('statusline')

" set up color scheme now
    call SetNeatstatusColorscheme()

" Status line detail:
" -------------------
"
" %f file name
" %F file path
" %y file type between braces (if defined)
"
" %{v:servername} server/session name (gvim only)
"
" %< collapse to the left if window is to small
"
" %( %) display contents only if not empty
"
" %1* use color preset User1 from this point on (use %0* to reset)
"
" %([%R%M]%) read-only, modified and modifiable flags between braces
"
" %{'!'[&ff=='default_file_format']}
" shows a '!' if the file format is not the platform default
"
" %{'$'[!&list]} shows a '*' if in list mode
" %{'~'[&pm=='']} shows a '~' if in patchmode
"
" %= right-align following items
"
" %{&fileencoding} displays encoding (like utf8)
" %{&fileformat} displays file format (unix, dos, etc..)
" %{&filetype} displays file type (vim, python, etc..)
"
" #%n buffer number
" %l/%L line number, total number of lines
" %p% percentage of file
" %c%V column number, absolute column number
" &modified whether or not file was modified
"
" %-5.x - syntax to add 5 chars of padding to some element x
"
    function! SetStatusLineStyle()

" Determine the name of the session or terminal
        if (strlen(v:servername)>0)
" If running a GUI vim with servername, then use that
            let g:neatstatus_session = v:servername
        elseif !has('gui_running')
" If running CLI vim say TMUX or use the terminal name.
            if (exists("$TMUX"))
                let g:neatstatus_session = 'tmux'
            else
" Giving preference to color-term because that might be more
" meaningful in graphical environments. Eg. my $TERM is
" usually screen256-color 90% of the time.
                let g:neatstatus_session = exists("$COLORTERM") ? $COLORTERM : $TERM
            endif
        else
" idk, my bff jill
            let g:neatstatus_session = '?'
        endif

        let &stl=""
" mode (changes color)
        let &stl.="%1*\ %{Mode()} %0*"
" session name
        let &stl.="%5* %{g:neatstatus_session} %0*"
" file path
        let &stl.=" %<%F "
" read only, modified, modifiable flags in brackets
        let &stl.="%([%R%M]%) "

" right-aligh everything past this point
        let &stl.="%= "

" readonly flag
        let &stl.="%(%{(&ro!=0?'(readonly)':'')} ".g:NeatStatusLine_separator." %)"

" file type (eg. python, ruby, etc..)
        let &stl.="%8*%( %{&filetype} %)%0* "
" file format (eg. unix, dos, etc..)
        let &stl.="%{&fileformat} ".g:NeatStatusLine_separator." "
" file encoding (eg. utf8, latin1, etc..)
        let &stl.="%(%{(&fenc!=''?&fenc:&enc)} ".g:NeatStatusLine_separator." %)"
" buffer number
        let &stl.="BUF #%n "
"line number (pink) / total lines
        let &stl.="%5* LN %7*%-4.l%5*/%-4.L\ %0* "
" percentage done
        let &stl.="(%-3.p%%) ".g:NeatStatusLine_separator." "
" column number (minimum width is 4)
        let &stl.="COL %-3.c "
" modified / unmodified (purple)
        let &stl.="%(%6* %{&modified ? 'modified':''} %)"

    endfunc

"FIXME: hack to fix the repeated statusline issue in console version
    if !has('gui_running')
        au InsertEnter * redraw!
        au InsertChange * redraw!
        au InsertLeave * redraw!
    endif

" whenever the color scheme changes re-apply the colors
    au ColorScheme * call SetNeatstatusColorscheme()

" Make sure the statusbar is reloaded late to pick up servername
    au ColorScheme,VimEnter * call SetStatusLineStyle()

" Switch between the normal and vim-debug modes in the status line
    nmap _ds :call SetStatusLineStyle()<CR>
    call SetStatusLineStyle()
" Window title
    if has('title')
        set titlestring="%t%(\ [%R%M]%)".expand(v:servername)
    endif
endif
"
"

" Custom Key bindings
map <Leader>p :call InsertLine()<CR>

function! InsertLine()
  let trace = expand("import pdb; pdb.set_trace()")
  execute "normal O".trace
endfunction
" END OF STATUS LINE CONFIGURATION.
