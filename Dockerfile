FROM alpine:edge

EXPOSE 53/udp 5199 8083

VOLUME ["/etc/dnsdist.conf.d"]

# Fix repositories and install dnsdist
RUN cat > /etc/apk/repositories <<EOF \
https://dl-cdn.alpinelinux.org/alpine/v$(cut -d'.' -f1,2 /etc/alpine-release)/main/ \
https://dl-cdn.alpinelinux.org/alpine/v$(cut -d'.' -f1,2 /etc/alpine-release)/community/ \
https://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
EOF \
&& apk update \
&& apk add --no-cache dnsdist \
&& mkdir -p /etc/dnsdist.conf.d \
&& echo 'includeDirectory("/etc/dnsdist.conf.d")' >> /etc/dnsdist.conf

ENTRYPOINT ["/usr/bin/dnsdist", "--supervised", "--disable-syslog"]
