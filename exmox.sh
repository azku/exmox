#!/bin/bash


USAGE="script usage: $(basename \$0) -f [filename]"
OUTPUT="The script, if succesful, creates a password_given.txt file with the passwords gicen to the created users."
while getopts ':f:' flag;do
    case $flag in
        f) USERFILE=$OPTARG ;;
    esac
done

if [ "$USERFILE" = "" ]; then                
    echo $USAGE
    echo $OUTPUT
    exit 1
fi

cat /dev/null > password_given.txt
while read user;
do
    echo "Creating user $user"
    ./pass_change.sh -u $user -o password_given.txt
done <$USERFILE
