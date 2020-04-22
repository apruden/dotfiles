#!/bin/bash

TARGET_DIR=$HOME

while getopts ":f:d:" option; do
    case "${option}" in
        f)
            echo "No dry run!!"
            NODRYRUN=1;;
        d)
            TARGET_DIR=${OPTARG}
    esac
done

function create_link() {
    f=$1
    echo "Installing $f"
    target=$TARGET_DIR/$f
    backup_cmd="cp $target{,.orig}"
    [[ -e $target  ]] && echo $backup_cmd && [[ ! -z $NODRYRUN ]] && ${backup_cmd}
    base=$(dirname $f)
    ln_cmd="mkdir -p $TARGET_DIR/$base && ln -s -f `pwd`/$f $TARGET_DIR/$base"
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
