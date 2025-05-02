# nbd-server

:whale: **nbd-server** on Alpine Linux.

## Usage

The [`docker-compose.yml`](docker-compose.yml) file contains a usage example for this image. Unless you want to build the image from scratch, comment out the `build: build` line to use the pre-built one from _Docker Hub_ instead.

TODO I still need to complete this part

To start the Docker-Compose stack in daemon (detached) mode:

```bash
docker-compose up -d
```

Then you can view the logs using this command:

```bash
docker-compose logs -ft
```

## Development

See the [related section in the main README](/README.md#development).

## TODO

```bash
dd if=/dev/zero of=myimage.img bs=1M count=32 status=progress

docker-compose up -d --build && docker-compose logs -ft

docker-compose down
```

On the NBD client:

```bash
sudo apt update && sudo apt install -y nbd-client

sudo modprobe nbd

sudo nbd-client 127.0.0.1 -N myimage /dev/nbd0

sudo nbd-client -d /dev/nbd0
```

TODO you can also use `nbd-client ... -u ...` + https://manpages.debian.org/bookworm/nbd-server/nbd-server.5.en.html#unixsock

TODO this by default runs as root inside the container, but you can extend this image adding an unprivileged user

TODO warning: NBD does **not use encryption or authentication** by default. Exposing it directly can allow **unauthorized access** or **data interception**. For secure use, always tunnel NBD traffic over **SSH** or run it behind a secure VPN or firewall-restricted interface.

## Links

TODO see https://github.com/dmotte/misc/tree/main/awesome
