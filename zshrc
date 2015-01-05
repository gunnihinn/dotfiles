if [[ -f /usr/local/etc/zshrc ]]; then
    source /usr/local/etc/zshrc
fi
 
# The following lines were added by compinstall
zstyle :compinstall filename '/home/gunnar/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by gthm
PROMPT="%n@%m:%~$ "

# needed for Vim and Tmux colors to cooperate
alias tmux="tmux -2"

# ZSH tries to interpret expand wildcards locally
alias scp='noglob scp'
alias rsync='noglob rsync'
alias rake='noglob rake'

# For backwards/forward search in tex
alias vim='vim --servername VIM'

alias tunnel='ssh -D 9999 -C gunnar@gamma.msp.berkeley.edu'

export GOPATH=$HOME/Devel/go
export GOBIN=$HOME/Devel/go/bin
export PATH=$PATH:$HOME/Dropbox/dotfiles/.bin:$GOPATH/bin

# Run "dircolors ~/dotfiles/dir_colors" to get these codes
# See man dircolors or man dir_colors for explanations
LS_COLORS='no=0:fi=0:di=34:ln=35:or=35;47:mi=33;47:pi=36:so=32:bd=34;46:cd=34;47:ex=31:'
export LS_COLORS


rcstogit () {
    if [[ $# > 0 ]]; then
        rcs-fast-export.rb "$@" | git fast-import && git reset
    else
        rcs-fast-export.rb . | git fast-import && git reset
    fi
}

getp() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: getp agt 123456-Name [bool for nextissue]"
        exit
    fi
    if [[ $# -eq 3 ]]; then
        rsync -avz gamma:msp/$1/src/work/nextissue/$2 .
    else
        rsync -avz gamma:msp/$1/src/work/$2 .
    fi
}

if [[ -f "/usr/local/bin/virtualenvwrapper.sh" ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

putp() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: putp agt 123456-Name [bool for nextissue]"
        exit
    fi
    if [[ $# -eq 3 ]]; then
        rsync -avz $2 gamma:msp/$1/src/work/nextissue
    else
        rsync -avz $2 gamma:msp/$1/src/work
    fi
}
