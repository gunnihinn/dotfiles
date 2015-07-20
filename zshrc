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
alias soff='xset s off'
alias bigscreen='xrandr --output VGA-0 --mode 1680x1050'
#alias bigscreen='xrandr --output HDMI-0 --mode 1680x1050'

# Wifi
alias office='sudo wpa_supplicant -B -i wlp6s0 -c /etc/wpa_supplicant/mexico_enamora.conf && sudo dhcpcd wlp6s0'
alias nando='sudo wpa_supplicant -B -i wlp6s0 -c /etc/wpa_supplicant/nando.conf && sudo dhcpcd wlp6s0'
alias sanpancho='sudo wpa_supplicant -B -i wlp6s0 -c /etc/wpa_supplicant/sanpancho.conf && sudo dhcpcd wlp6s0'

# For backwards/forward search in tex
alias vim='vim --servername VIM'

alias tunnel='ssh -D 9999 -C gunnar@gamma.msp.berkeley.edu'

export GOPATH="$HOME/devel/go"
export GOBIN="$HOME/devel/go/bin"
export GOROOT="$HOME/downloads/go"
export PATH="$PATH:$GOPATH/bin:$HOME/work/bin:$HOME/bin:$HOME/.gem/ruby/2.2.0/bin"
export MSPBINROOT="$HOME/work/devel/prodkit"

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
