"" Vim settings for LaTeX
"" Created by gthm on 22 Aug 2014

let g:tex_flavor='latex'

" I don't remember why I put this here. Presumably for vim-latex?
command! -complete=custom,ListE -nargs=1 -range E normal <line1>ggO\begin{<args>}<Esc><line2>ggjo\end{<args>}<Esc><line1>ggv<line2>ggjj=
command! -complete=custom,ListE -nargs=1 Ei execute "normal \<Esc>i\\begin{<args>}\<CR>\\end{<args>}<Esc>O<Space>" | startinsert
function! ListE(A,L,P)
      return "align*\nalign\nequation\nequation*\nenumerate\nitemize\nfigure\ntabular\nbmatrix\npmatrix\ncases\tncases\n\ndocument\narray\nproof"
endfunction

" Ignore warnings, but then you have to check the .log file yourself
let g:Tex_IgnoredWarnings =
            \'Underfull'."\n".
            \'Overfull'."\n".
            \'specifier changed to'."\n".
            \'You have requested'."\n".
            \'Missing number, treated as zero.'."\n".
            \'There were undefined references'."\n".
            \'Latex Warning:'."\n".
            \'LaTeX Font Warning:'."\n".
            \'Citation %.%# undefined'
let g:Tex_IgnoreLevel = 9

"" Compile and PDF viewer rules
let g:Tex_ViewRule_pdf = 'okular --unique > /dev/null 2>&1'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex --interaction=nonstopmode --synctex=1 -file-line-error-style $*'

" For Okular-Vim forward search
function! SyncTexForward()
    let s:syncfile = fnamemodify(fnameescape(Tex_GetMainFileName()), ":p:r").".pdf"
    let execstr = "silent !okular --unique ".s:syncfile."\\#src:".line(".").expand("%\:p").' &'
    exec execstr
    redraw!
endfunction
nmap <Leader>lf :call SyncTexForward()<CR>


