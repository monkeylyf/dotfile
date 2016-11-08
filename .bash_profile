# Source ~/.bashrc is exists.
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# setup git env variables so the branch name will show up in bash prompt.
uname=`uname`
case $uname in
    Darwin)
        source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
        #PS1="\u | \W $(__git_ps1)$ "
        ;;
    Linux)
        source /etc/bash_completion.d/git
        ;;
    *)
        echo "Unknown platform ${uname}. Fail to set git branch env var..."
        ;;
esac


# Colors. 0; => light scene 1; => dark scene.
BLACK="\e[1:30m"
BLUE="\e[1;34m"
CYAN="\e[1;36m"
GREEN="\e[1;32m"
RED="\e[1;31m"
PURPLE="\e[1;35m"
BROWN="\e[1;33m"

COLOREND="\e[0m"

export PS1='\u | \W\[\033[1;31m\]$(__git_ps1 " (%s)")\[\033[0m\]\$ '
#export PS1="$CYAN\u$COLOREND$RED |$COLOREND $BROWN\W$COLOREND$GREEN$ $COLOREND"
#export PS1="\u | \W $(__git_ps1)$ "
export CLICOLOR=1
#export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LSCOLORS=ExFxBxDxCxegedabagacad

# Ignore history by adding heading space.
export HISTIGNORE=' *'


#
# Alias
#
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'


alias rm='my_rm_wrapper'
# git formaated log with colors.
alias gl="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs="git status"

# Backing out of the current directory
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

# clear shortcut
alias c='clear'

# Screen
alias sc="screen -S"
alias sl="screen -ls"
alias sr="screen -r"

# Functions
#
my_rm_wrapper() {
    mv $@ ~/.trash
}

extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

mcd() {
    mkdir -p "$1" && cd "$1";
}

authme() {
  ssh "$1" 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys' \
    < ~/.ssh/id_rsa.pub
}

t() {
    tail -f $1 | perl -pe "s/$2/\e[1;31;43m$&\e[0m/g"
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
