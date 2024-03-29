" .vimrc
" aoneill - 12/05/15

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set ff=unix

"" Backspace
set backspace=indent,eol,start

"" Indentation
set expandtab   " Make sure that every file uses artisan, hand-crafted spaces
set shiftround  " Round indent to multiple of 'shiftwidth'
set smartindent " Do smart indenting when starting a new line
set autoindent  " Copy indent from current line, over to the new line
set textwidth=0 " Ignore text wrapping

" Set the tab width
let s:tabwidth=2
exec 'set tabstop='    .s:tabwidth
exec 'set shiftwidth=' .s:tabwidth
exec 'set softtabstop='.s:tabwidth

" Ignore Python bs
let g:python_recommended_style=0

"" Line numbering
set nu
set ruler

"" Search options
set incsearch
set hlsearch
set showmatch

"" Set scroll context
set scrolloff=5

"" Set mouse functionality
"set mouse=a

"" Increase copy buffer
set viminfo='20,<1000,s1000

"" Return to the last position in the file
if !exists('nojump') && has("autocmd")
  au BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$")
          \ | exe "normal! g'\"zz"
        \ | endif
endif

" Spelling
set spell
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi SpellCap cterm=underline

"" Undo behavior
set undofile " Maintain undo history between sessions
set undodir=~/.cache/vim/undodir


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
  let l:filename = l:comment_parts[0] . expand('%:t') . l:comment_parts[1]
  let l:author = 'aoneill'
  let l:date = strftime('%m/%d/%y')
  let l:author_date = l:comment_parts[0] . l:author . ' - ' . l:date
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

"" Shortcuts
map <F2> :set nu!<CR>

"" Function Calls
map <F3> :call LongLineMatchToggle()<CR>
nmap <F4> :call InsertUpdateHeader()<CR>

" Tab and Shift-Tab for code
nnoremap <S-Tab> <<
nnoremap <Tab> >>

" Disable Ex Mode
nnoremap Q <NOP>

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
inoremap <F2> <NOP>
inoremap <F3> <NOP>
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

"" Command mapping
" Save files with sudo
" command W w !sudo tee > /dev/null %

" "" Autocmds
" " Do various things for C files
" augroup ctemplates
"   autocmd BufNewFile *.c :read ~/.vim/templates/c.tpl
"   autocmd BufNewFile *.c :exe "%s/{{FILE}}/" . expand("%:t") . "/g"
"   autocmd BufNewFile *.c :exe "%s/{{HEADER}}/" . expand("%:t:r") . ".h/g"
"   autocmd BufNewFile *.c :normal gg"_ddGG
" augroup END
"
" " Do various things for x86 Assembly files
" augroup ctemplates
"   autocmd BufNewFile *.S :read ~/.vim/templates/S.tpl
"   autocmd BufNewFile *.S :exe "%s/{{FILE}}/" . expand("%:t") . "/g"
"   autocmd BufNewFile *.S :normal gg"_ddGG
" augroup END
"
" " Do various things for C header files
" augroup htemplates
"   autocmd BufNewFile *.h :read ~/.vim/templates/h.tpl
"   autocmd BufNewFile *.h :exe "%s/{{FILE}}/" . expand("%:t") . "/g"
"   autocmd BufNewFile *.h :exe "%s/{{DEF}}/" .
"         \ toupper(
"         \   substitute(
"         \     substitute(
"         \       expand("%:h") . "/", "^[./]*", "", ""
"         \     ), "/", "_", "g"
"         \   ) . expand("%:t:r")
"         \ ) . "/g"
"   autocmd BufNewFile *.h :normal gg"_dd
"   autocmd BufNewFile *.h :11
" augroup END

" Strip white space on write
autocmd BufWritePre * :%s/\s\+$//e

" Syntax
syntax on

" Include filetype-specific settings
filetype plugin on
