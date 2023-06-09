#!/bin/sh

# create a playlist with mp3 and mp4 files in folder.
create_playlist() {
    if [ $1 ]; then
        folder_name=$1
        root="$(pwd)/$1"
    else
        folder_name="$(pwd | awk -F '/' '{print $NF}')"
        root="$(pwd)"
    fi
    name="playlist_$folder_name.m3u"
    echo -e "#!/usr/bin/vlc\n# $(date)\n# $root\n" >$name
    fd "mp\d$" -a -d1 --base-directory $root >>$name
}
