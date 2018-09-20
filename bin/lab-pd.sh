CONFIG=$HOME/wt-setup.txt
if [ ! -f $CONFIG ] ; then 
	echo "We will ask you a few questions to generate the list of commands you need to run to complete this lab"
	echo -n "First name: " ; read FIRSTNAME
	echo -n "Last name: " ; read LASTNAME
	UNIQUENAME=${FIRSTNAME}${LASTNAME}-`date +'%Y%m%d'`
	echo "Your unique name is: ${UNIQUENAME}"
	echo "UNIQUENAME=${UNIQUENAME}" >> $CONFIG
	echo -n "email (for receiving activation notifications): " read EMAIL
	echo "EMAIL=${EMAIL}" >> $CONFIG
else
	source $CONFIG
fi
echo -e "\nGenerating the list of commands..."
echo -e "\nakamai promotional-deployment new-pipeline --pipeline ${UNIQUENAME} --propertyId ${UNIQUENAME}.world-tour dev prod"
echo -e "\nakamai promotional-deployment set-default --pipeline ${UNIQUENAME}"
echo -e '\nsed -i "s#cnameFrom\": \".*\",#cnameFrom\": \"dev.${UNIQUENAME}.akamaideveloper.net\",#;s#\"cnameTo\": \".*\",#\"cnameTo\": \"world-tour.akamaideveloper.net.edgesuite.net\",#" ${UNIQUENAME}/environments/dev/hostnames.json'
echo -e '\nsed -i "s#cnameFrom\": \".*\",#cnameFrom\": \"prod.${UNIQUENAME}.akamaideveloper.net\",#;s#\"cnameTo\": \".*\",#\"cnameTo\": \"world-tour.akamaideveloper.net.edgesuite.net\",#" ${UNIQUENAME}/environments/prod/hostnames.json'
echo -e "\nakamai promotional-deployment set-default --pipeline ${UNIQUENAME}"
echo -e "\nmv ${UNIQUENAME}/environments/variableDefinitions.json ${UNIQUENAME}/environments/variableDefinitions-original.json"
echo -e "\njq \".definitions.originHostname.default = \\\"${UNIQUENAME}.origin.akamaideveloper.net\\\" | .definitions.cpCode.default = 749512\" ${UNIQUENAME}/environments/variableDefinitions-original.json > ${UNIQUENAME}/environments/variableDefinitions.json"
for MYENV in dev prod ; do
	echo -e "\nmv ${UNIQUENAME}/environments/${MYENV}/variables.json ${UNIQUENAME}/environments/${MYENV}/variables-original.json"
	echo -e "\njq \".originHostname = \\\"${MYENV}.${UNIQUENAME}.origin.akamaideveloper.net\\\" \" ${UNIQUENAME}/environments/${MYENV}/variables-original.json > ${UNIQUENAME}/environments/${MYENV}/variables.json"
done
echo -e "\nakamai promotional-deployment list-status"
echo -e "\nakamai promotional-deployment promote dev --network staging --emails $EMAIL"
echo -e "\nakamai pd check-promotion-status dev"


