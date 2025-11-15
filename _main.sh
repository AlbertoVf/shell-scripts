#!/usr/bin/env sh

save_log(){
	local level="$1"; shift
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $*" >> "$HOME/.logs/$(basename "$0").log"
}

emit_message() {
	local sound="$1";shift
	local status="$1"; shift
	local message="$1"
	[ -t 1 ] && echo -e "$status $message \033[0m"
	notify-send "$message"
	paplay "/usr/share/sounds/freedesktop/stereo/$sound.oga"
}

_log() {
	_DEBUG="\033[1m\033[30m [*] $(date +'%H:%M:%S') »"
	emit_message 'message' "$_DEBUG" "$1"
	save_log "DEBUG" "$1"
}

_success() {
	_INFO="\033[1m\033[32m [+] $(date +'%H:%M:%S') »"
	emit_message 'complete' "$_INFO" "$1"
	save_log "INFO" "$1"
}

_error() {
	_ERROR="\033[1m\033[31m [-] $(date +'%H:%M:%S') »"
	emit_message 'dialog-error' "$_ERROR" "$1"
	save_log "ERROR" "$1"
}

_warning() {
	_WARNING="\033[1m\033[33m [!] $(date +'%H:%M:%S') »"
	emit_message 'dialog-warning' "$_WARNING" "$1"
	save_log "ALERT" "$1"
}

_params_required() {
	usage=$(sed -n '3p' "$0" | cut -c 3-)
	_error "The script require $1 params\n$usage"
}
