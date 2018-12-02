#!/bin/bash

function create_link() {
    f=$1
    echo "Installing $f"
    target=$HOME/$f
    [[ -e $target  ]] && echo "cp $target{,.orig}"
    base=$(dirname $f)
    echo "ln -s -f -t $HOME/$base `pwd`/$f"
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
