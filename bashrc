# .bashrc

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# prompt
PS1='\u@\h:\W\$ '

# alias (aliai?)
alias ls='ls --color=auto -h --group-directories-first'
alias lsd='ls -d */'
alias grep='grep --color=auto -n'
alias shut='sudo shutdown -h now'
# > /dev/null 2>&1'
alias sc='screen'
# For backwards/forward search in tex
alias vim='vim --servername VIM'
alias svim='vim --servername M'
alias soff='xset -dpms; xset s off'
alias tunnel='ssh -D 9999 -C gunnar@gamma.msp.berkeley.edu'

# variable declarations
export PATH="$PATH:/usr/local/bin:/usr/local/texlive/2014/bin/x86_64-linux:/home/gunnar/Dropbox/dotfiles/.bin:/home/gunnar/Dropbox/msp/scripts:/usr/bin/site_perl"
export MANPATH="$MANPATH:/usr/local/texlive/2012/texmf/doc/man"
export INFOPATH="$INFOPATH:/usr/local/texlive/2012/texmf/doc/info"
export EDITOR="vim"

# Run "dircolors dir_colors" to get these codes
# See man dircolors or man dir_colors for explanations
LS_COLORS='no=0:fi=0:di=34:ln=35:or=35;47:mi=33;47:pi=36:so=32:bd=34;46:cd=34;47:ex=31:'
export LS_COLORS

# Add commands to history after completion
shopt -s histappend
PROMPT_COMMAND="history -a"

# Ignore duplicates, ls, bg, bf and exit in bash history
export HISTIGNORE="&:ls:[bf]g:exit"

rcstogit () {
    if [[ $# > 0 ]]; then
        rcs-fast-export.rb "$@" | git fast-import && git reset
    else
        rcs-fast-export.rb . | git fast-import && git reset
    fi
}

textopdf () {
	j=`echo $1 | sed 's/.tex//'`
	latex $j.tex; dvips $j.dvi; ps2epsi $j.ps; epstopdf $j.epsi
}

mg () {
    grep "\\\\$1[^A-Za-z]" main.tex
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

if [[ -f "/usr/local/bin/virtualenvwrapper.sh" ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi
