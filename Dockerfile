ARG xapian_version=1.5.5
ARG posteio_version=latest

FROM analogic/poste.io:${posteio_version}

WORKDIR /build

ARG xapian_version
ARG posteio_version

ADD https://github.com/grosjo/fts-xapian/releases/download/${xapian_version}/dovecot-fts-xapian-${xapian_version}.tar.gz fts.tar.gz

RUN apt -y update && \
    apt -y install build-essential dovecot-dev git libxapian-dev libicu-dev libsqlite3-dev autoconf automake libtool pkg-config libxapian30 && \
    tar zxfv fts.tar.gz && cd fts-xapian-$xapian_version && \
    autoupdate && \
    autoreconf -vi && \
    ./configure --with-dovecot=/usr/lib/dovecot/ && \
    make install && \
    rm -rf /build && \
    cd / && \
    apt -y purge build-essential dovecot-dev git libxapian-dev libicu-dev libsqlite3-dev autoconf automake libtool pkg-config && \
    apt -y autoremove

WORKDIR /

COPY 11-fts.conf /etc/dovecot/conf.d/