#!/bin/bash

#Настройка перехвата ctrl+c
trap "echo -e '\n[!] The clean manager stopped by user.'; exit 1" GIGINT

greeting="This is a CLEAR manager \n"
echo -e $greeting

#Commands
root_clean="sudo nix-collect-garbage -d"
clean="nix-collect-garbage -d"

for ((i=0; i < 10; i++))
do
    echo "Do you want to clean system (yes or no) ?":
    read ANSWER
    if [[ $ANSWER = "yes" ]]
    then 
        $clean 
        $root_clean

        echo "Cleaned done"
        break
    elif [[ $ANSWER = "no" ]]
    then
        echo "Why do you used this command?" 
        break
    else
        echo -e "\nplease right yes or no"
    fi
done


exit 0

#$root_clean
#$clean
