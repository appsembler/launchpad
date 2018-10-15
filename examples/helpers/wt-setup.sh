CONFIG=$HOME/wt-setup.txt
echo "Enter the unique name you are going to use. A good practice is your initial and last name, a dash and the city where you are. For example jsmith-sanfrancisco"
echo -n "Unique name: " ; read UNIQUENAME
#UNIQUENAME="`echo ${FIRSTNAME}|awk '{print tolower(substr ($0, 0, 1))}'``echo ${LASTNAME}| awk '{print tolower($1)}'`-`date +'%Y%m%d'`"
UNIQUENAME=`echo ${UNIQUENAME} | awk '{gsub(/ /, "", $0);print tolower($0)}'`
echo "Your unique name is: ${UNIQUENAME}"
echo "UNIQUENAME=${UNIQUENAME}" > $CONFIG
echo -n "email (for receiving activation notifications): " ; read EMAIL
echo "EMAIL=${EMAIL}" >> $CONFIG
