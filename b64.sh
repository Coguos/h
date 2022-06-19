#!/bin/sh

option=$(printf "encode\\ndecode" | dmenu -i -p "Translation Option:")
string=$(printf "clipboard" | dmenu -i -p "String:")
[[ "$string" != "clipboard" ]] && echo "$string" > /tmp/base64.txt || xclip -o > /tmp/base64.txt

case "$option" in
    encode) result=$(base64 -w 0 /tmp/base64.txt);;
    decode) result=$(base64 -d /tmp/base64.txt);;
esac

echo "$result" > /tmp/base64.txt
xclip -sel c /tmp/base64.txt
rm /tmp/base64.txt
