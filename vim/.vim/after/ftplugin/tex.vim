" tex.vim
" aoneill - 10/07/15

" Get rid of 4 space auto indent issue
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab

" Quick way to insert task blocks
nmap T o\begin{task}{}<Enter>\end{task}<Enter><Esc>2k$i

" Quick way to insert enum blocks
nmap E o\begin{enum}<Enter>\item <Tab><Enter>\end{enum}<Esc>k$a

" Quick way to insert align* blocks
nmap A o\begin{align*}<Enter>&<Enter>\end{align*}<Esc>k$a
