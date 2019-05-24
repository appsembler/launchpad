#!/bin/bash

KEYFILE = /opt/secret.txt
SECRET_KEY = cat ${KEYFILE}

echo ${SECRET_KEY}

# Your s3 code here. 

# rm the contents of the volume 
rm ${KEYFILE}

exec node /home/theia/src-gen/backend/main.js /home/theia --hostname=0.0.0.0
