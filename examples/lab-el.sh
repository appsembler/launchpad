CONFIG=$HOME/wt-setup.txt
if [ ! -f $CONFIG ] ; then 
	echo "We will ask you a few questions to generate the list of commands you need to run to complete this lab"
	echo -n "First name: " ; read FIRSTNAME
	echo -n "Last name: " ; read LASTNAME
	UNIQUENAME=${FIRSTNAME}${LASTNAME}-`date +'%Y%m%d'`
	echo "Your unique name is: ${UNIQUENAME}"
	echo "UNIQUENAME=${UNIQUENAME}" >> $CONFIG
	echo -n "email (for receiving activation notifications): " ; read EMAIL
	echo "EMAIL=${EMAIL}" >> $CONFIG
else
	source $CONFIG
fi
echo -e "\nGenerating the list of commands..."
for NAME in robots.json Mobile_App.json show_city_depending_on_location.json Image_Manager.json ; do
	echo -e "\ncp ~/examples/${NAME} ${UNIQUENAME}/templates/"
	echo -e "\nmv ${UNIQUENAME}/templates/main.json ${UNIQUENAME}/templates/main-original.json"
	echo -e "\njq \".rules.children +=  [\\\"#include:${NAME}\\\"]\" ${UNIQUENAME}/templates/main-original.json | jq > ${UNIQUENAME}/templates/main.json"
done
echo -e "\nakamai promotional-deployment promote dev --network staging --emails $EMAIL"


