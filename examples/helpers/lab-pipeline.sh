CONFIG=$HOME/wt-setup.txt
DEFDIR="/pipeline"
MYERROR=0
DEBUG=0

if [ ! -f $CONFIG ] ; then 
	~/examples/helpers/wt-setup.sh
	source $CONFIG
else
	source $CONFIG
fi

if [ $DEBUG = 1 ] ; then echo "** cd /pipeline" ; fi

# check if we are in the right directory
if [ ! $PWD = $DEFDIR ] ; then
	echo "ERROR: You should be in the $DEFDIR directory. Type:"
	echo -e "\ncd $DEFDIR"
	exit 1
fi

if [ $DEBUG = 1 ] ; then echo "** create pipeline" ; fi

# check if pipeline exists, otherwise show commands needed to create it
if [ ! -d ${UNIQUENAME} ] ; then
	echo "ERROR: Your pipeline doesn't seem to exist. Type:"
	echo -e "\nakamai pipeline new-pipeline --pipeline ${UNIQUENAME} --propertyId ${UNIQUENAME} dev prod"
	exit 1
fi

if [ $DEBUG = 1 ] ; then echo "** set default pipeline" ; fi

# check if pipeline is set as default
if [ ! -f ${DEFDIR}/devopsSettings.json ] ; then
	echo "ERROR: You don't seem to set a default pipeline. Type:"
	echo -e "\nakamai pipeline set-default --pipeline ${UNIQUENAME}"
	exit 1
else
	if [ ! `jq '.defaultProject' ${DEFDIR}/devopsSettings.json | sed 's/"//g'` = ${UNIQUENAME} ] ; then
		echo "ERROR: You need to set the correct default pipeline. Type:"
		echo -e "\nakamai pipeline set-default --pipeline ${UNIQUENAME}"
		exit 1	
	fi
fi
	
# check if edits made to environments/dev/hostnames.json
MYFILE="${UNIQUENAME}/environments/dev/hostnames.json"
if [ $DEBUG = 1 ] ; then echo "** $MYFILE" ; fi
if [ ! -f $MYFILE ]; then 
	echo -e "\nERROR: $MYFILE does not exist"
	exit 1
else
	# updating environments/dev/hostnames.json
	if [ ! -f ${MYFILE}-original ]; then 
		cp -p ${MYFILE} ${MYFILE}-original
	fi
	# check if file has the right edits
	ERROR=0
	CNAMEFROM=`jq '.[].cnameFrom' ${MYFILE} | sed 's/"//g'`
	VALUE=dev.${UNIQUENAME}.world-tour.akamaideveloper.net
	if [ ! $CNAMEFROM = $VALUE ] ; then
		echo -e "\nERROR: cnameFrom is $CNAMEFROM; but it should be: ${VALUE}"
		ERROR=1
	fi
	CNAMETO=`jq '.[].cnameTo' ${MYFILE} | sed 's/"//g'`
	VALUE=world-tour.akamaideveloper.net.edgesuite.net
	if [ ! $CNAMETO = $VALUE ] ; then
		echo -e "\nERROR: cnameTo is $CNAMETO; but it should be: ${VALUE}"
		ERROR=1
	fi
	CNAMEID=`jq '.[].edgeHostnameId' ${MYFILE} | sed 's/"//g'`
	VALUE=3190586
	if [ ! $CNAMEID = $VALUE ] ; then
		echo -e "\nERROR: edgeHostnameId is $CNAMEID; but it should be: ${VALUE}"
		ERROR=1
	fi
	if [ $ERROR = 1 ] ; then
		echo -e "\nYou can edit the file manually, or use the following command to update to the right values:"
		echo -e "\njq \".[].cnameFrom = \\\"dev.${UNIQUENAME}.world-tour.akamaideveloper.net\\\" | .[].cnameTo = \\\"world-tour.akamaideveloper.net.edgesuite.net\\\" | .[].edgeHostnameId = 3190586\" ${MYFILE}-original > ${MYFILE}"
		exit 1
	fi
fi

