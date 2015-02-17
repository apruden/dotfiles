# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#<<
function finder() {
find $1 -type f \( -iname $2 ! -iname "*.hg" \)
}
#>>

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]>\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}>\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#<<
alias myfind='finder'
#>>

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#<<
export PATH=/usr/local/eclipse:~/.tmuxifier/bin:~/dev/util:/usr/local/bin:$PATH

[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc

export PYTHONPATH=/home/alex/workspace/hestia/python/:/home/alex/workspace/onlineutil/python/:/home/alex/workspace/pandora/python/:/home/alex/workspace/janus/python/:/home/alex/workspace/hermes/python/:/home/alex/workspace/iris/python/:/home/alex/workspace/seshat/python/:/home/alex/workspace/mercury/python/:/home/alex/workspace/osiris/python/:/home/alex/workspace/chronos/python/:/home/alex/workspace/demeter/python/:/home/alex/workspace/postopia/python/:/home/alex/workspace/fortuna/python/:/home/alex/workspace/olympus/python/:/home/alex/workspace/ploutos/python/:/home/alex/workspace/shiva/python/:$PYTHONPATH

export PYTHONSTARTUP=$HOME/.pythonstartup
export DEBFULLNAME='Alex Prudencio (gameloft)'
export DEBEMAIL='alex.prudencio-arispe@gameloft.com'

alias alpha01='ssh alex.prudencio-arisp@alpha01.mdc.gameloft.org'
alias alpha01-squeeze='ssh alex.prudencio-arisp@alpha01-squeeze.mdc.gameloft.org'
alias alpha02='ssh alex.prudencio-arisp@alpha02.mdc.gameloft.org'
alias ihub='ssh alex.prudencio-arisp@ihub.mdc.gameloft.org'
alias ihubeur='ssh alex.prudencio-arisp@ihub.eur.mdc.gameloft.org'
alias ihub02='ssh alex.prudencio-arisp@ihub02.mdc.gameloft.org'
alias dblocal='mysql -uroot -padmin -h localhost'
alias rsynconline='rsync -av --delete --exclude "*.pyc" --exclude ".pydevproject" --exclude ".project" --exclude ".hg" --exclude ".hgtags" --exclude "hgadmin*" --exclude "*~" ~/workspace/* ~/bitbucket/online/.'
alias pyclean='find -name *.pyc | xargs rm'
alias cbcadjanus='ssh -L 10091:cad-janus-cbg001.mdc.gameloft.org:8091 -L 10092:cad-janus-cbg001.mdc.gameloft.org:8092 alex.prudencio-arisp@ihub.mdc.gameloft.org'
alias cbcadseshatprofile='ssh -L 10091:cad-seshatprofile-cbg001.mdc.gameloft.org:8091 -L 10092:cad-seshatprofile-cbg001.mdc.gameloft.org:8092 alex.prudencio-arisp@ihub.mdc.gameloft.org'
alias cbbobjanus='ssh -L 10091:bob-janus-cbg.mdc.gameloft.org:8091 -L 10092:bob-janus-cbg.mdc.gameloft.org:8092 alex.prudencio-arisp@ihub.mdc.gameloft.org'
alias tmux='TERM=screen-256color-bce tmux'
alias vboxshared='sudo mount -t vboxsf shared ~/host'
#if [ -f /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh ]; then
#	source /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
#fi

#>>
