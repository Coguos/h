#!/bin/sh

# add files to delete to this array
files=()

for f in ${files[@]}; do
    rm $f
done # >/dev/null 2>&1


randofiles="/tmp/randofiles"
for f in $(cat $randofiles)
do
    rm $f
    sed -ni "s:$f::g" $randofiles
done
[ "$(cat $randofiles)" = "" ] && rm $randofiles
