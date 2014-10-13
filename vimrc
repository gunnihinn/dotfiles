""" .vimrc

execute pathogen#infect()
filetype plugin on
filetype indent on

" reload .vimrc when it's changed
augroup myvimrc
    au!
    au BufWritePost .vimrc source ~/.vimrc
augroup END

" git commit messages are spellchecked and wrapped at 72 lines
autocmd Filetype gitcommit setlocal spell textwidth=72

"" Statusline
set laststatus=2
set statusline=%F%m%r%h%w\ 
set statusline+=%{fugitive#statusline()}\    
set statusline+=[%{strlen(&fenc)?&fenc:&enc}]
set statusline+=\ [line\ %l\/%L]          

"" General options

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

set nocompatible        " use Vim defaults
syntax enable           " syntax highlighting
set background=light
colorscheme solarized

" For gnome-terminal
set t_Co=16

if has("gui_running")
    set guifont=Inconsolata\-g\ 16
    set background=light
    set lines=36
endif

set showmode
set showcmd

set tabstop=4           " Tabs are 4 characters
set shiftwidth=4        " (Auto)indent uses 4 characters
set softtabstop=4
set expandtab           " Use spaces, not tabs

set linebreak
set tw=72               " lines are this many chars
set scrolloff=3

set hlsearch            " highlight searchterms
set incsearch           " jump to matches while typing
set showmatch           " show matching braces

set autowrite           " write before hiding a buffer
set confirm

set history=50
set undolevels=1000

" easier moving of code blocks
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

"" Shortcut keys

" Preserve formatting of text pasted into Vim
set pastetoggle=<F2>
set clipboard=unnamed

" clear search by backspace
nnoremap <BS> :noh<return>
" enable spell check
map <F4> :setlocal spell! spelllang=en_us<cr>
" search from here to end
map \se :.,$s/
" search all
map \sa :%s/

" for Vim and screen integration
map OH <Home>
map OF <End>
imap OH <Home>
imap OF <End>


"" Options specific to files or languages
source $HOME/dotfiles/vim/latex.vim
source $HOME/dotfiles/vim/perl.vim
source $HOME/dotfiles/vim/msp.vim
source $HOME/dotfiles/vim/python.vim
