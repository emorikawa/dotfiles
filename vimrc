" shell shortcuts in command mode
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" space bar searching
map <space> /

"move between buffers
map <c-h> <c-w>h
map <c-l> <c-w>l

map 0 ^

"FIXME Why don't these two work :(
noremap <C-S> :%s/
noremap <C-Q> <esc>:bd<CR>:vsp<CR>:bn<CR>:buffers<CR>

noremap <C-j> 3<C-e>
noremap <c-e> :! python %<CR>
noremap <C-k> 3<C-y>
noremap <S-j> 3j
noremap <S-k> 3k
noremap <S-l> 5l
noremap <S-h> 5h
noremap <PageUp> <c-u>
noremap <PageDown> <c-d>
noremap <Home> 0
noremap <End> $
noremap j gj
noremap k gk
inoremap jk <Esc>
inoremap kj <Esc>
cnoremap jk <Esc>
cnoremap kj <Esc>
inoremap df <Esc>:w<CR>
inoremap fd <Esc>:w<CR>
noremap df :w<CR>
noremap fd :w<CR>

noremap <c-n> :NERDTreeToggle<CR>

map <c-x> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans <'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"" For coffeescript stuff
call pathogen#runtime_append_all_bundles()

"" General behavior things
set history=1000

" Set to auto read when a file is changed from the outside
set autoread

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

set nocompatible "Does not use old vi quirks
set lbr "Wordwrapping doesn't break words in the middle
set autoindent "Enable automatic alignment during insertions
set smartindent "Tries to recognize code and indent
set wrap "wrap lines
set smarttab
set expandtab "Replaces tabs with spaces
set tabstop=2 "Num characters when tab is pushed
set shiftwidth=2 "sets indent size
set showmatch "Shows matches on search
set guioptions-=T "Removes GUI bars
set vb t_vb= "disables visual bell
set ruler "Shows the ruler
set cmdheight=2 "The commandbar height
set ignorecase "case insensitive search but see next option
set smartcase "Will switch to case sensitive if a cap is used
set incsearch "Incremental search
set hlsearch
set magic "set magic on, for regular expressions
set mat=2 "two-tenths of a second blink
set noerrorbells
set novisualbell
set nu "Turn on line numbers
set restorescreen

set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

""""" Colors and stuff
set term=ansi
syntax enable
set t_Co=256 "Enable colored terminal
let &t_Co=256
set encoding=utf8
colorscheme evan2
"colorscheme twilight256

"" Visual mode
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

filetype plugin on
filetype indent on


" Python stuff
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako
au BufNewFile,BufRead *.less set ft=less

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def

"set t_ti=^[7^[[?47h
"set t_te=^[[2J^[[?47l^[8
""
"if &term =~ "xterm"
"  " SecureCRT versions prior to 6.1.x do not support 4-digit DECSET
"  let &t_ti = "\<Esc>[?1049h"
"  let &t_te = "\<Esc>[?1049l"
"  " Use 2-digit DECSET instead
"  let &t_ti = "\<Esc>[?47h"
"  let &t_te = "\<Esc>[?47l"
"endif 

" restore screen after quitting
"set t_ti=ESC7ESC[rESC[?47h t_te=ESC[?47lESC8
"if has("terminfo")
"  let &t_Sf="\ESC[3%p1%dm"
"  let &t_Sb="\ESC[4%p1%dm"
"else
"  let &t_Sf="\ESC[3%dm"
"  let &t_Sb="\ESC[4%dm"
"endif
"set t_ti=^[[?1049h
"set t_te=^[[?1049l

let &t_Sf="\<Esc>[3%dm"
let &t_Sb="\<Esc>[4%dm"
let &t_te="\<Esc>[?47l"
let &t_ti="\<Esc>[?47h"
