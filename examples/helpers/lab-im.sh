CONFIG=$HOME/wt-setup.txt
if [ ! -f $CONFIG ] ; then 
	~/examples/helpers/wt-setup.sh
	source $CONFIG
else
	source $CONFIG
fi
echo -n "Enter the name of the property that contains the Image Manager behavior: (for your dev environment it would be something like dev.${UNIQUENAME})" ; read PROPERTY
POLICYNAME=`~/examples/helpers/get-im-policy-name.sh ${PROPERTY}`
if [ $POLICYNAME ~ "null" ] ; then
	echo -e "\nERROR: $PROPERTY does not seem to use Image Manager"
	exit 1
else
	echo -e "\nThe Image Manager Policy Set name for property ${PROPERTY} is: ${POLICYNAME}" 
fi
echo -e "\nGenerating the list of commands..."
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} list-policies --network staging"
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} get-policy .auto --network staging"
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} set-policy .auto --input-file ~/examples/im_default.json --network staging"
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} set-policy watermark --input-file ~/examples/im_watermark.json --network staging"
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} set-policy avatar --input-file ~/examples/im_avatar.json --network staging"

