#!/bin/sh

[[ ! -d "$HOME/.config/cumlist" ]] && mkdir $HOME/.config/cumlist
p="$HOME/.config/cumlist"
date=$(date '+%y_%m_%d-%H:%M:%S')

getsel() {
    for f in $p/*
    do
        echo $f >> /tmp/cumfiles
        if [ -z "$cumz" ]; then
            cumz="$(cat -s $f)"
        else
            cumz="$cumz
$(cat -s $f)"
        fi
    done
    sel="$(echo "$cumz" | dmenu -i -l 30)"
}

case $1 in
    add)
        touch "$p/$date" && echo "$2" > "$p/$date"
        notify-send "'$2' added to list."
        ;;
    rm)
        getsel
        [ -z "$sel" ] && exit
        grep -v '^ *#' < /tmp/cumfiles | while IFS= read -r line
        do
            cat $line | grep -sx "$sel" && rm $line
        done
        rm /tmp/cumfiles
        notify-send "'$sel' removed from list."
        ;;
    *)
        getsel
        [ -z "$sel" ] && exit
        echo "$sel" | xsel -b
        notify-send "'$sel' copied to clipboard."
        ;;
esac
