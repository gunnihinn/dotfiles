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

# Add commands to history after completion
shopt -s histappend
PROMPT_COMMAND="history -a"

# Ignore duplicates, ls, bg, bf and exit in bash history
export HISTIGNORE="&:ls:[bf]g:exit"

textopdf () {
	j=`echo $1 | sed 's/.tex//'`
	latex $j.tex; dvips $j.dvi; ps2epsi $j.ps; epstopdf $j.epsi
}

mg () {
    grep "\\\\$1[^A-Za-z]" main.tex
}

warclone () {
    if [ $# -ne 2 ] && [ $# -ne 3 ]; then
        echo "Usage: warclone 123456-Name (a)gt (branch)"
        return 1
    fi
    year="2014"
    if [ "$2" == "agt" ]; then
        vol=14
    elif [ "$2" == "gt" ]; then
        vol=18
    else
        echo "Second argument must be agt or gt"   
        return 2
    fi
    branch=""
    if [ $# -eq 3 ]; then
        branch=" -b $3"
    fi

    git clone$branch gunnar@barquentine.msp.warwick.ac.uk:/local/journals/$2/$vol-$year/src/$1
} 

source /usr/local/bin/virtualenvwrapper.sh
