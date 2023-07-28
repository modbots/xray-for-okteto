FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY config.jsonx ./
COPY entrypoint.sh ./
COPY relay.py ./
COPY relay.sh ./

RUN apt-get update && apt-get install -y wget unzip screen iproute2 systemctl && \
    curl https://my.webhookrelay.com/webhookrelay/downloads/install-cli.sh | bash && \
    wget -O temp.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip temp.zip xray && \
    rm -f temp.zip && \
    chmod -v 755 xray entrypoint.sh relay.sh

ENTRYPOINT [ "./entrypoint.sh" ]

