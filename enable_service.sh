#!/bin/sh

# Start service, start service on init.
enable_service() {
    sudo systemctl start $1
    sudo systemctl enable $1
}
