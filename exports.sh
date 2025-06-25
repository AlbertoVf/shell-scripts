#!/usr/bin/env sh

for dir in $HOME/.bin/*/ $HOME/.bin/*/*/; do
  [ -d "$dir" ] && export PATH="$PATH:$dir"
done
