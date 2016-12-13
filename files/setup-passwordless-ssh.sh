#! /bin/bash


yes '' | ssh-keygen -t rsa
file=/opt/trace_ansible/files/list_of_servers.txt
IFS=' '
while read -r ip pass
do
    echo "setting up passwordless ssh for this ip,$ip"
    sshpass -p$pass ssh-copy-id -i ~/.ssh/id_rsa.pub root@$ip
    sshpass -p$pass ssh root@$ip 'chmod 0600 ~/.ssh/authorized_keys'
done<"$file"
