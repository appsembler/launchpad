#!/bin/bash
alias python="python3"
alias pip="pip3"
#AVL containers replace localhost with paired container domain and ip
if [ "$AVL_PAIRED_CONTAINER_EXTERNAL_DOMAIN" != "" ]; then
     sed -i "s|http://localhost:52773|https://$AVL_PAIRED_CONTAINER_EXTERNAL_DOMAIN|" /home/theia/.theia/settings.json
fi
if [ "$AVL_PAIRED_CONTAINER_DOMAIN" != "" ]; then
     export AVL_PAIRED_CONTAINER_IP=`nslookup $AVL_PAIRED_CONTAINER_NAME | grep 'Address' | sed -n 's/^.*Address: //p'`
fi
if [ "$AVL_PAIRED_CONTAINER_IP" != "" ]; then
     sed -i "s|localhost|$AVL_PAIRED_CONTAINER_IP|" /home/project/Samples-java-helloworld/simple/HelloWorld.java
     sed -i "s|localhost|$AVL_PAIRED_CONTAINER_IP|" /home/project/Samples-java-helloworld/src/main/java/com/intersystems/samples/HelloWorld.java
     sed -i "s|localhost|$AVL_PAIRED_CONTAINER_IP|" /home/project/quickstarts-multimodel-dotnet/MultiModelQS.cs
     sed -i "s|localhost|$AVL_PAIRED_CONTAINER_IP|" /home/project/quickstarts-multimodel-java/src/multimodelQS.java
     sed -i "s|localhost|$AVL_PAIRED_CONTAINER_IP|" /home/project/Samples-nodejs-helloworld/HelloWorld.js
     sed -i "s|localhost|$AVL_PAIRED_CONTAINER_IP|" /home/project/Samples-dotnet-helloworld/Simple/HelloWorld.cs
     sed -i "s|localhost|$AVL_PAIRED_CONTAINER_IP|" /home/project/Samples-python-helloworld/hello_world.py
fi
node /home/theia/src-gen/backend/main.js /home/project --hostname=0.0.0.0

