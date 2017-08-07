" java.vim
" aoneill - 08/11/16

" Highlighting, and toggle functionality
highlight OverLength ctermbg=red ctermfg=white
match OverLength /\%101v.\+/
let w:long_match = 1

" Toggle highlighting
function! LongLineMatchToggle()
  if exists('w:long_match')
    unlet w:long_match
    match OverLength //
  else
    let w:long_match = 1
    match OverLength /\%101v.\+/
  endif
  echo ""
endfunction
