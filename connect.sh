#!/bin/bash 
if [[ `uname` == 'Darwin' ]]; then
    
    cat $1 2>/dev/null | (while read -r dns_name 2> /dev/null; do
        echo bash \-c \"ssh $dns_name\" > ~/tmp/._$dns_name.command; chmod +x ~/tmp/._$dns_name.command; open ~/tmp/._$dns_name.command && sleep 1; rm ~/tmp/._$dns_name.command; 2> /dev/null
        done)

    if [ $? != 0 ]; then
        cat $1 2>/dev/null | awk '{ print $1,$2,$3 }' | (while read -r ip_c user_c pass_c 2> /dev/null; do
        echo bash \-c \"sshpass \-p $pass_c ssh $user_c@$ip_c\" > ~/tmp/._$ip_c.command; chmod +x ~/tmp/._$ip_c.command; open ~/tmp/._$ip_c.command && sleep 1; rm ~/tmp/._$ip_c.command; 2> /dev/null
	done)
    fi

elif [[ `uname` == 'Linux' ]]; then
        cat $1 | openssl aes-256-cbc -d -a | awk '{ print $1,$3 }' | while read -r ip pass; do
        gnome-terminal --geometry=58x18 -e "sshpass -p $pass ssh root@$ip"&
        done
            if [ $? != 0 ]; then
                cat $1 | while read -r ip; do
                gnome-terminal --geometry=58x18 -e "sshpass -p $pass ssh root@$ip"&
                done
            fi
fi
