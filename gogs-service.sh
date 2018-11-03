#!/bin/sh
# /home/fw2/service/gogs-service.sh
function d_start()
{
	echo "Gogs: starting service"
	/home/fw2/go/src/github.com/gogs/gogs/gogs web &
	sleep 1
	sudo -A iptables -A PREROUTING -t nat -i enp2s0 -p tcp --dport 80 -j REDIRECT --to-port 3000
}

function d_stop()
{
	echo "Gogs: stopping service"
	killall gogs
}

function d_status()
{
	ps -ef | grep gogs | grep -v grep
}

# Management instructions of the service
case "$1" in
	start)
		d_start
		;;
	stop)
		d_stop
		;;
	reload)
		d_stop
		sleep 1
		d_start
		;;
	status) d_status
		;;
	*)
		echo "Usage: $ 0 {start | stop | reload | status}"
		exit 1
		;;
esac
exit 0
