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
alias office_monitor='xrandr --output VGA-0 --mode 1680x1050'
alias bigscreen='xrandr --output HDMI-0 --mode 1680x1050'
alias shut='sudo shutdown -h now'

# Wifi
alias wifi-office='sudo wpa_supplicant -B -i wlp6s0 -c /etc/wpa_supplicant/mexico_enamora.conf && sudo dhcpcd wlp6s0'
alias wifi-phone='sudo wpa_supplicant -B -i wlp6s0 -c /etc/wpa_supplicant/phone.conf && sudo dhcpcd wlp6s0'
alias wifi-temp='sudo wpa_supplicant -B -i wlp6s0 -c /etc/wpa_supplicant/temp.conf && sudo dhcpcd wlp6s0'

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

if [[ -f "/usr/local/bin/virtualenvwrapper.sh" ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

#
# setup ssh-agent
#

if ! pgrep ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval $(<~/.ssh-agent-thing)
fi
for privkey in $HOME/.ssh/*_rsa; do
    ssh-add $privkey 2>/tmp/ssh-agent.err
    if [[ "$?" -ne 0 ]]; then
        # Colors defined in /usr/local/etc/zshrc
        echo "${RED}ssh-add error${RESET}: $(cat /tmp/ssh-agent.err)"
    fi
done
