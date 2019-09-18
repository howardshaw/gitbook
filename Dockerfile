FROM node:lts-alpine

MAINTAINER howardxiao <howardxiao@tencent.com>

#ARG VERSION=latest
ARG VERSION=3.2.3


LABEL version=$VERSION

ENV PHANTOMJS_VERSION 2.1.1
ADD .bashrc /root/

RUN  apk update \
        && apk upgrade \
        && apk add --update --no-cache bash bash-doc bash-completion git curl vim \
        && rm -rf /var/cache/apk/* \
        && npm install --global gitbook-cli \
        && gitbook fetch ${VERSION} \
        && npm cache verify \
        && curl -Ls "https://github.com/dustinblackman/phantomized/releases/download/${PHANTOMJS_VERSION}/dockerized-phantomjs.tar.gz" | tar xz -C / \
        && curl -k -Ls https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 | tar -jxvf - -C / \
        && cp phantomjs-${PHANTOMJS_VERSION}-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs \
        && sed -i "s/\(confirm: \)\S*/\1false/" ~/.gitbook/versions/${VERSION}/lib/output/website/copyPluginAssets.js \
        && rm -fR phantomjs-${PHANTOMJS_VERSION}-linux-x86_64 /tmp/*

WORKDIR /srv/gitbook

VOLUME /srv/gitbook

EXPOSE 4000 35729

CMD gitbook install ./src  && gitbook build ./src ./docs && gitbook serve ./src ./docs
