"" Vim settings for Perl
"" Created by gthm on 22 Aug 2014

autocmd FileType perl call Mattdent()

"" Weirdly enough, this does what I want with Matt's Perl code
function! Mattdent()
    set foldmethod=indent
    set foldlevel=0
    let perl_fold=1 
    let perl_fold_blocks=1
endfunction
