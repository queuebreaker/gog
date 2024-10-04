#!/bin/bash

# starting values

function restart() {
GOGS=0
GOGSPS=1
SACRIFICE=100
ERROR=""
}

restart

# functions

function fwait() {
	GOGS=$((GOGS+GOGSPS))
}

function fsleep() {
	GOGS=$((GOGS+(GOGSPS*10)))
}

function sacrifice() {
	if [[ $GOGS -gt $((SACRIFICE-1)) ]] ; then
		GOGS=$((GOGS-SACRIFICE))
		GOGSPS=$((GOGSPS+1))
		SACRIFICE=$((GOGSPS*100))
	else
		ERROR="error: not enough gogs"
	fi
}

# main

function main() {
GOGS=$((GOGS+GOGSPS))
clear

echo "gogs: $GOGS"
echo "gogs/second: $GOGSPS"
echo ""
echo "[w] - wait for 1 second"
echo "[s] - wait for 10 seconds"
echo "[c] - sacrifice $SACRIFICE gogs for +1 gogs/second"
echo "[d] - restart"
echo -e "\n$ERROR\n"
ERROR=""

echo -n ": "
read -r -n1 -t1 INP

case $INP in
	w) fwait;;
	s) fsleep;;
	c) sacrifice;;
	d) restart;;
	q) clear && exit;;
esac
}

while true; do
	main
done