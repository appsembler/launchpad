CONFIG=$HOME/wt-setup.txt
if [ ! -f $CONFIG ] ; then 
	~/examples/wt-setup.sh
	source $CONFIG
else
	source $CONFIG
fi
echo -e "\nGenerating the list of commands..."
echo -e "\nakamai promotional-deployment new-pipeline --pipeline ${UNIQUENAME} --propertyId ${UNIQUENAME} dev prod"
echo -e "\nakamai promotional-deployment set-default --pipeline ${UNIQUENAME}"

echo -e "\nmv ${UNIQUENAME}/environments/dev/hostnames.json ${UNIQUENAME}/environments/dev/hostnames-original.json"
echo -e "\njq \".[].cnameFrom = \\\"dev.${UNIQUENAME}.world-tour.akamaideveloper.net\\\" | .[].cnameTo = \\\"world-tour.akamaideveloper.net.edgesuite.net\\\" | .[].edgeHostnameId = 3190586\" ${UNIQUENAME}/environments/dev/hostnames-original.json > ${UNIQUENAME}/environments/dev/hostnames.json"
echo -e "\nmv ${UNIQUENAME}/environments/prod/hostnames.json ${UNIQUENAME}/environments/prod/hostnames-original.json"
echo -e "\njq \".[].cnameFrom = \\\"${UNIQUENAME}.world-tour.akamaideveloper.net\\\" | .[].cnameTo = \\\"world-tour.akamaideveloper.net.edgesuite.net\\\" | .[].edgeHostnameId = 3190586\" ${UNIQUENAME}/environments/prod/hostnames-original.json > ${UNIQUENAME}/environments/prod/hostnames.json"

echo -e "\nmv ${UNIQUENAME}/environments/variableDefinitions.json ${UNIQUENAME}/environments/variableDefinitions-original.json"
echo -e "\njq \" .definitions.originAPIHostname.type = \\\"hostname\\\" | .definitions.cpCode.default = 749512 | .definitions.originAPIHostname.default = null\" ${UNIQUENAME}/environments/variableDefinitions-original.json > ${UNIQUENAME}/environments/variableDefinitions.json"


for MYENV in dev prod ; do
	echo -e "\nmv ${UNIQUENAME}/environments/${MYENV}/variables.json ${UNIQUENAME}/environments/${MYENV}/variables-original.json"
	echo -e "\njq \".originHostname = \\\"origin-web.urbancrawlapp.com\\\" | .originAPIHostname = \\\"origin-api.urbancrawlapp.com\\\" \" ${UNIQUENAME}/environments/${MYENV}/variables-original.json > ${UNIQUENAME}/environments/${MYENV}/variables.json"
done
echo -e "\nakamai promotional-deployment list-status"
echo -e "\nakamai promotional-deployment promote dev --network staging --emails $EMAIL"
echo -e "\nakamai pd check-promotion-status dev"


