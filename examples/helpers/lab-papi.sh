CONFIG=$HOME/wt-setup.txt
if [ ! -f $CONFIG ] ; then 
	~/examples/helpers/wt-setup.sh
	source $CONFIG
else
	source $CONFIG
fi
echo -e "\nGenerating the list of commands..."
echo -e "\nakamai property create ${UNIQUENAME} --clone world-tour.akamaideveloper.net --hostnames ${UNIQUENAME}.world-tour.akamaideveloper.net --edgehostname world-tour.akamaideveloper.net.edgesuite.net"
echo -e "\nakamai property activate ${UNIQUENAME} --network staging"
