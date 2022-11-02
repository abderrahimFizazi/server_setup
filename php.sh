#!/bin/bash

while [ True ]; do
if [ "$1" = "--install" -o "$1" = "-i" ]; then
    while [ True ]; do
    echo "Enter the specific version of php you want to install (or type Enter to install the last version): "
    read pass
    if [ -z $pass ]; then
        echo "Installing the last version"
        sudo apt-get install php -y
        sudo apt-get install -y php-fpm php-mysql php-mbstring php-xml php-bcmath php-cli php-curl php-zip unzip

        break
    elif [[ $pass =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then
        VERSION=$pass
        sudo apt install software-properties-common
        sudo add-apt-repository ppa:ondrej/php
        sudo apt-get install -y php$VERSION
        sudo apt-get install -y php$VERSION-fpm php$VERSION-mysql php$VERSION-mbstring php$VERSION-xml php$VERSION-bcmath php$VERSION-cli php$VERSION-curl php$VERSION-zip unzip
        break
    else
        echo "Invalid Version!"
    fi
    done
    shift 1
elif [ "$1" = "--uninstall" -o "$1" = "-u" ]; then
    if [ "$2" = "-a" -o "$2" = "--all" ]; then
        read -p "Are you sure you want to delete all php versions? [y/n] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            sudo apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`  && sudo apt-get autoclean && sudo apt-get autoremove
            fi
    else
        while [ True ]; do
        echo "Enter the specific version of php you want to uninstall: "
        read pass
        if [ -z $pass ]; then
            VERSION=$pass
            break
        elif  [[ $pass =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then
            VERSION=$pass
            sudo apt-get purge `dpkg -l | grep php$VERSION| awk '{print $2}' |tr "\n" " "`  && sudo apt-get autoclean && sudo apt-get autoremove
            break
        else
            echo "Invalid Version!"
            shift 1
        fi
        done
    fi
    shift 1
elif [ "$1" = "--withdeps" -o "$1" = "-w" ]; then
    dpkg -l | grep php| awk '{print $2}' 
    break
elif [ ! -z "$1" ]; then
    echo "wanna some Help? "
    echo "Type -h for help"
    break
else
    echo "Your currently intstalled php versions are:"
    ls /etc/php
    break
fi
done