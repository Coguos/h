#!/bin/sh

file="$1"
option="$2"

if [[ "$option" == "" ]] || [[ "$option" == "-run" ]]; then
    if (cat $file | awk NR==1 | grep -q //*flags); then
        flags="$(cat $file | awk NR==1 | sed 's/\/\///;s/flags //')"
        (cat $file | awk NR==2 | grep -q //*args) && args="$(cat $file | awk NR==2 | sed 's/\/\///;s/args //')"
    elif (cat $file | awk NR==1 | grep -q //*args); then
        args="$(cat $file | awk NR==1 | sed 's/\/\///;s/args //')"
        (cat $file | awk NR==2 | grep -q //*flags) && flags="$(cat $file | awk NR==2 | sed 's/\/\///;s/flags //')"
    fi
    tcc -g -bench -run $flags $file $args
elif [[ "$option" == "-comp" ]] || [[ "$option" == "-comprun" ]]; then
    if (cat $file | awk NR==1 | grep -q //*flags); then
        exeFile=${file%%.*}
        flags="$(cat $file | awk NR==1 | sed 's/\/\///;s/flags //')"
        tcc $flags -o $exeFile $file
    elif (cat $file | awk NR==1 | grep -q //*exedir); then
        exeFile="$HOME/.local/bin/programs/compiled/${file%%.*}"
        flags="$(cat $file | awk NR==1 | sed 's/\/\///;s/exedir//')"
        tcc -g $flags -o $exeFile $file
    else
        exeFile=${file%%.*}
        tcc -g -o $exeFile $file
    fi
    [[ "$option" == "-comprun" ]] && time $exeFile
fi
