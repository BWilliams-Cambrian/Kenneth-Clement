
#!/bin/bash

# grabs the information from ps in a specific order and places the data in a text file
output=`ps -eo user,pid,ppid,start,cmd,%mem,%cpu --sort=-%cpu | head -n 6`
echo "$output" > ps_output.txt

echo "These are the 5 most cpu hungry processes. Terminate them? [y/n]"
echo ""

# loop through the 5 processes found
for i in 2 3 4 5 6
do
	# variables p and con are used to be able to loop through specific line numbers
	p="p"
	con="$i$p"
	sed -n "$con" ps_output.txt
done

# get input as to whether or not to terminate the 5 processes
read terminate

numKilled=0
# if input is y then terminate otherwise don't do anything
if [ $terminate = 'y' ]
then
	for i in 2 3 4 5 6
	do
		echo "Terminating..."
#		separate=`sed -n "2p" ps_output.txt`
#		echo "$separate"
		# grabs specific line numbers and stores relevant sections
		user=`awk -v x=$i 'NR >= x && NR <= x {print $1}' ps_output.txt`
		startedAt=`awk -v x=$i 'NR >= x && NR <= x {print $4}' ps_output.txt`
		killed=`awk -v x=$i 'NR >= x && NR <= x {print $2}' ps_output.txt`
		#echo "$user"
		#if the user is not root then kill and log it
		if [ $user != 'root' ]
		then
			echo "Kill $user"
			#make a record of the killed process
			thedate=`date`
			echo "Who: $user  Started: $startedAt  killed on $thedate" >> "ProcessUsageReport - $thedate"
			kill -9 $killed
			let "numKilled+=1"
		else
			#if the user is root, do nothing
			echo "is root, not killing"
		fi
	done
	echo "The number of proceeses killed was: $numKilled"

else
	echo "Not terminating."
fi



