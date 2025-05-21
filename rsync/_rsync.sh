#!/usr/bin/env sh

. "$HOME/.bin/_main.sh"

local_folder="$(xdg-user-dir PUBLICSHARE)"
logfile="$local_folder/cloud.log"

overwrite_cloud(){
	local=$1
	cloud=$2
	_log "Copy local content to Cloud"
	rclone sync $local_folder/$local $cloud:/ --progress

	echo "$(date +'%Y-%m-%d %H.%M.%S'): Overwrite cloud $cloud" >> "$logfile"
}

overwrite_local(){
	cloud=$1
	local=$2
	_log "Copy Cloud content to local"
	rclone sync $cloud:/ $local_folder/$local --progress
	echo "$(date +'%Y-%m-%d %H.%M.%S'): Overwrite $local local" >> $logfile

}

add_new_content(){
	cloud=$1
	folder=$2
	_log "Upload content"
	rclone copy $folder $cloud:/$folder --progress
	echo "$(date +'%Y-%m-%d %H.%M.%S'): Upload content $folder to $cloud" >> $logfile
}

download_content(){
	cloud=$1
	folder=$2
	_log "Download content"
	rclone copy $cloud:/$folder $folder --progress
	echo "$(date +'%Y-%m-%d %H.%M.%S'): Download content from $cloud to $folder" >> $logfile
}
