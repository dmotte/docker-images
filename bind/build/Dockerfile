FROM alpine

# Install required packages
RUN apk add --no-cache bind bind-dnssec-tools

# Remove auto-generated rndc.key
RUN rm -f /etc/bind/rndc.key

# Expose DNS ports
EXPOSE 53 53/udp

ENTRYPOINT ["/usr/sbin/named", "-c", "/etc/bind/named.conf", "-g", "-u", "named"]
