CONFIG=$HOME/wt-setup.txt
if [ ! -f $CONFIG ] ; then 
	~/examples/wt-setup.sh
else
	source $CONFIG
fi
echo -e "\nGenerating the list of commands..."
echo -e "\nakamai property create ${UNIQUENAME}.world-tour --clone world-tour.akamaideveloper.net --hostnames ${UNIQUENAME}.world-tour.akamaideveloper.net --edgehostname world-tour.akamaideveloper.net.edgesuite.net"
echo -e "\nakamai property activate ${UNIQUENAME}.world-tour --network staging"
