ARG fts_elastic_version=1.1.0
ARG posteio_version=latest

FROM analogic/poste.io:${posteio_version}

WORKDIR /build

ARG fts_elastic_version
ARG posteio_version

ADD https://github.com/filiphanes/fts-elastic/archive/refs/tags/${fts_elastic_version}.tar.gz fts.tar.gz

RUN apt -y update && \
    apt -y install gcc make libjson-c-dev dovecot-dev autoconf automake build-essential libtool && \
    tar zxfv fts.tar.gz && cd fts-elastic-$fts_elastic_version && \
    ./autogen.sh && \
    ./configure --with-dovecot=/usr/lib/dovecot/ && \
    make install && \
    ln -sv /usr/lib/dovecot/lib21_fts_elastic_plugin.so /usr/lib/dovecot/modules/lib21_fts_elastic_plugin.so && \
    rm -rf /build && \
    cd / && \
    apt -y purge gcc make libjson-c-dev dovecot-dev autoconf automake build-essential libtool && \
    apt -y autoremove

WORKDIR /

COPY 11-fts.conf /etc/dovecot/conf.d/
ENV ELASTIC_SEARCH_URL=http://localhost:9200