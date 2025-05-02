# Tested with docker.io/library/alpine:3.21.3
FROM docker.io/library/alpine:latest

RUN apk add --no-cache nbd

EXPOSE 10809

ENTRYPOINT ["/usr/bin/nbd-server", "-n"]
