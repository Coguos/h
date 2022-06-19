#!/bin/sh

case $1 in
    clip)   st -c "fSt" -g 120x34 -e mpv "$(xsel -o)" ;;
    *)      st -c "fSt" -g 120x34 -e mpv "$1" ;;
esac
