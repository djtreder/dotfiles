# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# make default 'shell' tmux
if command -v tmux>/dev/null 2>&1; then
    [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && tmux -2 && exit
fi

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s histverify # fill out history on the line to allow for verification/modification
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# get color aliases
source ~/.bash_colors

# set up prompt
set_prompt () {
    local Last_Command=$?
    # Add a bright white exit status for the last command
    PS1="\\[$White\\]\$? "
    # If it was successful, print a green check mark. Otherwise, print
    # a red X.
    if [[ $Last_Command == 0 ]]; then
        PS1+="\\[$Green\\]$Checkmark "
    else
        PS1+="\\[$Red\\]$FancyX "
    fi
    # get git prompt support
    source /usr/lib/git-core/git-sh-prompt
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="auto verbose name"
    GIT_PROMPT=$(__git_ps1 " (%s)")
    #GIT_PROMPT=$(echo $GIT_PROMPT | sed "s/origin/\\\\\\[\\$BRed\\\\\\]origin\\\\\\[\\$Color_Off\\\\\\]/")
    # set prompt
    PS1+="\[$BGreen\]\u@\h\[$Color_Off\]:\[$BBlue\]\w\[$Color_Off\]$GIT_PROMPT\$ "
}
PROMPT_COMMAND='set_prompt'

# set colors for ls
[ -x /usr/bin/dircolors ] && eval "$(dircolors -b)"

# source aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# source bash-completion
source /usr/share/bash-completion/bash_completion

#export M2_HOME=/usr/local/apache-maven/apache-maven-3.1.1
#export M2=$M2_HOME/bin
#export JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre
#export PATH="$HOME/bin:$HOME/eclipse:$HOME/.rbenv/bin:$HOME/RubyMine/bin:$HOME/IDEA/bin:$M2:$PATH"
export PATH="$HOME/.npm-global/bin:$HOME/bin:$HOME/eclipse:$HOME/.rbenv/bin:$HOME/RubyMine/bin:$HOME/IDEA/bin:$PATH"
if command -v rbenv >/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi
#set -o vi

# look into this alert command
#alias alert=`notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e 's/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//')"'

# default editor = spacemacs goodness
export EDITOR="/usr/local/bin/emacs -nw"

# set directory where all repositories will be at
export REPO_DIR="$HOME/git"

# set Go file location
export GOPATH="$HOME/gocode"

export PATH="$HOME/.captain/bin/:$HOME/.rbenv/bin:/usr/local/go/bin:$GOPATH/bin:$PATH"
eval "$(rbenv init -)"

# setup hub alias and completion
# eval "$(hub alias -s)"
# source "$GOPATH/src/github.com/github/hub/etc/hub.bash_completion.sh"

# start emacs server if needed (find better location for this)
# ps -ef | grep -v 'grep' | grep -q 'emacs --daemon' || nohup emacs --daemon >/dev/null 2>&1

# colored man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}


# quiet web's cucumber tests
export SILENCE_WRAPPED_EXCEPTIONS=true
