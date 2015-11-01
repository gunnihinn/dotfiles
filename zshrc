if [[ -f /usr/local/etc/zshrc ]]; then
    . /usr/local/etc/zshrc
fi

# DigitalOcean droplet
#ssh-add ~/.ssh/id_curv
 
# The following lines were added by compinstall
zstyle :compinstall filename '/home/gunnar/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by gthm
PROMPT="%n@%m:%~$ "

# needed for Vim and Tmux colors to cooperate
alias tmux="tmux -2"

# Golang
export GOROOT='/usr/local/go'
export GOPATH="$HOME/devel/golang"
export PATH="$PATH:$GOROOT/bin"

# ZSH tries to interpret expand wildcards locally
alias scp='noglob scp'
alias rsync='noglob rsync'
alias rake='noglob rake'

# For backwards/forward search in tex
alias tvim='vim --servername VIM'

alias tunnel='ssh -D 9999 -C gunnar@gamma.msp.berkeley.edu'

alias shut='sudo shutdown -p now'

rcstogit () {
    if [[ $# > 0 ]]; then
        rcs-fast-export.rb "$@" | git fast-import && git reset
    else
        rcs-fast-export.rb . | git fast-import && git reset
    fi
}
