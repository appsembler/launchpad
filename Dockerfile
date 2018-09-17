FROM alpine
ENV AKAMAI_CLI_HOME=/cli
RUN mkdir /cli && \
    apk add --no-cache git bash python2 python2-dev py2-pip python3 python3-dev npm wget jq openssl openssl-dev curl nodejs build-base libffi libffi-dev && \
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
    ## MOTD message at login
    echo "echo ===============================================" >> /root/.bashrc && \
    echo "echo =  Welcome to the Akamai Developer World Tour =" >> /root/.bashrc && \
    echo "echo ===============================================" >> /root/.bashrc && \
    echo "echo =  This environment is ephemeral and may      =" >> /root/.bashrc && \
    echo "echo =  dissapear in 10 days.                      =" >> /root/.bashrc && \
    echo "echo ===============================================" >> /root/.bashrc && \
    echo "PS1='Akamai Developer [\w]$ '" >> /root/.bashrc && \
    ## Configure HTTPie
    pip install httpie-edgegrid && \
    mkdir /root/.httpie && \
    echo '{' >> /root/.httpie/config.json && \
    echo '"__meta__": {' >> /root/.httpie/config.json && \
    echo '    "about": "HTTPie configuration file", ' >> /root/.httpie/config.json && \
    echo '    "help": "https://github.com/jakubroztocil/httpie#config", ' >> /root/.httpie/config.json && \
    echo '    "httpie": "1.0.0-dev"' >> /root/.httpie/config.json && \
    echo '}, ' >> /root/.httpie/config.json && \
    echo '"default_options": ["--timeout=300","--style=autumn", "--auth-type=edgegrid"], ' >> /root/.httpie/#config.json && \
    echo '"implicit_content_type": "json"' >> /root/.httpie/config.json && \
    echo '}' >> /root/.httpie/config.json && \
    ## Create working directory
    mkdir /root/src && \
    ## Download lab files
    cd /root/src && \
    git clone https://github.com/akamai/world-tour.git && \
    mv world-tour/bin/* /usr/local/bin/ && \
    rm -rf world-tour

WORKDIR "/root/src"
VOLUME /root/.edgerc
ENTRYPOINT ["/bin/sh"]
