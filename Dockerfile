FROM alpine
ENV AKAMAI_CLI_HOME=/cli GOROOT=/usr/lib/go GOPATH=/go
RUN mkdir -p /cli/.akamai-cli && mkdir /pipeline
RUN apk add --no-cache git bash python2 python2-dev py2-pip python3 python3-dev npm wget jq openssl openssl-dev curl nodejs build-base libffi libffi-dev vim nano util-linux go dep tree bind-tools 
RUN wget -q `curl -s https://api.github.com/repos/akamai/cli/releases/latest | jq .assets[].browser_download_url | grep linuxamd64 | grep -v sig | sed s/\"//g`
RUN mv akamai-*-linuxamd64 /usr/local/bin/akamai && chmod +x /usr/local/bin/akamai 
RUN go get github.com/akamai/cli && cd $GOPATH/src/github.com/akamai/cli && dep ensure && go build -o /usr/local/bin/akamai && chmod +x /usr/local/bin/akamai 
RUN pip install --upgrade pip
RUN curl -s https://developer.akamai.com/cli/package-list.json | jq .packages[].name | sed s/\"//g | xargs akamai install --force 
RUN akamai install --force property-manager
RUN akamai install cli-api-gateway 
RUN echo 'eval "$(/usr/local/bin/akamai --bash)"' >> /root/.bashrc 
RUN echo "[cli]" > /cli/.akamai-cli/config && \
    echo "cache-path            = /cli/.akamai-cli/cache" >> /cli/.akamai-cli/config && \
    echo "config-version        = 1" >> /cli/.akamai-cli/config && \
    echo "enable-cli-statistics = true" >> /cli/.akamai-cli/config && \
    echo "last-ping             = 2018-08-08T00:00:12Z" >> /cli/.akamai-cli/config && \
    echo "client-id             = world-tour" >> /cli/.akamai-cli/config && \
    echo "install-in-path       =" >> /cli/.akamai-cli/config && \
    echo "last-upgrade-check    = ignore" >> /cli/.akamai-cli/config
RUN echo '         ___    __                         _    ' >  /root/.motd && \
    echo '        /   |  / /______ _____ ___  ____ _(_)   ' >> /root/.motd && \
    echo '       / /| | / //_/ __ `/ __ `__ \/ __ `/ /    ' >> /root/.motd && \
    echo '      / ___ |/ ,< / /_/ / / / / / / /_/ / /     ' >> /root/.motd && \
    echo '     /_/  |_/_/|_|\__,_/_/ /_/ /_/\__,_/_/      ' >> /root/.motd && \
    echo '================================================' >> /root/.motd && \
    echo '=  Welcome to the Akamai Developer World Tour  =' >> /root/.motd && \
    echo '================================================' >> /root/.motd && \
    echo '=  Warning: This environment is ephemeral,     =' >> /root/.motd && \
    echo '=           and may disappear.                 =' >> /root/.motd && \
    echo '================================================' >> /root/.motd
RUN echo "cat /root/.motd" >> /root/.bashrc 
RUN echo "PS1='Akamai Developer [\w]$ '" >> /root/.bashrc 
RUN pip install httpie-edgegrid 
RUN mkdir /root/.httpie 
RUN echo '{' >> /root/.httpie/config.json && \
    echo '"__meta__": {' >> /root/.httpie/config.json && \
    echo '    "about": "HTTPie configuration file", ' >> /root/.httpie/config.json && \
    echo '    "httpie": "1.0.0-dev"' >> /root/.httpie/config.json && \
    echo '}, ' >> /root/.httpie/config.json && \
    echo '"default_options": ["--timeout=300","--style=autumn"], ' >> /root/.httpie/config.json && \
    echo '"implicit_content_type": "json"' >> /root/.httpie/config.json && \
    echo '}' >> /root/.httpie/config.json

VOLUME /root
VOLUME /pipeline
WORKDIR /root
ADD ./examples /root/examples
ENTRYPOINT ["/bin/bash"]
