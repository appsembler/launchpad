FROM alpine
ENV AKAMAI_CLI_HOME=/cli
RUN mkdir /cli && \
    apk add --no-cache git bash python2 python2-dev py2-pip python3 python3-dev npm wget jq openssl openssl-dev curl nodejs build-base libffi libffi-dev vim nano openjdk8-jre && \
    wget -q `curl -s https://api.github.com/repos/akamai/cli/releases/latest | jq .assets[].browser_download_url | grep linuxamd64 | grep -v sig | sed s/\"//g`; \
    mv akamai-*-linuxamd64 /usr/local/bin/akamai && chmod +x /usr/local/bin/akamai && \
    mkdir -p /cli/.akamai-cli && \
    pip install --upgrade pip && \
    curl -s https://developer.akamai.com/cli/package-list.json | jq .packages[].name | sed s/\"//g | xargs akamai install --force && \
    akamai install --force promotional-deployment && \
    ## CLI Settings
    echo "[cli]" > /cli/.akamai-cli/config && \
    echo "cache-path            = /cli/.akamai-cli/cache" >> /cli/.akamai-cli/config && \
    echo "config-version        = 1" >> /cli/.akamai-cli/config && \
    echo "enable-cli-statistics = true" >> /cli/.akamai-cli/config && \
    echo "last-ping             = 2018-08-08T00:00:12Z" >> /cli/.akamai-cli/config && \
    echo "client-id             = world-tour" >> /cli/.akamai-cli/config && \
    echo "install-in-path       =" >> /cli/.akamai-cli/config && \
    echo "last-upgrade-check    = ignore" >> /cli/.akamai-cli/config && \
    ## MOTD message 
    echo "         ___    __                         _    " > /etc/motd && \
    echo "        /   |  / /______ _____ ___  ____ _(_)   " >> /etc/motd && \
    echo "       / /| | / //_/ __ `/ __ `__ \/ __ `/ /    " >> /etc/motd && \
    echo "      / ___ |/ ,< / /_/ / / / / / / /_/ / /     " >> /etc/motd && \
    echo "     /_/  |_/_/|_|\__,_/_/ /_/ /_/\__,_/_/      " >> /etc/motd && \
    echo "================================================" >> /etc/motd && \
    echo "=  Welcome to the Akamai Developer World Tour  =" >> /etc/motd && \
    echo "================================================" >> /etc/motd && \
    echo "=  Warning: This environment is ephemeral,     =" >> /etc/motd && \
    echo "=           and may dissapear.                 =" >> /etc/motd && \
    echo "================================================" >> /etc/motd && \
    echo "cat /etc/motd" >> /root/.bashrc && \
    echo "PS1='Akamai Developer [\w]$ '" >> /root/.bashrc && \
    ## Configure HTTPie
    pip install httpie-edgegrid && \
    mkdir /root/.httpie && \
    echo '{' >> /root/.httpie/config.json && \
    echo '"__meta__": {' >> /root/.httpie/config.json && \
    echo '    "about": "HTTPie configuration file", ' >> /root/.httpie/config.json && \
    echo '    "httpie": "1.0.0-dev"' >> /root/.httpie/config.json && \
    echo '}, ' >> /root/.httpie/config.json && \
    echo '"default_options": ["--timeout=300","--style=autumn", "--auth-type=edgegrid"], ' >> /root/.httpie/config.json && \
    echo '"implicit_content_type": "json"' >> /root/.httpie/config.json && \
    echo '}' >> /root/.httpie/config.json 

COPY bin/* /usr/local/bin/

VOLUME /root
WORKDIR "/root"
ENTRYPOINT ["/bin/bash"]
