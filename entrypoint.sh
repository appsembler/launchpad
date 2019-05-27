#!/bin/bash

PASSPHRASE=$(/usr/local/bin/passphrase.sh)
echo $PASSPHRASE
AKAMAI_SECRET=$(echo $AKAMAI_SECRET_KEY|openssl base64 -d|openssl enc -d -pbkdf2 -k $(echo $PASSPHRASE))

echo ${AKAMAI_SECRET}

# Your code here. 
 
# rm the passphrase file.
rm /usr/local/bin/passphrase.sh

exec node /home/theia/src-gen/backend/main.js /home/theia --hostname=0.0.0.0
