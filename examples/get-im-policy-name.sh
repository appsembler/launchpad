echo `akamai property retrieve $1 2> /dev/null|grep policyTokenDefault|sed 's/.*://;s/,//;s/"//g'`-`akamai property search $1 2> /dev/null | jq '.versions.items[0].assetId'|sed 's/.*_//;s/"//'`

