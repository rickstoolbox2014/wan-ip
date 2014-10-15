#! /bin/bash

# Copyright Ritske 2014
# License GPLv2.0

function get-current-ip() {

	QM=1

	until [ ${QM} -eq 0 ] ; do

		let CHOICE=RANDOM%4 # keep the operand of the remainder operation in sync with number of choices, this also maximizes the number of effective choices ;-P 

		echo "`date` - ${CHOICE} trying..." >> /var/log/getip.log   # for debugging only 

     	case ${CHOICE} in

        0) IP=`wget -t 1 -q -O- https://secure.informaction.com/ipecho` ;;
        1) IP=`wget -t 1 -q -O- http://icanhazip.com` ;;
		    2) IP=`wget -t 1 -q -O- http://httpbin.org/ip | head -n 2 | tail -n 1 | awk 'BEGIN{ FS=":"} { print $2}'  | awk 'BEGIN { FS="\"" } { print $2 }'` ;; 
        3) IP=`wget -t 1 -q -O- http://ifconfig.me/ip`
      esac

      QM=$?
	done
}

# script starts here

get-current-ip 

echo -n "${IP//[^0-9.]}"   # if you don't want a trailing newline
#echo "${IP}"              # just deliver what the choice produced

echo "`date` - ${CHOICE} - \"${IP}\"" >> /var/log/getip.log

# script ends here
