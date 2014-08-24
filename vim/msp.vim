"" Vim settings for LaTeX work with MSP
"" Created by gthm on 22 Aug 2014

" I don't like folding in TeX files when editing
au BufRead *.tex normal zR

"" Useful functions

" Insert en-dash between words
function! Azaz()
    .,$s/\([A-Za-z0-9\$]\)-\([A-Za-z0-9]\)/\1--\2/gc
endfunction
nmap <leader>az :call Azaz()<cr>

" Negative space before suspect characters in Warwick styles
function! Warspace()
    .,$s/\([^_\^]\)\([CHJMNPXYUVf\|\\Gamma]\)\$\([,\.]\)/\1\2\\!\$\3/gc
endfunction
nmap <leader>ws :call Warspace()<cr>

" changes \\ to \cr. Use after first highlighting the area in visual mode
vmap <F2><CR> mm:s/\\\\/\\cr/g<CR>`m

" Prompt user for [Bb]ig[g]\? and insert matching par
" To use, first set cursor on the beginning delimiter to be resized
function! Bigpars()
    call inputsave()
    let rep = input('Enter delimiter size:')
    call inputrestore()
    execute ':normal i\'.rep.'l'
    :normal l%
    execute ':normal i\'.rep.'r'
    :normal l%
endfunction
nmap <leader>bp :call Bigpars()<cr>


