#!/usr/bin/env sh

_RESET="\033[0m"
_WARNING="\033[1m \033[33m"

_log() {
	_LOG="\033[1m \033[36m"
	echo -e "$_LOG[LOG] $1 $_RESET"
}

_success() {
	paplay '/usr/share/sounds/freedesktop/stereo/complete.oga'
	if [ -t 1 ]; then
		_SUCCESS="\033[1m \033[32m"
		echo -e "$_SUCCESS[SUCCESS] $1 $_RESET"
	else
		notify "Success" "$1"
	fi
}

_error() {
	paplay '/usr/share/sounds/freedesktop/stereo/dialog-error.oga'
	if [ -t 1 ]; then
		_ERROR="\033[1m \033[31m"
		echo -e "$_ERROR[ERROR] $1 $_RESET"
	else
		notify "Error" "$1"
	fi
}

_warning() {
	if [ -t 1 ]; then
		echo -e "$_WARNING[WARNING] $1 $_RESET"
	fi
	paplay '/usr/share/sounds/freedesktop/stereo/dialog-warning.oga'
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
