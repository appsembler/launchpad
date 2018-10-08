CONFIG=$HOME/wt-setup.txt
if [ ! -f $CONFIG ] ; then 
	~/examples/helpers/wt-setup.sh
	source $CONFIG
else
	source $CONFIG
fi
echo -e "\nGenerating the list of commands..."
echo -e "\ncd /pipeline"
echo -e "\nakamai pipeline new-pipeline --pipeline ${UNIQUENAME} --propertyId ${UNIQUENAME} dev prod"
echo -e "\nakamai pipeline set-default --pipeline ${UNIQUENAME}"

# updating environments/dev/hostnames.json
echo -e "\nif [ ! -f ${UNIQUENAME}/environments/dev/hostnames-original.json ]; then mv ${UNIQUENAME}/environments/dev/hostnames.json ${UNIQUENAME}/environments/dev/hostnames-original.json;fi"
echo -e "\njq \".[].cnameFrom = \\\"dev.${UNIQUENAME}.world-tour.akamaideveloper.net\\\" | .[].cnameTo = \\\"world-tour.akamaideveloper.net.edgesuite.net\\\" | .[].edgeHostnameId = 3190586\" ${UNIQUENAME}/environments/dev/hostnames-original.json > ${UNIQUENAME}/environments/dev/hostnames.json"

# updating environments/prod/hostnames.json
echo -e "\nif [ ! -f  ${UNIQUENAME}/environments/prod/hostnames-original.json ]; then mv ${UNIQUENAME}/environments/prod/hostnames.json ${UNIQUENAME}/environments/prod/hostnames-original.json;fi"
echo -e "\njq \".[].cnameFrom = \\\"${UNIQUENAME}.world-tour.akamaideveloper.net\\\" | .[].cnameTo = \\\"world-tour.akamaideveloper.net.edgesuite.net\\\" | .[].edgeHostnameId = 3190586\" ${UNIQUENAME}/environments/prod/hostnames-original.json > ${UNIQUENAME}/environments/prod/hostnames.json"

# updating environments/variableDefinitions.json
echo -e "\nif [ ! -f ${UNIQUENAME}/environments/variableDefinitions-original.json ];then mv ${UNIQUENAME}/environments/variableDefinitions.json ${UNIQUENAME}/environments/variableDefinitions-original.json;fi"
echo -e "\njq \" .definitions.originAPIHostname.type = \\\"hostname\\\" | .definitions.originImagesHostname.type = \\\"hostname\\\" |.definitions.originImagesHostname.default = \\\"s3.amazonaws.com\\\"| .definitions.cpCode.default = 749512 | .definitions.originAPIHostname.default = null\" ${UNIQUENAME}/environments/variableDefinitions-original.json > ${UNIQUENAME}/environments/variableDefinitions.json"

# updating environments/${MYENV}/variables.json
for MYENV in dev prod ; do
	echo -e "\nif [ ! -f ${UNIQUENAME}/environments/${MYENV}/variables-original.json ] ; then mv ${UNIQUENAME}/environments/${MYENV}/variables.json ${UNIQUENAME}/environments/${MYENV}/variables-original.json;fi"
	echo -e "\njq \".originHostname = \\\"origin-web.urbancrawlapp.com\\\" | .originHostname = \\\"origin-web.urbancrawlapp.com\\\" | .originImagesHostname = null | .originAPIHostname = \\\"origin-api.urbancrawlapp.com\\\" \" ${UNIQUENAME}/environments/${MYENV}/variables-original.json > ${UNIQUENAME}/environments/${MYENV}/variables.json"
done

# updating templates/API.json 
echo -e "\nif [ ! -f ${UNIQUENAME}/templates/API-original.json ];then mv ${UNIQUENAME}/templates/API.json ${UNIQUENAME}/templates/API-original.json;fi"
echo -e "\njq \" .behaviors[0].options.hostname = \\\"\\\${env.originAPIHostname}\\\" \" ${UNIQUENAME}/templates/API-original.json > ${UNIQUENAME}/templates/API.json"

# updating templates/Images.json 
echo -e "\nif [ ! -f ${UNIQUENAME}/templates/Images-original.json ];then mv ${UNIQUENAME}/templates/Images.json ${UNIQUENAME}/templates/Images-original.json;fi"
echo -e "\njq \" .behaviors[0].options.hostname = \\\"\\\${env.originImagesHostname}\\\" \" ${UNIQUENAME}/templates/Images-original.json > ${UNIQUENAME}/templates/Images.json"

# copy image manager template
#echo -e "\nif [ ! -f ${UNIQUENAME}/templates/Image_manager.json ];then cp ~/examples/pipeline/Image_Manager.json ${UNIQUENAME}/templates/Image_manager.json;fi"

# edit policy name inside the image manager template and save on templates/
echo -e "\nsed \"s/your_unique_name/${UNIQUENAME}/\" ~/examples/pipeline/Image_Manager.json > ${UNIQUENAME}/templates/Image_Manager.json"

# updating templates/main.json 
echo -e "\nif [ ! -f ${UNIQUENAME}/templates/main-original.json ];then mv ${UNIQUENAME}/templates/main.json ${UNIQUENAME}/templates/main-original.json;fi"
echo -e "\njq \" .rules.children += [\\\"#include:Image_Manager.json\\\"] | .rules.behaviors += [{\\\"name\\\": \\\"edgeScape\\\",\\\"options\\\": {\\\"enabled\\\": true } } ] \" ${UNIQUENAME}/templates/main-original.json | jq > ${UNIQUENAME}/templates/main.json"

echo -e "\nakamai pipeline list-status"
echo -e "\nakamai pipeline promote dev --network staging --emails $EMAIL"
echo -e "\nakamai pd check-promotion-status dev"


