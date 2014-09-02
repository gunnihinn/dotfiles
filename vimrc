""" .vimrc

execute pathogen#infect()
filetype plugin on
filetype indent on

"" Possibly interferes with pathogen
"set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

" reload .vimrc when it's changed
augroup myvimrc
    au!
    au BufWritePost .vimrc source ~/.vimrc
augroup END


"" General options

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

set nocompatible        " use Vim defaults
syntax enable           " syntax highlighting
set background=dark
colorscheme solarized

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


"" Shortcut keys

" Preserve formatting of text pasted into Vim
set pastetoggle=<F2>
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
