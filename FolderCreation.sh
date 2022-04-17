#!/bin/bash

# directory referenced as the base for all other directories
folder='./EmployeeData'
# stores number of directories created
num_created=0


# if statements check if the folders already exist and creates the specific directory if they do not exist
# if directory exists
if [[ -d $folder ]]
then
	# print file exists
	echo "File EmployeeData exists"
else
	# else make the direcotry and increment the number counting the total created
	mkdir ./EmployeeData
	let "num_created++"
fi

if [[ -d $folder/HR ]]
then
	echo "File HR exists"
else
	mkdir $folder/HR
	let "num_created++"
fi

if [[ -d $folder/Finance ]]
then
	echo "File Finance exists"
else
	mkdir $folder/Finance
	let "num_created++"
fi

if [[ -d $folder/Executive ]]
then
	echo "File Executive exists"
else
	mkdir $folder/Executive
	let "num_created++"
fi

if [[ -d $folder/Administrative ]]
then
	echo "File Administrative exists"
else
	mkdir $folder/Administrative
	let "num_created++"
fi

if [[ -d $folder/'Call Center' ]]
then
	echo "File 'Call Center' exists"
else
	mkdir $folder/'Call Center'
	let "num_created++"
fi

if [[ -d $folder/IT ]]
then
	echo "File IT exists"
else
	mkdir $folder/IT
	let "num_created++"
fi

# change the permissions on the directories recursively
chmod -R 760 $folder/HR
chmod -R 764 $folder/IT
chmod -R 764 $folder/Finance
chmod -R 760 $folder/Executive
chmod -R 764 $folder/Administrative
chmod -R 764 $folder/'Call Center'

# print out the number of directories created
echo "$num_created directories created."
