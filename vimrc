""" .vimrc

""" Vim plugins
" set the runtime path to include Vundle and initialize
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins on Github 

Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'

"" Programming languages
" Python
Plugin 'python-rope/ropevim'
" Test runner: 
"   https://github.com/JarrodCTaylor/vim-python-test-runner
Plugin 'JarrodCTaylor/vim-python-test-runner'

Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Syntax checking and snippets
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'

" This allows you to select some text using Vim's visual mode and then
" hit * and # to search for it elsewhere in the file.  For example, hit
" V, select a strange sequence of characters like '$! $!', and hit star.
" You'll find all other runs of '$! $!' in the file.
"
" If you hit <leader>* ('\*' unless you changed the mapleader), vim will
" recursively vimgrep for the word under the cursor or the visual
" selection.
"
" Vim's default behavior is to just extend the visual selection to the
" next word that matches the word under the cursor. Doesn't seem very
" useful.  https://github.com/nelstrom/vim-visual-star-search
Plugin 'nelstrom/vim-visual-star-search'

" Make CTRL-A / CTRL-X work on dates like 2000-03-26
" https://github.com/tpope/vim-speeddating
Plugin 'tpope/vim-speeddating'

" NERDTree is a tree explorer plugin for vim.
" Open with <leader>n
" https://github.com/scrooloose/nerdtree
Plugin 'scrooloose/nerdtree'

" Syntax highlighting
Plugin 'tpope/vim-git'

" Surround mode; see
"   https://github.com/tpope/vim-surround
Plugin 'tpope/vim-surround'

call vundle#end()

filetype plugin on
filetype indent on

" reload .vimrc when it's changed
augroup myvimrc
    au!
    au BufWritePost .vimrc source ~/.vimrc
    au BufWritePost dotfiles/vimrc source ~/.vimrc
augroup END

" reload unchanged buffers when file changed outside vim
set autoread

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

" NerdTree
map <C-n> :NERDTreeToggle<CR>

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
source $HOME/dotfiles/vim/go.vim

function! WordCount()
  let s:old_status = v:statusmsg
  let position = getpos(".")
  exe ":silent normal g\<c-g>"
  let stat = v:statusmsg
  let s:word_count = 0
  if stat != '--No lines in buffer--'
    let s:word_count = str2nr(split(v:statusmsg)[11])
    let v:statusmsg = s:old_status
  end
  call setpos('.', position)
  return s:word_count 
endfunction

set statusline+=\ [%{WordCount()}\ words]
