#!/bin/sh

# Get your IP address from the command line
# Get your private IP and public IP.
my_ip() {
    privada="$(ip addr show | grep 'inet.*brd' | awk '{print $2}' | cut -f1 -d'/' | head -n1)"
    publica="$(curl -s ifconfig.me | awk '{print $1}')"
    echo "\"publica\": $publica\n\"privada\": $privada" | bat -l json
}
