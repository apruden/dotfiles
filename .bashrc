# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function afind() {
  find $1 -type f \( -iname $2 ! -iname "*.hg" \)
}

function netdiag() {
  ip link show
  systemctl status netctl
  systemctl status dhcpcd
}

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
#HISTCONTROL=ignoredups:ignorespace
HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

if [ ${BASH_VERSINFO[0]} -ge 4  ]; then
    HISTSIZE=-1
    HISTFILESIZE=-1
else
    HISTSIZE=10000
    HISTFILESIZE=10000
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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


if command -v tmux>/dev/null; then
  [[ ! $TERM =~ linux ]] && [ -z $TMUX ] && exec tmux
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]>\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
    PS1='\[\033[00;33m\][\W]\$\[\033[00m\] '
else
    PS1='[\W]\$ '
    #PS1='${debian_chroot:+($debian_chroot)}>\W\$ '
fi

unset color_prompt force_color_prompt

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export EDITOR=vim
export TERMINAL=termite
export DEBFULLNAME='Alex Prudencio'
export DEBEMAIL='alex.prudencio@gmail.com'
export JAVA_HOME=/usr/lib/jvm/default
export GOPATH=$HOME/workspace_go
export SCALA_HOME=/usr/local/scala
export ANDROID_HOME=/opt/android-sdk

set -o vi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/alex/google-cloud-sdk/path.bash.inc' ]; then source '/home/alex/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/alex/google-cloud-sdk/completion.bash.inc' ]; then source '/home/alex/google-cloud-sdk/completion.bash.inc'; fi


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/alex/.sdkman"
[[ -s "/home/alex/.sdkman/bin/sdkman-init.sh" ]] && source "/home/alex/.sdkman/bin/sdkman-init.sh"

[[ -s "/usr/share/nvm/init-nvm.sh" ]] && source /usr/share/nvm/init-nvm.sh

