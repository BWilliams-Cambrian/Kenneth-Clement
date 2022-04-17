#!/bin/bash

# This script takes a .csv file as the first argument. Each line should follow
# the format "firstname,lastname,department".

# variable file contains the output of the first argument minus the first line
file=`cat $1 | tail -n +2`

# variable username contains the final username of the person to be added
username=''

# variable output contains each output of awk for manipulation
output=''

# variable first name contains each first name of the user to be added
firstname=''

# variable last name contains each last name of the user to be added
lastname=''

# variable department contains each department per user to be added
department=''

# variable that contains each username
usernames=''

# variable groups contains each new department added
groups=''

# variable contains the number of new users added
total_new_users=0 ;

# variable contains the number of new groups added
total_new_groups=0 ;

# for each line in file
for line in $file
do
	# separate the line in the file by delimiter ','
	# then store the first column in output as well as firstname
	output=`echo $line | awk -F, '{print $1}'`
	firstname=$output

	# separate the line in the file by delimiter ','
	# then store the second column in output as well as lastname
	output=`echo $line | awk -F, '{print $2}'`
	lastname=$output

	# separate the line in the file by delimiter ','
	# then store the third column in output as well as department
	output=`echo $line | awk -F, '{print $3}'`
	# trim the carriage return out of department
	department=`echo $output | tr -d '\r'`

	# store the username of the user by selecting the first character of
	# the first name followed by the first 8 characters of the last name
	username=${lastname:0:1}${firstname:0:8}

	# If usernames is empty	
	if [[ $usernames == '' ]]
	then
	#Add the first username found to variable usernames
		usernames=$username ;
		#increment the number of new users by one
		let "total_new_users+=1" ;
	elif [[ $usernames == *$username* ]]
	#else if the username is already in variable usernames
	then
	#print the username is already in
		echo "$username already created." ;
	else
	# else append the username to usernames variable
		usernames="$usernames $username" ;
		#increment the number of new users by one
		let "total_new_users+=1" ;
	fi

	#if groups is empty
	if [[ $groups == '' ]]
	then
		# append the department name to the groups variable
		groups=$department ;
		#increment the number of groups added by one
		let "total_new_groups+=1" ;
	elif [[ $groups == *$department* ]]
	#else if the department is already in the groups
	then
		#output error message
		echo "Group $department already created." ;
	else
		#else add the department to the groups variable
	 	groups="$groups $department" ;
		#increment the number of groups by one
		let "total_new_groups+=1" ;
	fi

	# print out each username followed by their department they belong to to a text file
	echo "$username $department" >> user_groups.txt
done

#echo "Usernames: $usernames" ;
#echo "Groups: $groups" ;
echo "Total new users added: $total_new_users" ;
echo "Total new groups added: $total_new_groups" ;

