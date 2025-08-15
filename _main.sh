#!/usr/bin/env sh

_RESET="\033[0m"
_WARNING="\033[1m \033[33m"

_log() {
	_LOG="\033[1m \033[36m"
	echo -e "$_LOG[LOG] $1 $_RESET"
}

_success() {
	paplay '/usr/share/sounds/freedesktop/stereo/complete.oga'
	_SUCCESS="\033[1m \033[32m"
	[ -t 1 ] && echo -e "$_SUCCESS[SUCCESS] $1 $_RESET" || notify "Success" "$1"
}

_error() {
	paplay '/usr/share/sounds/freedesktop/stereo/dialog-error.oga'
	_ERROR="\033[1m \033[31m"
	[ -t 1 ] && echo -e "$_ERROR[ERROR] $1 $_RESET" || notify "Error" "$1"
}

_warning() {
	paplay '/usr/share/sounds/freedesktop/stereo/dialog-warning.oga'
	[ -t 1 ] && echo -e "$_WARNING[WARNING] $1 $_RESET"
}

_params_required() {
	usage=$(sed -n '3p' "$0" | cut -c 3-)
	_error "The script require $1 params\n$_WARNING$usage"
}

notify() {
	local app=$1
	local mensaje=$2
	command -v notify-send >/dev/null && notify-send "$app" "$mensaje"
	paplay '/usr/share/sounds/freedesktop/stereo/message.oga'
}
