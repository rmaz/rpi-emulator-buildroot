#!/bin/sh

if [ "$ACTION" == "add" ] && [ "$INTERFACE" == "eth0" ]; then
	/sbin/ifup eth0
fi


