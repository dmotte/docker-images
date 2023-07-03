# Tested with docker.io/library/alpine:3.18.2
FROM docker.io/library/alpine:latest

# Install required packages
RUN apk add --no-cache dnsmasq

# Expose DNS ports
EXPOSE 53 53/udp

ENTRYPOINT ["/usr/sbin/dnsmasq", "--no-daemon"]
