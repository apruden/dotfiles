#!/bin/sh

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -lF'
alias la='ls -A'
alias l='ls -CF'
alias myfind='finder'
alias tymer=~/workspace/tymer/tymer

alias dblocal='mysql -uroot -p1234 -h localhost'
alias rsynconline='rsync -av --delete --exclude "*.pyc" --exclude ".pydevproject" --exclude ".project" --exclude ".hg" --exclude ".hgtags" --exclude "hgadmin*" --exclude "*~" ~/workspace/* ~/bitbucket/online/.'
alias pyclean='find -name *.pyc | xargs rm'
alias gitpullupstream='git checkout master && git pull upstream master && git push'
#alias sshtunnerl='ssh -L 10091:remotehost1:8091 -L 10092:remotehost2:8092 alex@localhost.domain'
#alias tmux='TERM=screen-256color-bce tmux'
alias vboxshared='sudo mount -t vboxsf shared ~/host'
#alias pfdev='xfreerdp --plugin cliprdr -g 1280x1024 -u Administrator 54.175.141.78'
#alias enablemagento='sshpass -p "N3Wvhm5102#3N@" ssh -oBatchMode=no root@67.213.69.212'
alias kbd_bl_on='echo 1 | sudo tee /sys/class/leds/asus::kbd_backlight/brightness'
alias enableftp='ncftp -u alex enable.workingrooms.com'
alias chrome="google-chrome-stable > /dev/null 2>&1 &"
alias shutdown="echo $HOSTPW | sudo -S shutdown -h now"
alias reboot="sudo shutdown -r now"
