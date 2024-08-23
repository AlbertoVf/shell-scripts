#!/usr/bin/env bash

for dir in "$HOME/.bin"/*/; do
	export PATH="$PATH:$dir"
done
