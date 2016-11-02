#!/bin/bash
#this script automates the saparation of classes into their own files

classes_dir="classes"

if [ ! -d "$classes_dir" ] ; then 
	echo "Making output directory : classes"
	mkdir classes
fi

for class in 1 2 3 4 5 6 7 8 9 10 14 15 16
do
	cat data | grep -e "[$class]$" > classes/class$class
done
