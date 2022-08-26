#!/usr/bin/sh

# create a playlist with mp3 and mp4 files in folder
function create_playlist(){
  folder_name="$(pwd | awk -F '/' '{print $NF}')"
  name="playlist_$folder_name.m3u"

  echo -e "# $(date) - $(pwd)\n" > $name
  fd -a -d1 -e mp3 -e mp4 >> $name
}