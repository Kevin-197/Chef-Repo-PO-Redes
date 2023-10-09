#!/bin/bash

IPHostServer=$(cat  /home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration\ Files/IPS.json)
key1=$(echo "$json_data" | grep -o '"IPHostServer": "[^"]*' | cut -d'"' -f4)

sudo scp -i /home/ubuntu/tec.pem ubuntu@$IPHostServer:/home/ubuntu/Desktop.ovpn .