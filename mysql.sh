#!/bin/bash
if [ "$1" = "--user_list" -o "$1" = "-ul" ]; then
    sudo mysql -e "SELECT user FROM mysql.user";
elif [ "$1" = "--databases_list" -o "$1" = "-dl" ]; then
    sudo mysql -e "SHOW DATABASES;"
elif [ "$1" = "--migrate_database" -o "$1" = "-md" ]; then
    echo "Please type the database path: "
    read PATH
    sudo  mysql -h -u$USER   -p$PASS $DB < $PATH 
else
    sudo apt install -y mysql-server
    echo -n "Type database name: ";
    read DB;
    echo -n "Type username name: ";
    read USER;
    echo -n "Type password: ";
    read -s PASS;
    echo;
    echo "Database created succesfully!"
    {
        sudo mysql -uroot -prootpassword -e "CREATE DATABASE $DB CHARACTER SET utf8 COLLATE utf8_general_ci";
        sudo mysql -uroot -prootpassword -e "CREATE USER $USER@'localhost' IDENTIFIED BY '$PASS'";
        sudo mysql -uroot -prootpassword -e "GRANT SELECT, INSERT, UPDATE ON $DB.* TO '$USER'@'localhost'";
        read -p "Want to migrate your old database? [y/n] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "Please specifie the database path: "
            read PATH
            sudo  mysql -h -u$USER   -p$PASS $DB < $PATH
        fi
    } &> /dev/null
fi