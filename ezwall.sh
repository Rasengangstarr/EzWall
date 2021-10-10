#!/bin/bash

CONF=$HOME/.ezwall.conf

echo "$CONF"

echo '--EZWALL--'
if test -r "$CONF"; then
	IMGDIR=$(cat $CONF | sed "1{q;d}")
else
	echo 'Please enter your wallpaper directory'
		read -p "" IMGDIR
		printf "%s" "$IMGDIR" > "$CONF"
fi

echo 'Choose a file or option'

ls $IMGDIR | nl -w1 -s'> '
echo 'r> Random'
echo 'c> Edit Config'
echo 'q> Quit'

read -p "Choose a file or option: " OPT

echo $OPT

if [ "$OPT" -eq "$OPT" ] 2>/dev/null; then
	ls $IMGDIR | sed "$OPT{q;d}" | xargs -I{} feh --bg-scale $IMGDIR/{}
elif [ $OPT = "r" ]; then
	feh --bg-scale --randomize $IMGDIR/
elif [ $OPT = "c" ]; then
	echo 'Please enter your wallpaper directory'
		read -p "" IMGDIR
		printf "%s" "$IMGDIR" > "$CONF"
fi


