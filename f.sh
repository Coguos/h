#!/bin/sh

case $1 in
    b)      cd ~/.local/bin && p="$(fzf)" && nvim "$p" && cd || exit;;
    cf)     cd ~/.config && p="$(fzf)" && nvim "$p" && cd || exit;;
    p)      cd ~/Pictures && p="$(fzf)" && sxiv "$p" && cd || exit;;
esac
