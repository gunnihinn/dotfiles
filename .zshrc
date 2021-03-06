autoload colors && colors
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval $COLOR='%{$fg_no_bold[${(L)COLOR}]%}'  #wrap colours between %{ %} to avoid weird gaps in autocomplete
    eval BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
eval RESET='%{$reset_color%}'

PROMPT="%B%(?..[%?] )%b${GREEN}%n${RESET}@%U${YELLOW}%m${RESET}%u> "

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST="$HISTSIZE"

# man zshoptions
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt NO_CHECK_JOBS
setopt NO_HUP

bindkey -e

alias grep='grep --color=auto'
alias config='/etc/profiles/per-user/$(whoami)/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias clip='xclip -selection clipboard'
alias e='emacsclient -c'
alias ls='ls --color=auto -F --group-directories-first'
alias ll='ls -al'
alias second_monitor='xrandr --output eDP-1 --below HDMI-1'

LS_COLORS='no=0:fi=0:di=34:ln=35:or=35;47:mi=33;47:pi=36:so=32:bd=34;46:cd=34;47:ex=31:'
export LS_COLORS

# Fix SSH environment variables when re-attaching to existing session
# http://stackoverflow.com/a/34683596/1569492
function fixssh() {
    eval $(tmux show-env -s | /bin/grep '^SSH')
}

# ls everything we cd into
function cd() {
    builtin cd "$@"
    ls
}

function nix-use() {
    nix-shell --packages "$@" --run zsh
}

function nix-find() {
    nix-env -qaP ".*$@."
}

# The following lines were added by compinstall
zstyle :compinstall filename '/home/gmagnusson/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

type direnv > /dev/null && eval "$(direnv hook zsh)"
