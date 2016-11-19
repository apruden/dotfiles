# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#<<
function finder() {
find $1 -type f \( -iname $2 ! -iname "*.hg" \)
}

function gitdelbranch() {
git branch -D $1
git push origin -u :$1
}

#>>

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
#HISTCONTROL=ignoredups:ignorespace
HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

R_HISTSIZE=10000

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
alias tymer=~/workspace/tymer/tymer
#>>

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#<<
export DEBFULLNAME='Alex Prudencio (gameloft)'
export DEBEMAIL='alex.prudencio-arispe@gameloft.com'
export M2_HOME=/usr/local/maven
export M2=$M2_HOME/bin
export PATH=$M2:$PATH
export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export GOPATH=$HOME/workspace_go

export SCALA_HOME=/usr/local/scala

export CONSCRIPT_HOME="$HOME/.conscript"
export CONSCRIPT_OPTS="-XX:MaxPermSize=512M -Dfile.encoding=UTF-8"

export ANDROID_HOME=/usr/local/share/android/sdk

export ANT_HOME=/usr/local/ant

export PATH=/usr/local/jruby/bin:/usr/local/eclipse:~/.tmuxifier/bin:~/dev/util:/usr/local/bin:/usr/local/go/bin:$ANT_HOME/bin:$SCALA_HOME/bin:$CONSCRIPT_HOME/bin:/usr/local/sbt/bin:/usr/local/android-studio/bin:$ANDROID_HOME/tools:/usr/local/activator/bin:$PATH

[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc

#export PYTHONSTARTUP=$HOME/.pythonstartup
#export PYTHONPATH=/home/alex/projects/opal/opal-python-client/target/opal-python/bin:/home/alex/projects/mica-server/mica-python-client/src/main/python:$PYTHONPATH
export EDITOR=vim

alias dblocal='mysql -uroot -p1234 -h localhost'
alias rsynconline='rsync -av --delete --exclude "*.pyc" --exclude ".pydevproject" --exclude ".project" --exclude ".hg" --exclude ".hgtags" --exclude "hgadmin*" --exclude "*~" ~/workspace/* ~/bitbucket/online/.'
alias pyclean='find -name *.pyc | xargs rm'
alias gitpullupstream='git checkout master && git pull upstream master && git push'

#alias sshtunnerl='ssh -L 10091:remotehost1:8091 -L 10092:remotehost2:8092 alex@localhost.domain'

alias tmux='TERM=screen-256color-bce tmux'
alias vboxshared='sudo mount -t vboxsf shared ~/host'
#if [ -f /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh ]; then
#	source /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
#fi

alias enablejupiter='xfreerdp --plugin cliprdr -g 1280x1024 -d enableinc.local -u alex sws.meetatrecess.com'
alias enabledev='xfreerdp --plugin cliprdr -g 1280x1024 -d enableinc.local -u alex wrtrunk.esundev.com'
alias enablezeus='xfreerdp --plugin cliprdr -g 1280x1024 -u administrator 104.193.50.35'
alias pfdev='xfreerdp --plugin cliprdr -g 1280x1024 -u Administrator 54.175.141.78'
alias enablemagento='sshpass -p "N3Wvhm5102#3N@" ssh -oBatchMode=no root@67.213.69.212'

alias kbd_bl_on='echo 1 | sudo tee /sys/class/leds/asus::kbd_backlight/brightness'
alias enableftp='ncftp -u alex enable.workingrooms.com'
#>>

export PATH="$HOME/.composer/vendor/bin:$PATH"

if which tmux >/dev/null 2>&1; then
    test -z ${TMUX} && tmux

    while test -z ${TMUX}; do
        tmux attach || break
    done
fi

source /home/alex/.bash_local

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/alex/.sdkman"
[[ -s "/home/alex/.sdkman/bin/sdkman-init.sh" ]] && source "/home/alex/.sdkman/bin/sdkman-init.sh"
