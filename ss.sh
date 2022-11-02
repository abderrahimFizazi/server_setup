#!/bin/bash
if [ "$1" = "--php" -o "$1" = "-p" ]; then
    ./php.sh $2 $3
elif [ "$1" = "--mysql" -o "$1" = "-m" ]; then
    ./mysql.sh $2
elif [ "$1" = "--apache2" -o "$1" = "-a" ]; then
    yes | sudo ufw allow OpenSSH
    yes | sudo ufw enable
    sudo apt install -y apache2
    sudo apt update -y 
elif [ "$1" = "--setup" -o "$1" = "-s" ]; then
    sudo apt update -y
    sudo apt upgrade -y
    #apache2
    yes | sudo ufw allow OpenSSH
    yes | sudo ufw enable
    sudo apt install -y apache2
    sudo apt update -y 
    #mysql
    ./mysql.sh
    #php
    ./php.sh $2 $3
elif [ -z $1 ]; then
    ./php.sh
else 
    echo "Command not found!"
    echo "Type -h for help"
fi




