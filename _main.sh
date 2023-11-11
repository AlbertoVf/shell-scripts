#!/usr/bin/env bash

# style text-color
_RESET="\033[0m"
_ERROR="\033[1m \033[31m"
_SUCCESS="\033[1m \033[32m"
_WARNING="\033[1m \033[33m"
_LOG="\033[1m \033[36m"

_log() {
	echo -e "$_LOG[LOG] $1 $_RESET"
}

_success() {
	echo -e "$_SUCCESS[SUCCESS] $1 $_RESET"
}

_error() {
	echo -e "$_ERROR[ERROR] $1 $_RESET"
}

_warning() {
	echo -e "$_WARNING[WARNING] $1 $_RESET"
}
