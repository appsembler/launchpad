FROM node:8.15

ENV DEBIAN_FRONTEND noninteractive

#Common deps
## Found these are already built into node:8.15
# RUN apt-get update && apt-get -y install curl xz-utils wget gpg

#Install node and yarn
#From: https://github.com/nodejs/docker-node/blob/6b8d86d6ad59e0d1e7a94cec2e909cad137a028f/8/Dockerfile

# Add git token to reduce API throttling
ARG GITHUB_TOKEN=212afc960b6126e8c2a295e6b11d9b2c089f5519

#Theia
##Needed for node-gyp, nsfw build
RUN apt-get update && apt-get install -y python build-essential

ARG version=latest
WORKDIR /home/theia
ADD $version.package.json ./package.json
ADD theia-isc-extension/isc-extension ./isc-extension
# using "NODE_OPTIONS=..." to avoid out-of-memory problem in CI
#RUN yarn --cache-folder ./ycache && rm -rf ./ycache && \
#    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build
RUN yarn --pure-lockfile && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build && \
    yarn --production && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    rm -rf ./node_modules/electron && \
    yarn cache clean

	
## Second stage
## node:8.15-slim is only 139MB
FROM node:8.15-slim

ENV DEBIAN_FRONTEND noninteractive

#Common deps
# TODO: 90MB of junk - to install wget (used for .NET Core) and git and sudo 
RUN apt-get update && apt-get -y install wget git sudo dnsutils

#Developer tools
ARG GITHUB_TOKEN=212afc960b6126e8c2a295e6b11d9b2c089f5519

#LSPs

#Java - install headless version (no GUI) and accept oracle license and add a man directory due to slim build issues
# TODO: 174MB
RUN mkdir -p /usr/share/man/man1 && \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get update && apt-get -y install openjdk-8-jdk-headless

	
#Python 3
# Fix language server see: https://github.com/theia-ide/theia-apps/issues/74
# TODO: 312MB for Python3 - is there a Python3-slim?  Would it work?  Python:3.6-slim container is 138MB
RUN apt-get update \
    && apt-get install -y python3 python3-dev python3-pip \ 
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
RUN  update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN pip3 install \
    python-language-server \
	backports.functools_lru_cache \
    flake8 \
    autopep8 \
    futures \
    configparser \
    rope \
    pydocstyle \
    yapf
	
## User account
RUN adduser --disabled-password --gecos '' theia && \
    adduser theia sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers;

# .NET Core
# TODO: 516MB total - does that sound right?  Probably need to delete unneeded files?
RUN apt-get update && \
	apt-get install -y libunwind8 && \
	wget https://dot.net/v1/dotnet-install.sh && \
	chmod +x dotnet-install.sh && \
	./dotnet-install.sh -c Current -i /home/theia/.dotnet && \
	rm -f dotnet-install.sh && \
    chown -R theia:theia /home/theia/.dotnet && \
	PATH=/home/theia/.dotnet:$PATH

COPY --chown=theia:theia settings.json /home/theia/.theia/settings.json
COPY --chown=theia:theia .bashrc /home/theia/.bashrc
COPY --chown=theia:theia InterSystemsLabs.README.md /home/project/README.md
COPY --chown=theia:theia InterSystemsLabsDiagram.png /home/project/InterSystemsLabsDiagram.png
COPY --chown=theia:theia gitClone.gif /home/project/gitClone.gif
COPY --chown=theia:theia startup.sh /home/theia/.theia/startup.sh

RUN chmod g+rw /home && \
    chmod +x /home/theia/.theia/startup.sh && \
    mkdir -p /home/project && \
	cd /home/project && \
	git clone https://$GITHUB_TOKEN@github.com/intersystems/Samples-python-helloworld && rm -r /home/project/Samples-python-helloworld/.git && \
	git clone https://$GITHUB_TOKEN@github.com/intersystems/Samples-nodejs-helloworld && rm -r /home/project/Samples-nodejs-helloworld/.git && \
	git clone --single-branch --branch dotnetcore https://$GITHUB_TOKEN@github.com/intersystems/quickstarts-multimodel-dotnet && rm -r /home/project/quickstarts-multimodel-dotnet/.git && \
	git clone https://$GITHUB_TOKEN@github.com/intersystems/quickstarts-multimodel-java && rm -r /home/project/quickstarts-multimodel-java/.git && \
	git clone --single-branch --branch dotnet_core https://$GITHUB_TOKEN@github.com/intersystems/Samples-dotnet-helloworld && rm -r /home/project/Samples-dotnet-helloworld/.git && \
	git clone https://$GITHUB_TOKEN@github.com/intersystems/Samples-java-helloworld && rm -r /home/project/Samples-java-helloworld/.git && \
	mkdir Samples-java-helloworld/simple && \
	cp Samples-java-helloworld/lib/intersystems-jdbc-3.0.0.jar Samples-java-helloworld/simple/intersystems-jdbc-3.0.0.jar && \
	cp Samples-java-helloworld/src/main/java/com/intersystems/samples/HelloWorld.java Samples-java-helloworld/simple/HelloWorld.java && \
    chown -R theia:theia /home/project && chmod -R a+w /home/project
#USER theia
EXPOSE 3000
ENV SHELL /bin/bash
ENV HOME /home/theia
WORKDIR /home/theia
# Reduced COPY from 569MB to 365MB
COPY --from=0 --chown=theia:theia /home/theia /home/theia

ENTRYPOINT [ "/home/theia/.theia/startup.sh" ]
