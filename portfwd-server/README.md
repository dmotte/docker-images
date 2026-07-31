# portfwd-server

:whale: **OpenSSH Server** for **port forwarding**.

## Usage

> **Note**: this Docker image runs [userngo](https://github.com/dmotte/misc/tree/main/scripts/userngo) at startup to handle user creation and setup. See https://github.com/dmotte/misc/tree/main/scripts/userngo#examples for documentation and usage examples.

> **Note**: this Docker image runs [sshset](https://github.com/dmotte/misc/tree/main/scripts/sshset) to handle SSH configuration, keys, and other files. See https://github.com/dmotte/misc/tree/main/scripts/sshset#examples for documentation and usage examples.

To run this Docker image in a meaningful way, you need to write **configuration** files first. You can find examples in the [`data-root`](data-root) and [`data-unpriv`](data-unpriv) directories. In particular, you can use the [`PermitListen`](https://man.openbsd.org/sshd_config#PermitListen) and [`PermitOpen`](https://man.openbsd.org/sshd_config#PermitOpen) directives to specify which ports can be forwarded by the clients.

> :bulb: **Tip**: you can also specify [key options](https://man.openbsd.org/OpenBSD-current/man8/sshd.8#AUTHORIZED_KEYS_FILE_FORMAT) in the public key files, e.g. `permitlisten="8080" ssh-ed25519 AAAAC3Nza...`

The [`docker-compose.yml`](docker-compose.yml) file contains a usage example for this image. Unless you want to build the image from scratch, comment out the `build: build` line to use the pre-built one from _Docker Hub_ instead.

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
