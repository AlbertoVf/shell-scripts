#!/usr/bin/env sh

for dir in "$HOME/.bin"/*/; do
	export PATH="$PATH:$dir"
done

for dir in "$HOME/.bin"/*/*/; do
	export PATH="$PATH:$dir"
done
