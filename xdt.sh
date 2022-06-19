#!/bin/sh

# bloated shit file, do not use

if [ "$1" == "key" ]; then
    nskey() { (grep "+" /tmp/xdtkey >/dev/null 2>&1) || (grep "<*>" /tmp/xdtkey >/dev/null 2>&1) && sed -i 's/<//;s/>//g' /tmp/xdtkey || sed -i 's/./& /g' /tmp/xdtkey; }
    case $2 in
        rep) keys=$(nskey "$4") && xdotool key --repeat $3 $key;;
        repd) echo "$5" > /tmp/xdtkey && nskey && xdotool key --repeat $3 --repeat-delay $4 $(cat /tmp/xdtkey);;
        sleepbf) echo "$4" > /tmp/xdtkey && nskey && sleep "$3" && xdotool key $(cat /tmp/xdtkey);;
        loop)
            echo $! > /tmp/xdtkeyloop
            while [ -f /tmp/xdtkeyloop ]; do
                echo "$3" > /tmp/xdtkey && nskey && xdotool key $(cat /tmp/xdtkey)
                [ -z "$4" ] || sleep "$4"
            done
            ;;
        *) echo "$2" > /tmp/xdtkey && nskey && xdotool key $(cat /tmp/xdtkey);;
    esac
elif [ "$1" == "click" ]; then
    case $2 in
        rep) xdotool click --repeat $3 $(if [ -z "$4" ]; then echo 1; else echo $4; fi);;
        repd) xdotool click --repeat $3 --delay $4 $(if [ -z "$5" ]; then echo 1; else echo $5; fi);;
        mloc) xdt mousemove $(cat /tmp/xdtmloc) click;;
        mkmloc) xdt mouseloc setmloc && xdt click loopmloc $3;;
        loop)
            echo $! > /tmp/xdtclickloop
            while [ -f /tmp/xdtclickloop ]; do
                xdt click
            done
            ;;
        loopmloc)
            MLOC="$(cat /tmp/xdtmloc)"
            while [ -f /tmp/xdtmloc ]; do

                [ -z "$3" ] || sleep $3
                xdt mousemove mloc
                xdotool click $(if [ -z "$4" ]; then echo 1; else echo $4; fi)
            done
            ;;
        *) xdotool click $(if [ -z "$3" ]; then echo 1; else echo $3; fi);;
    esac
elif [ "$1" == "mouseloc" ]; then
    case $2 in
        fullstats) xdotool getmouselocation | sed 's/x://;s/y://;s/screen://;s/window://g';;
        x) xdotool getmouselocation | awk '{print $1}' | sed 's/x://g';;
        y) xdotool getmouselocation | awk '{print $2}' | sed 's/y://g';;
        xy) xdotool getmouselocation | sed 's/x://;s/y://;s/screen.*//g';;
        setmloc) printf "$(xdotool getmouselocation | sed 's/x://;s/y://;s/screen.*//g')" > /tmp/xdtmloc;;
    esac
elif [ "$1" == "mousemove" ]; then
    case $2 in
        mloc) xdotool mousemove $(cat /tmp/xdtmloc)
    esac
elif [ "$1" == "kill" ]; then
        for fileName in /tmp/xdt*
        do
        rm $fileName
        done
else
    exit
fi
