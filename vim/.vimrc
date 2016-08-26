" .vimrc
" aoneill - 12/05/15

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Vundle Configuration
set nocompatible
filetype off

" Init Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim'

call vundle#end()
filetype plugin indent on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Indenttaion
set autoindent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set textwidth=0

"" Line numbering
set nu

"" Search options
set incsearch
set hlsearch

"" Set scroll context
set so=5

"" Set mouse functionality
"set mouse=a

"" Return to the last position in the file
if !exists('nojump') && has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"zz" | endif
endif

" Spelling
set spell

"" Functions
" Highlighting, and toggle functionality
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%81v.\+/
let w:long_match = 1

" Toggle highlighting
function LongLineMatchToggle()
  if exists('w:long_match')
    unlet w:long_match
    match OverLength //
  else
    let w:long_match = 1
    match OverLength /\%81v.\+/
  endif
  echo ""
endfunction

" Adding header comment for source code
function InsertUpdateHeader()
  " Setup comment string
  let l:comment_parts = split(&commentstring, '%s', 1)
  if l:comment_parts[1] != ''
    let l:comment_parts[1] = ' ' . l:comment_parts[1]
  endif

  " Get needed parts
  let l:filename = l:comment_parts[0] . ' ' . expand('%:t') . l:comment_parts[1]
  let l:author = 'aoneill'
  let l:date = strftime('%m/%d/%y')
  let l:author_date = l:comment_parts[0] . ' ' . l:author . ' - ' . l:date
  let l:author_date .= l:comment_parts[1]
  let l:author_date_regex = l:author . ' - \d\+/\d\+/\d\+'
  let l:exec_line_regex = '^#!.*'

  " Handle hashbangs at top of file
  let l:root_line = 1
  let l:exec_match = matchstr(getline(l:root_line), l:exec_line_regex)
  if strlen(l:exec_match) > 0
    let l:root_line += 1
  endif

  " Delete header if it matches
  let l:match = matchstr(getline(l:root_line + 1), l:author_date_regex)
  if strlen(l:match) > 0
    if getline(l:root_line + 2) == ''
      execute "normal! mt"
      silent execute "normal! " . l:root_line . "gg3dd"
      try
        execute "normal! `t"
      endtry
    endif
  endif
  
  " Plae new header, clear call from commandline
  call append(l:root_line - 1, [l:filename, l:author_date, ''])
  echo ""
endfunction

"" Command mappings
command W w
command Q q
command Wq wq
command WQ wq

"" Shortcuts
map <F2> :set nu!<CR>

"" Function Calls
map <F3> :call LongLineMatchToggle()<CR>
nmap <F4> :call InsertUpdateHeader()<CR>

"" Extra Normal Mode functionality
nmap D dd
nmap X @x
" Ignore Ex mode
noremap Q <NOP>

" Reverse J
nmap S i<Enter><Esc>k$

" Split line at 80, move to next line
nmap O 81<Bar>BhSj$

" Tab and Shift-Tab for code
nnoremap <S-Tab> <<
nnoremap <Tab> >>

"" Extra Insert Mode functionality
" Tab and Shift-Tab for code
inoremap <S-Tab> <C-d>
inoremap <Tab> <C-t>

" Learn, damnit!
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Ignore Function Key presses in insert mode
inoremap <F1> <NOP>
inoremap <F4> <NOP>
inoremap <F5> <NOP>
inoremap <F6> <NOP>
inoremap <F7> <NOP>
inoremap <F8> <NOP>
inoremap <F9> <NOP>
inoremap <F10> <NOP>
inoremap <F11> <NOP>
inoremap <F12> <NOP>
inoremap <F13> <NOP>
inoremap <F14> <NOP>
inoremap <F15> <NOP>

"" Extra Visual Mode functionality
" Tab and Shift-Tab for code
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv

" Syntax
syntax on

" Include filetype-specific settings
filetype plugin on
