#!/bin/sh

case $1 in
    used) used=$(du -sh) && used=${used%.*} && echo $used;;
    files) ls -a | wc -l;;
    filesR) ls -Ra | wc -l;;
esac
