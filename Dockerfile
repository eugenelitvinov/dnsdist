FROM alpine:edge

EXPOSE 53/udp 5199 8083

VOLUME [ "/etc/dnsdist.conf.d" ]

RUN apk add --no-cache tzdata openssl dnsdist ca-certificates dumb-init && \
    mkdir /etc/dnsdist.conf.d && \
    echo 'includeDirectory("/etc/dnsdist.conf.d")' >> /etc/dnsdist.conf

ENTRYPOINT ["/usr/bin/dnsdist", "--supervised", "--disable-syslog"]
