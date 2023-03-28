FROM ubuntu
MAINTAINER ifeng <https://t.me/HiaiFeng>

RUN apt update -y && apt install -y wget unzip nginx supervisor qrencode net-tools

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir /etc/mysql /usr/local/mysql
COPY config.json /etc/mysql/
COPY entrypoint.sh /usr/local/mysql/

# 感谢 fscarmen 大佬提供 Dockerfile 层优化方案
RUN wget -q -O /tmp/v2ray-linux-64.zip https://github.com/v2fly/v2ray-core/releases/download/v4.45.0/v2ray-linux-64.zip && \
    unzip -d /usr/local/mysql /tmp/v2ray-linux-64.zip && \
	mv /usr/local/mysql/v2ray /usr/local/mysql/mysql && \
    chmod a+x /usr/local/mysql/entrypoint.sh