# Tested with docker.io/library/alpine:3.18.2
FROM docker.io/library/alpine:latest

RUN apk add --no-cache bind bind-dnssec-tools

# Remove auto-generated rndc.key
RUN rm -f /etc/bind/rndc.key

EXPOSE 53 53/udp

ENTRYPOINT ["/usr/sbin/named", "-c", "/etc/bind/named.conf", "-g", "-u", "named"]
