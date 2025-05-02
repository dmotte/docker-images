# nbd-server

:whale: **nbd-server** on _Alpine Linux_.

## Usage

The [`docker-compose.yml`](docker-compose.yml) file contains a usage example for this image. Unless you want to build the image from scratch, comment out the `build: build` line to use the pre-built one from _Docker Hub_ instead.

Create a `myimage.img` file using a command like the following:

```bash
dd if=/dev/zero of=myimage.img bs=1M count=32 status=progress
```

To start the Docker-Compose stack in daemon (detached) mode:

```bash
docker-compose up -d
```

Then you can view the logs using this command:

```bash
docker-compose logs -ft
```

Then you can access your **export** (see [`nbd-server.conf`](nbd-server.conf)) from an **NBD client**. Example for _Debian 12_ (_bookworm_):

```bash
sudo apt update && sudo apt install -y nbd-client

sudo modprobe nbd
sudo nbd-client 127.0.0.1 -N myimage /dev/nbd0
```

To disconnect:

```bash
sudo nbd-client -d /dev/nbd0
```

## Development

See the [related section in the main README](/README.md#development).

## TODO

TODO you can also use `nbd-client ... -u ...` + https://manpages.debian.org/bookworm/nbd-server/nbd-server.5.en.html#unixsock

TODO this by default runs as root inside the container, but you can extend this image adding an unprivileged user

TODO warning: NBD does **not use encryption or authentication** by default. Exposing it directly can allow **unauthorized access** or **data interception**. For secure use, always tunnel NBD traffic over **SSH** or run it behind a secure VPN or firewall-restricted interface.

## Links

- https://en.wikipedia.org/wiki/Network_block_device
- https://github.com/NetworkBlockDevice/nbd
- https://github.com/NetworkBlockDevice/nbd?tab=readme-ov-file#using-nbd
- https://packages.debian.org/bookworm/nbd-client
- https://packages.debian.org/bookworm/nbd-server
- https://manpages.debian.org/bookworm/nbd-client/nbd-client.8.en.html
- https://manpages.debian.org/bookworm/nbd-server/nbd-server.1.en.html
- https://manpages.debian.org/bookworm/nbd-server/nbd-server.5.en.html
- https://medium.com/@aysadx/linux-nbd-introduction-to-linux-network-block-devices-143365f1901b
