autocmd FileType python call Python()

function! Python()
    let g:pep8_map='<leader>8'
    set foldmethod=indent
    set foldlevel=99

    nnoremap<Leader>nf :NosetestFile<CR>
    nnoremap<Leader>nc :NosetestClass<CR>
    nnoremap<Leader>nm :NosetestMethod<CR>
    nnoremap<Leader>nb :NosetestBaseMethod<CR>
    nnoremap<Leader>rr :RerunLastTests<CR>

    " Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endfunction