# check if edits made to environments/prod/hostnames.json
MYFILE="${UNIQUENAME}/environments/prod/hostnames.json"
if [ $DEBUG = 1 ] ; then echo "** $MYFILE" ; fi
if [ ! -f $MYFILE ]; then 
	echo -e "\nERROR: $MYFILE does not exist"
	exit 1
else
	# updating environments/prod/hostnames.json
	if [ ! -f ${MYFILE}-original ]; then 
		cp -p ${MYFILE} ${MYFILE}-original
	fi
	ERRORMSG="\nERROR with file: ${MYFILE}"
	ERROR=0
	# check if file has the right edits
	FIELD=cnameFrom
	FIELDVALUE=`jq '.[].cnameFrom' ${MYFILE} | sed 's/"//g'`
	VALUE=${UNIQUENAME}.world-tour.akamaideveloper.net
	if [ ! $FIELDVALUE = $VALUE ] ; then
		ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
		ERROR=1
	fi
	FIELD=cnameTo
	FIELDVALUE=`jq '.[].cnameTo' ${MYFILE} | sed 's/"//g'`
	VALUE=world-tour.akamaideveloper.net.edgesuite.net
	if [ ! $FIELDVALUE = $VALUE ] ; then
		ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
		ERROR=1
	fi
	FIELD=edgeHostnameId
	FIELDVALUE=`jq '.[].edgeHostnameId' ${MYFILE} | sed 's/"//g'`
	VALUE=3190586
	if [ ! $FIELDVALUE = $VALUE ] ; then
		ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
		ERROR=1
	fi
	if [ $ERROR = 1 ] ; then
		echo -e $ERRORMSG
		echo -e "\nYou can edit the file manually, or use the following command to update to the right values:"
		echo -e "\njq \".[].cnameFrom = \\\"${UNIQUENAME}.world-tour.akamaideveloper.net\\\" | .[].cnameTo = \\\"world-tour.akamaideveloper.net.edgesuite.net\\\" | .[].edgeHostnameId = 3190586\" ${MYFILE}-original > ${MYFILE}"
		exit 1
	fi
fi

# check if edits made to environments/variableDefinitions.json
MYFILE="${UNIQUENAME}/environments/variableDefinitions.json"
if [ $DEBUG = 1 ] ; then echo "** $MYFILE" ; fi
if [ ! -f $MYFILE ]; then 
	echo -e "\nERROR: $MYFILE does not exist"
	exit 1
else
	ERRORMSG="\nERROR with file: ${MYFILE}"
	ERROR=0
	# updating environments/variableDefinitions.json
	if [ ! -f ${MYFILE}-original ]; then 
		cp -p ${MYFILE} ${MYFILE}-original
	fi
	# check if file has the right edits
	FIELD=originAPIHostname.type
	FIELDVALUE=`jq '.definitions.originAPIHostname.type' ${MYFILE} | sed 's/"//g'`
	VALUE=hostname
	if [ ! $FIELDVALUE = $VALUE ] ; then
		ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
		ERROR=1
	fi
	FIELD=originAPIHostname.default
	FIELDVALUE=`jq '.definitions.originAPIHostname.default' ${MYFILE} | sed 's/"//g'`
	VALUE=null
	if [ ! $FIELDVALUE = $VALUE ] ; then
		ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
		ERROR=1
	fi
	FIELD=originImagesHostname.type
	FIELDVALUE=`jq '.definitions.originImagesHostname.type' ${MYFILE} | sed 's/"//g'`
	VALUE=hostname
	if [ ! $FIELDVALUE = $VALUE ] ; then
		ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
		ERROR=1
	fi
	FIELD=originImagesHostname.default
	FIELDVALUE=`jq '.definitions.originImagesHostname.default' ${MYFILE} | sed 's/"//g'`
	VALUE=s3.amazonaws.com
	if [ ! $FIELDVALUE = $VALUE ] ; then
		ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
		ERROR=1
	fi
	FIELD=cpCode.default
	FIELDVALUE=`jq '.definitions.cpCode.default' ${MYFILE} | sed 's/"//g'`
	VALUE=749512
	if [ ! $FIELDVALUE = $VALUE ] ; then
		ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
		ERROR=1
	fi
	if [ $ERROR = 1 ] ; then
		echo -e $ERRORMSG
		echo -e "You can edit the file manually, or use the following command to update to the right values:"
		echo -e "\njq \" .definitions.originAPIHostname.type = \\\"hostname\\\" | .definitions.originImagesHostname.type = \\\"hostname\\\" |.definitions.originImagesHostname.default = \\\"s3.amazonaws.com\\\"| .definitions.cpCode.default = 749512 | .definitions.originAPIHostname.default = null\" ${MYFILE}-original > ${MYFILE}"
		exit 1
	fi
