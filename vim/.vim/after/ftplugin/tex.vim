" tex.vim
" aoneill - 10/07/15

" Get rid of 4 space auto indent issue
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab

" Quick way to insert enumerate blocks
nmap E o\begin{enumerate}<Enter>\item<Enter>\end{enumerate}<Esc>k$a 
