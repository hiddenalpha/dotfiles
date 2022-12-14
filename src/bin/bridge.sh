#!/bin/bash

# To share wlan to the devices connected over ethernet, do the following:

PARENT_IFACE=wlan0
PARENT_GW_IP=192.168.1.1
SUBNET_IFACE=eth0
SUBNET_IP=169.254.0.0
SUBNET_CIDR=16
GATEWAY_IP=169.254.1.1
THIS_CLIENT_IP=169.254.91.101

if [ "$1" == "server" ] ; then
	# Bridge Server
	# =============
	# 
	# Enable ip forwarding (This commandy simply forwards all interfaces. You may
	# want forwarding on specific interfaces).
	#
	sudo sh -c 'echo 1 > /proc/sys/net/ipv4/conf/all/forwarding'
	#
	# Assign a static IP address on the bridge for the network where to provide the
	# service.
	# 
	sudo ifconfig $SUBNET_IFACE $GATEWAY_IP/$SUBNET_CIDR
	# 
	# Make iptables do NAT for incoming requests.
	# 
	sudo iptables -t nat -A POSTROUTING -o $PARENT_IFACE -j MASQUERADE
	sudo iptables -I FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
	sudo iptables -I FORWARD -i $SUBNET_IFACE -o $PARENT_IFACE -j ACCEPT
	# 
	# Redirect DNS requests
	# 
	sudo iptables -I FORWARD -p udp --dport 67 -i $SUBNET_IFACE -j ACCEPT
	sudo iptables -I FORWARD -p udp --dport 53 -s $SUBNET_IP/$SUBNET_CIDR -j ACCEPT
	sudo iptables -I FORWARD -p tcp --dport 53 -s $SUBNET_IP/$SUBNET_CIDR -j ACCEPT
	#
elif [ "$1" == "client" ] ; then
	# Client
	# =======
	# 
	# Make sure each client has its own ip in the range from 169.254.1.2 to
	# 169.254.255.254 with a netmask of 16 bits.
	#
	sudo ifconfig $SUBNET_IFACE $THIS_CLIENT_IP/$SUBNET_CIDR
	#
	# Setup the bridge server as the default gateway.
	#
	sudo route add default gw $GATEWAY_IP
	#
	# Add nameserver
	#
	sudo sh -c 'echo nameserver '$PARENT_GW_IP' > /etc/resolv.conf'
	#
	# Now you should be able to connect to the internet on the client through your bridge.
else
	echo "Usage:" `basename $0` " <server|client>"
fi

