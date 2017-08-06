FROM ubuntu:16.04

ENV TINI_VERSION="v0.15.0" NFS_EXPORTS=""

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini

RUN apt-get -qq update && \
    apt-get install -y nfs-kernel-server && \
    chmod +x /tini && \
    rm -rf /var/lib/apt/lists/* && \
    echo "nfs 2049/tcp" >> /etc/services && \
    echo "nfs 111/udp" >> /etc/services

ADD entrypoint.sh /sbin/entrypoint.sh

EXPOSE 111/udp 2049/tcp

ENTRYPOINT ["/tini", "--"]

CMD ["/sbin/entrypoint.sh"]
