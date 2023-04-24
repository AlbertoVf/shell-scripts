#!/bin/sh

# Extract a compressed file.
extract() {
    case $file in
    *.7z) 7z x $file ;;
    *.gz) gunzip $file ;;
    *.bz2) bunzip2 $file ;;
    *.zip) unzip $file ;;
    *.tar) tar $file ;;
    *) echo "no era un archivo comprimido" ;;
    esac
}
