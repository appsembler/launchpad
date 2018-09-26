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
echo -n "Enter the name of the property that contains the Image Manager behavior: " ; read PROPERTY
POLICYNAME=`~/examples/get-im-policy-name.sh ${PROPERTY}`
if [ $POLICYNAME = "-null" ] ; then
	echo -e "\nERROR: $PROPERTY does not seem to use Image Manager"
	exit 1
else
	echo -e "\nThe Image Manager Policy Set name for property ${PROPERTY} is: ${POLICYNAME}" 
fi
echo -e "\nGenerating the list of commands..."
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} list-policies"
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} get-policy .auto"
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} set-policy .auto --input-file ~/examples/im_default.json --network both"
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} set-policy watermark --input-file ~/examples/im_watermark.json --network both"
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} set-policy face-crop1000x1000-bw --input-file ~/examples/im_detect-Bface_resize1000x1000_BW.json --network both"