fi

# updating environments/${MYENV}/variables.json
for MYENV in dev prod ; do

	MYFILE="${UNIQUENAME}/environments/${MYENV}/variables.json"
	if [ $DEBUG = 1 ] ; then echo "** $MYFILE" ; fi
	if [ ! -f $MYFILE ]; then 
		echo -e "\nERROR: $MYFILE does not exist"
		exit 1
	else
		ERRORMSG="\nERROR with file: ${MYFILE}"
		ERROR=0
		# updating environments/variableDefinitions.json
		if [ ! -f ${MYFILE}-original ]; then 
			cp -p ${MYFILE} ${MYFILE}-original
		fi
		# check if file has the right edits
		FIELD=originHostname
		FIELDVALUE=`jq '.originHostname' ${MYFILE} | sed 's/"//g'`
		VALUE=origin-web.urbancrawlapp.com
		if [ ! $FIELDVALUE = $VALUE ] ; then
			ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
			ERROR=1
		fi
		FIELD=originAPIHostname
		FIELDVALUE=`jq '.originAPIHostname' ${MYFILE} | sed 's/"//g'`
		VALUE=origin-api.urbancrawlapp.com
		if [ ! $FIELDVALUE = $VALUE ] ; then
			ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
			ERROR=1
		fi
		FIELD=originImagesHostname
		FIELDVALUE=`jq '.originImagesHostname' ${MYFILE} | sed 's/"//g'`
		VALUE=null
		if [ ! $FIELDVALUE = $VALUE ] ; then
			ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
			ERROR=1
		fi
		if [ $ERROR = 1 ] ; then
			echo -e $ERRORMSG
			echo -e "You can edit the file manually, or use the following command to update to the right values:"
			echo -e "\njq \".originHostname = \\\"origin-web.urbancrawlapp.com\\\" | .originImagesHostname = null | .originAPIHostname = \\\"origin-api.urbancrawlapp.com\\\" \" ${MYFILE}-original > ${MYFILE}"
			exit 1
		fi
	fi
done

# updating templates/API.json 
MYFILE="${UNIQUENAME}/templates/API.json"
if [ $DEBUG = 1 ] ; then echo "** $MYFILE" ; fi

if [ ! -f $MYFILE ]; then 
	echo -e "\nERROR: $MYFILE does not exist"
	exit 1
else
	ERRORMSG="\nERROR with file: ${MYFILE}"
	ERROR=0
	# updating environments/variableDefinitions.json
	if [ ! -f ${MYFILE}-original ]; then 
		cp -p ${MYFILE} ${MYFILE}-original
	fi
	# check if file has the right edits
	FIELD=hostname
	FIELDVALUE=`jq '.behaviors[0].options.hostname' ${MYFILE} | sed 's/"//g'`
	VALUE="\${env.originAPIHostname}"
	if [ ! $FIELDVALUE = $VALUE ] ; then
		ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
		ERROR=1
	fi
	if [ $ERROR = 1 ] ; then
		echo -e $ERRORMSG
		echo -e "You can edit the file manually, or use the following command to update to the right values:"
		echo -e "\njq \".behaviors[0].options.hostname = \\\"\\\${env.originAPIHostname}\\\" \" ${MYFILE}-original > ${MYFILE}"
		exit 1
	fi
fi

# updating templates/Images.json 
MYFILE="${UNIQUENAME}/templates/Images.json"
if [ $DEBUG = 1 ] ; then echo "** $MYFILE" ; fi

if [ ! -f $MYFILE ]; then 
	echo -e "\nERROR: $MYFILE does not exist"
	exit 1
