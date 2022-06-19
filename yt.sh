#!/bin/sh

if [[ "$1" != "" ]]; then
    cburl="$2"
    [[ "$cburl" = "clip" ]] && cburl="$(xclip -selection clipboard -o)"
    if [[ "$1" = "loc" ]]; then
        [[ "$3" = "clip" ]] && cburl="$(xclip -selection clipboard -o)" || cburl="$3"
        path="$2"
    fi
    case "$1" in
        loc)    st -c "ySt" -g 120x34 -e yt-dlp -P "$path" "$cburl" ;;
        *)      st -c "ySt" -g 120x34 -e yt-dlp "$1" ;;
    esac
else
    opt=$(printf "location\\nmeme\\nwl\\nflac\\nmp3\\nnaner" | dmenu -i -p "Option:")
    [[ "$opt" = "location" ]] && path="$(dmenu -p 'Download Location:')"
    [[ -z "$opt" ]] || url=$(printf "clipboard" | dmenu -i -p "URL:")
    [[ "$url" = "clipboard" ]] && url="$(xclip -selection clipboard -o)"

    case "$opt" in
        location)    st -c "ySt" -g 120x34 -e yt-dlp -P "$path" "$url";;
    esac
fi
