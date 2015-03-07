#!/bin/bash

dic1="abcdefghijklmnopqrstuvwxyz"
dic2="agcdibgymzklahoucsenrwlxft"
yescolor='\e[1;32m'
nocolor='\e[0m'

#Función para leer chars
function readChars
{
    len=$1
    var="`od -t c "${file}" --read-bytes=${len} -An --skip-bytes="${index}"| tr " " "\0" `"
    index=$(($index + $len))

}

file="$1"
index=0
length=$(wc -c $1 | cut -d" " -f1)
result=""

while (( $index <= $length ));
do

    readChars 1
    
    if ( echo -n "${var}" | grep "^[a-z]" > /dev/null ); then

        idx="$(expr index "$dic1" $var)"
        var2="$(echo $dic2 | cut -c$idx)"

        if [ "$var" == "$var2" ]; then
            echo -n "${var2}"
        else
            #echo -ne "\n!$var!\n"
            #echo -e "\n!$index\n"
            echo -ne "${yescolor}${var2}${nocolor}"
        fi
    
    else
        echo -n " "
    fi
        
done
