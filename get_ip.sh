#!/bin/sh

# Get your IP address from the command line
# Get your private IP and public IP.
function my_ip(){
	local_ip="$(ip route get 1.1.1.1 | grep -oP 'src \K[^ ]+')"
	external_ip="$(curl -s https://api.my-ip.io/ip)"
	echo -e "Local: $local_ip\nExternal: $external_ip"
}
