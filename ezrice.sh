#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
NEWNAME=$1.alacritty.yml
cp $SCRIPT_DIR/alacritty.yml.template $NEWNAME

#get the colors from the image
convert $1 -scale 50x50! -depth 8 +dither -colors 8 -format "%c" histogram:info: |sed -n 's/^[ ]*\(.*\):.*[#]\([0-9a-fA-F]*\) .*$/\1,#\2/p' | sort -r -n -k 1 -t "," | cut -d# -f2- > colors.txt

#replace 'normal' colors
while read LINE; do 
	sed -i "0,/@/{s/@/$LINE/}" $NEWNAME 
done <colors.txt

#replace 'bright' colors
while read LINE; do 
	sed -i "0,/@/{s/@/$LINE/}" $NEWNAME 
done <colors.txt

#replace 'foreground' color
cat colors.txt | head -n 1 | xargs -I '{}' sed -i "0,/FORE/{s/FORE/{}/}" $NEWNAME 

rm colors.txt

mv $NEWNAME $HOME/.alacritty.yml

feh --bg-scale $1
