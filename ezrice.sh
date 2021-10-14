#!/bin/bash

convert docs/images/wallpapers/vectorjap.jpg -scale 50x50! -depth 8 +dither -colors 8 -format "%c" histogram:info: |sed -n 's/^[ ]*\(.*\):.*[#]\([0-9a-fA-F]*\) .*$/\1,#\2/p' | sort -r -n -k 1 -t ","

