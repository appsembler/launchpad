CONFIG=${HOME}/wt-setup.txt
TEMPLATEPATH=${HOME}/examples/image-manager
if [ ! -f $CONFIG ] ; then 
	~/examples/helpers/wt-setup.sh
	source $CONFIG
else
	source $CONFIG
fi
echo -n "Enter the name of the property that contains the Image Manager behavior (for your dev environment it would be something like dev.${UNIQUENAME}): " ; read PROPERTY
POLICYNAME=`~/examples/helpers/get-im-policy-name.sh ${PROPERTY}`
if [ `echo "$POLICYNAME" | awk '{print $1}'` = "ERROR:" ] ; then
	echo -e "\nERROR: $PROPERTY does not seem to use Image Manager"
	exit 1
else
	echo -e "\nThe Image Manager Policy Set name for property ${PROPERTY} is: ${POLICYNAME}" 
	echo -e "\nExporting Policy Set name into environment variable IM_TOKEN. You can run the command below to verify:\necho $IM_TOKEN"
	export IM_TOKEN=$POLICYNAME
fi
echo -e "\nGenerating the list of commands..."
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} list-policies --network staging"
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} get-policy .auto --network staging"
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} set-policy .auto --input-file ${TEMPLATEPATH}/im_default.json --network staging"
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} set-policy watermark --input-file ${TEMPLATEPATH}/im_watermark.json --network staging"
echo -e "\nakamai image-manager --policy-set ${POLICYNAME} set-policy avatar --input-file ${TEMPLATEPATH}/im_avatar.json --network staging"

