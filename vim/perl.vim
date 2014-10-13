"" Vim settings for Perl
"" Created by gthm on 22 Aug 2014

autocmd FileType perl call Mattdent()

"" Weirdly enough, this does what I want with Matt's Perl code
function! Mattdent()
    set foldmethod=indent
    set foldlevel=0
    let perl_fold=1 
    let perl_fold_blocks=1
    " Tidy selected lines (or entire file) with \t:
    nnoremap <silent> <LEADER>t :%!perltidy -q<Enter>
    vnoremap <silent> <LEADER>t :!perltidy -q<Enter>
    " comment/uncomment blocks of code (in vmode)
    vmap <LEADER>c :s/^/#/gi<Enter>
    vmap <LEADER>C :s/^#//gi<Enter>
endfunction
