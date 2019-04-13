# Dockerfile.theia 

# Alpine 3.8 has node 8 by default, v10 doesn't work with Theia
FROM theiaide/theia:latest
ENV AKAMAI_CLI_HOME=/cli GOROOT=/usr/lib/go GOPATH=/go
ENV PATH=/go/bin:$PATH
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
USER root
RUN mkdir -p /go/bin
#RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.4/community" >> /etc/apk/repositories
#RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.4/main" >> /etc/apk/repositories
RUN mkdir -p /cli/.akamai-cli && mkdir /pipeline
RUN apk update && apk add --no-cache git bash python2 python2-dev py2-pip python3 python3-dev wget jq openssl openssl-dev openjdk8 curl build-base libffi libffi-dev vim nano util-linux go tree bind-tools libc6-compat
RUN wget -q `curl -s https://api.github.com/repos/akamai/cli/releases/latest | jq .assets[].browser_download_url | grep linuxamd64 | grep -v sig | sed s/\"//g`
RUN mv akamai-*-linuxamd64 /usr/local/bin/akamai && chmod +x /usr/local/bin/akamai
RUN apk add --no-cache nss
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
RUN go get github.com/akamai/cli && \
    cd $GOPATH/src/github.com/akamai/cli && \
    dep ensure && go build -o /usr/local/bin/akamai && \
    chmod +x /usr/local/bin/akamai
RUN pip install --upgrade pip
RUN akamai install property
RUN akamai install --force property-manager
RUN akamai install --force api-gateway
RUN akamai install sandbox && cd $AKAMAI_CLI_HOME/.akamai-cli/src/cli-sandbox/ && npm run build
RUN echo 'eval "$(/usr/local/bin/akamai --bash)"' >> /home/theia/.bashrc
RUN echo "[cli]" > /cli/.akamai-cli/config && \
    echo "cache-path            = /cli/.akamai-cli/cache" >> /cli/.akamai-cli/config && \
    echo "config-version        = 1" >> /cli/.akamai-cli/config && \
    echo "enable-cli-statistics = true" >> /cli/.akamai-cli/config && \
    echo "last-ping             = 2018-08-08T00:00:12Z" >> /cli/.akamai-cli/config && \
    echo "client-id             = world-tour" >> /cli/.akamai-cli/config && \
    echo "install-in-path       =" >> /cli/.akamai-cli/config && \
    echo "last-upgrade-check    = ignore" >> /cli/.akamai-cli/config
RUN echo '         ___    __                         _    ' >  /home/theia/.motd && \
    echo '        /   |  / /______ _____ ___  ____ _(_)   ' >> /home/theia/.motd && \
    echo '       / /| | / //_/ __ `/ __ `__ \/ __ `/ /    ' >> /home/theia/.motd && \
    echo '      / ___ |/ ,< / /_/ / / / / / / /_/ / /     ' >> /home/theia/.motd && \
    echo '     /_/  |_/_/|_|\__,_/_/ /_/ /_/\__,_/_/      ' >> /home/theia/.motd && \
    echo '================================================' >> /home/theia/.motd && \
    echo '=  Welcome to the Akamai Developer World Tour  =' >> /home/theia/.motd && \
    echo '================================================' >> /home/theia/.motd && \
    echo '=  Warning: This environment is ephemeral,     =' >> /home/theia/.motd && \
    echo '=           and may disappear.                 =' >> /home/theia/.motd && \
    echo '================================================' >> /home/theia/.motd
RUN echo "cat /home/theia/.motd" >> /home/theia/.bashrc
RUN echo "PS1='Akamai Developer [\w]$ '" >> /home/theia/.bashrc
RUN pip install httpie-edgegrid
RUN mkdir /home/theia/.httpie
RUN echo '{' >> /home/theia/.httpie/config.json && \
    echo '"__meta__": {' >> /home/theia/.httpie/config.json && \
    echo '    "about": "HTTPie configuration file", ' >> /home/theia/.httpie/config.json && \
    echo '    "httpie": "1.0.0-dev"' >> /home/theia/.httpie/config.json && \
    echo '}, ' >> /home/theia/.httpie/config.json && \
    echo '"default_options": ["--timeout=300","--style=autumn"], ' >> /home/theia/.httpie/config.json && \
    echo '"implicit_content_type": "json"' >> /home/theia/.httpie/config.json && \
    echo '}' >> /home/theia/.httpie/config.json

VOLUME /root
VOLUME /pipeline
WORKDIR /home/theia
ADD ./examples /home/theia/examples

EXPOSE 3000

ENTRYPOINT [ "node", "/home/theia/src-gen/backend/main.js", "/home/theia/examples", "--hostname=0.0.0.0" ]
