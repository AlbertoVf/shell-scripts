#!/usr/bin/env bash

# style text-color
_RESET="\033[0m"
_ERROR="\033[1m \033[31m"
_SUCCESS="\033[1m \033[32m"
_WARNING="\033[1m \033[33m"
_LOG="\033[1m \033[36m"

video_regex='^https?:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(\/\S*)?$'
playlist_regex='^(https?:\/\/)?(www\.)?(youtube\.com\/|youtu\.be\/)(playlist\?|list=)([^#\&\?\n]+)'

_log() {
	echo -e "$_LOG[LOG] $1 $_RESET"
}

_success() {
	echo -e "$_SUCCESS[SUCCESS] $1 $_RESET"
	paplay '/usr/share/sounds/freedesktop/stereo/complete.oga'
}

_error() {
	echo -e "$_ERROR[ERROR] $1 $_RESET"
	paplay '/usr/share/sounds/freedesktop/stereo/dialog-error.oga'
}

_warning() {
	echo -e "$_WARNING[WARNING] $1 $_RESET"
	paplay '/usr/share/sounds/freedesktop/stereo/dialog-warning.oga'
}

_params_required() {
	usage=$(sed -n '3p' "$0" | cut -c 5-)
	_error "The script require $1 params\n\t $_WARNING$usage"
}

notify() {
	local app=$1
	local mensaje=$2
	command -v notify-send >/dev/null && notify-send "$app" "$mensaje"
	paplay '/usr/share/sounds/freedesktop/stereo/message.oga'
}
