#!/bin/sh

printHelp() {
    echo "usage:  autogcc <file> <run_option>
    run_opt options: -run, -norun
setting options in the file:
    '//cmd [custom compile command to run]'
    '//flags [gcc compile flags]'
    '//exedir [gcc compile flags]' store the binary in a custom executable directory (~/.local/bin/programs/compiled)
put any of these in line 1 of the file

'autogcc -h' to print this text."
}

[[ "$1" == "-h" ]] && printHelp ; exit

file="$1"
run_opt="$2"
if (cat $file | awk NR==1 | grep -q //*cmd); then
    cmd="$(cat $file | awk NR==1 | sed 's/\/\///;s/cmd //')"
    exeFile="$(echo $cmd | sed 's/.*-o //g')"
    $cmd
elif (cat $file | awk NR==1 | grep -q //*flags); then
    exeFile=${file%%.*}
    flags="$(cat $file | awk NR==1 | sed 's/\/\///;s/flags //')"
    gcc -g $file $flags -o $exeFile
elif (cat $file | awk NR==1 | grep -q //*exedir); then
    exeFile="$HOME/.local/bin/programs/compiled/${file%%.*}"
    flags="$(cat $file | awk NR==1 | sed 's/\/\///;s/exedir//')"
    gcc -g $file $flags -o $exeFile
    [[ "$run_opt" == "-run" ]] && time $exeFile
    exit
else
    exeFile=${file%%.*}
    gcc -g $file -o $exeFile
fi

[[ "$run_opt" == "-run" ]] && time ./$exeFile
