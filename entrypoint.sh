#! /bin/bash

cat /etc/akamai_creds.txt

node /home/theia/src-gen/backend/main.js /home/theia --hostname=0.0.0.0
