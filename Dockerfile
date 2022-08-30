FROM php:cli-alpine
MAINTAINER Matthieu Leorat <matthieu.leorat@pm.me>

ARG DEPLOYER_VERSION=7.0.0-rc.4

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

RUN apk add --update openssh-client rsync bash

RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

RUN mkdir /deployer && cd /deployer && curl -LO https://github.com/deployphp/deployer/releases/download/v$DEPLOYER_VERSION/deployer.phar \
&& mv deployer.phar /usr/local/bin/deployer \
&& chmod +x /usr/local/bin/deployer

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["deployer"]
