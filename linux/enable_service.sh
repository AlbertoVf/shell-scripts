#!/usr/bin/env sh
## ? Help : Start service, start service on init.
## ? Usage:
## ?    enable_service <service>

enable_service() {
	sudo systemctl start $1
	sudo systemctl enable $1
}
