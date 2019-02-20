#!/bin/bash

while getopts ":f" option; do
    case "${option}" in
        f)
            echo "No dry run!!"
            NODRYRUN=1;;
    esac
done

function create_link() {
    f=$1
    echo "Installing $f"
    target=$HOME/$f
    cp_cmd="cp $target{,.orig}"
    [[ -e $target  ]] && echo $cp_cmd && [[ ! -z $NODRYRUN ]] && ${cp_cmd}
    base=$(dirname $f)
    ln_cmd="ln -s -f `pwd`/$f $HOME/$base"
    echo ${ln_cmd} && [[ ! -z $NODRYRUN ]] && ${ln_cmd}
}

function create_link_recursive() {
    f=$1
    echo "Installing $f recursively"
    for g in `find $f -type f`; do
        create_link $g
    done
}


for f in .??*; do
    if [ -f $f ]; then
        case "$f" in
            .gitmodules)
                ;;
            *)
                create_link $f
                ;;
        esac
    elif [ -d $f ]; then
        case "$f" in
            .git)
                ;;
            *)
                create_link_recursive $f
                ;;
        esac
    fi
done
