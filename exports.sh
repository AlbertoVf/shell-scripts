#!/usr/bin/env sh

for dir in "$HOME/.bin"/*/ "$HOME/.bin"/*/*/; do
	export PATH="$PATH:$dir"
	# echo $dir
done