else
	ERRORMSG="\nERROR with file: ${MYFILE}"
	ERROR=0
	# updating environments/variableDefinitions.json
	if [ ! -f ${MYFILE}-original ]; then 
		cp -p ${MYFILE} ${MYFILE}-original
	fi
	# check if file has the right edits
	FIELD=hostname
	FIELDVALUE=`jq '.behaviors[0].options.hostname' ${MYFILE} | sed 's/"//g'`
	VALUE="\${env.originImagesHostname}"
	if [ ! $FIELDVALUE = $VALUE ] ; then
		ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
		ERROR=1
	fi
	if [ $ERROR = 1 ] ; then
		echo -e $ERRORMSG
		echo -e "You can edit the file manually, or use the following command to update to the right values:"
		echo -e "\njq \".behaviors[0].options.hostname = \\\"\\\${env.originImagesHostname}\\\" \" ${MYFILE}-original > ${MYFILE}"
		exit 1
	fi
fi

# updating templates/Image_Manager.json
MYFILE="${UNIQUENAME}/templates/Image_Manager.json"
if [ $DEBUG = 1 ] ; then echo "** $MYFILE" ; fi

if [ ! -f $MYFILE ]; then 
	echo -e "\nERROR: $MYFILE does not exist. You can create it using:\ncp -p ~/examples/pipeline/Image_Manager.json $MYFILE"
	exit 1
else
	ERRORMSG="\nERROR with file: ${MYFILE}"
	ERROR=0
	# updating environments/variableDefinitions.json
	if [ ! -f ${MYFILE}-original ]; then 
		cp -p ${MYFILE} ${MYFILE}-original
	fi
	# check if file has the right edits
	FIELD=policyTokenDefault
	FIELDVALUE=`jq '.behaviors[1].options.policyTokenDefault' ${MYFILE} | sed 's/"//g'`
	VALUE="${UNIQUENAME}"
	if [ ! $FIELDVALUE = $VALUE ] ; then
		ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
		ERROR=1
	fi
	if [ $ERROR = 1 ] ; then
		echo -e $ERRORMSG
		echo -e "You can edit the file manually, or use the following command to update to the right values:"
		echo -e "\njq \".behaviors[1].options.policyTokenDefault = \\\"${UNIQUENAME}\\\" \" ${MYFILE}-original > ${MYFILE}"
		exit 1
	fi
fi

# updating templates/main.json 
MYFILE="${UNIQUENAME}/templates/main.json"
if [ $DEBUG = 1 ] ; then echo "** $MYFILE" ; fi

if [ ! -f $MYFILE ]; then 
	echo -e "\nERROR: $MYFILE does not exist"
	exit 1
else
	ERRORMSG="\nERROR with file: ${MYFILE}"
	ERROR=0
	if [ ! -f ${MYFILE}-original ]; then 
		cp -p ${MYFILE} ${MYFILE}-original
	fi
	# check if file has the right edits
	FIELD=rules.children
	FIELDVALUE=`jq -c '.rules.children' ${MYFILE} `
	VALUE="[\"#include:performance.json\",\"#include:Offload.json\",\"#include:API.json\",\"#include:Images.json\",\"#include:Image_Manager.json\"]"
	if [ ! $FIELDVALUE = $VALUE ] ; then
		ERRORMSG="${ERRORMSG}\n\tERROR: $FIELD is $FIELDVALUE; but it should be: ${VALUE}"
		ERROR=1
	fi
	if [ $ERROR = 1 ] ; then
		echo -e $ERRORMSG
		echo -e "You can edit the file manually, or use the following command to update to the right values:"
		echo -e "\njq \" .rules.children += [\\\"#include:Image_Manager.json\\\"] | .rules.behaviors += [{\\\"name\\\": \\\"edgeScape\\\",\\\"options\\\": {\\\"enabled\\\": true } } ] \" ${MYFILE}-original > ${MYFILE}"
		exit 1
	fi
fi

# echo -e "\nakamai pipeline list-status"
echo -e "\nEverything looks good, to promote your changes you can run:\nakamai pipeline promote dev --network staging --emails $EMAIL"
#echo -e "\nakamai pd check-promotion-status dev"