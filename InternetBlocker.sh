#!/bin/bash

counter=0

# read every line in user_groups.txt into variable y
while read y
do
	group=`echo "$y" | awk '{print $2}'`
	if [[ $group == "IT" ]];
	then
		# add rules to user
		user=`echo $y | awk '{print $1}'`
		echo "$user"
		sudo iptables -A OUTPUT -p tcp --dport 443 -m owner --uid-owner "$user" -j ACCEPT
		let "counter+=1"
	fi

done < user_groups.txt

sudo iptables -A OUTPUT -p tcp --dport 443 -d 192.168.2.3 -j ACCEPT
sudo iptables -t filter -A OUTPUT -p tcp --dport 80 -j DROP
sudo iptables -t filter -A OUTPUT -p tcp --dport 443 -j DROP
echo "$counter users have been granted internet."
