#!/bin/sh

#start service, start service on init
function enable_service(){
	sudo systemctl start $1
	sudo systemctl enable $1
}
