#!/bin/bash

DHPARAM="/etc/nginx/certs/dhparam.pem"

# Create the dhparams if not present
if [ ! -e "$DHPARAM" ]; then
	echo "Generating Diffie Hellman Ephemeral Parameters..."
	openssl dhparam -out "$DHPARAM" 4096
fi

# Start nginx
nginx