CONFIG=$HOME/wt-setup.txt
if [ ! -f $CONFIG ] ; then 
	~/examples/helpers/wt-setup.sh
	source $CONFIG
else
	source $CONFIG
fi
echo -e "\nGenerating the list of commands..."
for NAME in robots.json Mobile_App.json show_city_depending_on_location.json Image_Manager.json ; do
	echo -e "\ncp ~/examples/pipeline/${NAME} ${UNIQUENAME}/templates/"
	echo -e "\nmv ${UNIQUENAME}/templates/main.json ${UNIQUENAME}/templates/main-original.json"
	echo -e "\njq \".rules.children +=  [\\\"#include:${NAME}\\\"]\" ${UNIQUENAME}/templates/main-original.json | jq > ${UNIQUENAME}/templates/main.json"
done
echo -e "\nsed \"s/your_unique_name_world-tour/${UNIQUENAME}/\" ~/examples/pipeline/Image_Manager.json > ${UNIQUENAME}/templates/Image_Manager.json"
echo -e "\nakamai promotional-deployment promote dev --network staging --emails $EMAIL"


