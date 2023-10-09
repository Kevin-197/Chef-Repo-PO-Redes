#!/bin/bash

IPHostServerFile=$(cat  /home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration\ Files/IPS.json)
key1=$(echo "$IPHostServerFile" | grep -o '"IPHostServer": "[^"]*' | cut -d'"' -f4)

sudo scp -i /home/ubuntu/tec.pem ubuntu@$key1:/home/ubuntu/Desktop.ovpn /home/ubuntu

