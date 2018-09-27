CONFIG=$HOME/wt-setup.txt
echo "We will ask you a few questions to generate the list of commands you need to run to complete this lab"
echo -n "First name: " ; read FIRSTNAME
echo -n "Last name: " ; read LASTNAME
UNIQUENAME="`echo ${FIRSTNAME}|awk '{print tolower(substr ($0, 0, 1))}'``echo ${LASTNAME}| awk '{print tolower($1)}'`-`date +'%Y%m%d'`"
echo "Your unique name is: ${UNIQUENAME}"
echo "UNIQUENAME=${UNIQUENAME}" > $CONFIG
echo -n "email (for receiving activation notifications): " ; read EMAIL
echo "EMAIL=${EMAIL}" >> $CONFIG
