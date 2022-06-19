#!/bin/sh

if [[ "$1" != "" ]]; then
    [[ "$2" = "clip" ]] && cburl="$(xclip -selection clipboard -o)" || cburl="$2"
    case "$1" in
        search) librewolf --search "$2";;
        open) librewolf --browser;;
        nt|new-tab) librewolf --new-tab "$cburl";;
        nw|new-win) librewolf --new-window "$cburl";;
        pw|private-win) librewolf --private-window "$cburl";;
    esac
else
    opt=$(printf "search\\nopen\\nnew tab\\nnew window\\nprivate window" | dmenu -i -p "Option:")
    [[ $opt = "search" ]] && term="$(dmenu -i -p 'Search for:')" ||
        [[ -z "$opt" ]] || url=$(printf "clipboard" | dmenu -i -p "URL:") &&
        [[ "$url" = "clipboard" ]] && url="$(xclip -selection clipboard -o)"

    case "$opt" in
        search) librewolf --search "$term";;
        open) librewolf --browser;;
        "new tab") librewolf --new-tab "$url";;
        "new window") librewolf --new-window "$url";;
        "private window") librewolf --private-window "$url";;
    esac
fi
