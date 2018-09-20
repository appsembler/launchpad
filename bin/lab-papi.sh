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
echo -e "\nakamai property create ${UNIQUENAME}.world-tour --clone world-tour.akamaideveloper.net --origin ${UNIQUENAME}.origin.akamaideveloper.net --hostnames ${UNIQUENAME}.world-tour.akamaideveloper.net --edgehostname world-tour.akamaideveloper.net.edgesuite.net"
#echo -e "\nakamai property modify ${UNIQUENAME}.world-tour --origin ${UNIQUENAME}.origin.akamaideveloper.net --addhosts ${UNIQUENAME}.world-tour.akamaideveloper.net --edgehostname world-tour.akamaideveloper.net.edgesuite.net"
echo -e "\nakamai property activate ${UNIQUENAME}.world-tour --network staging"
