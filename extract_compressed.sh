#!/usr/bin/sh

# Extract a compressed file.
function extract() {
  case $file in
    *.gz) gunzip $file ;;
    *.bz2) bunzip2 $file ;;
    *.zip) unzip $file ;;
    *.tar) tar $file ;;
    *) echo not extracted ;;
  esac
}