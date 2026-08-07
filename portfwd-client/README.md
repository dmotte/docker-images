# portfwd-client

:whale: **OpenSSH Client** for **port forwarding**.

## Usage

> **Note**: this Docker image runs [userngo](https://github.com/dmotte/misc/tree/main/scripts/userngo) at startup to handle user creation and setup. See https://github.com/dmotte/misc/tree/main/scripts/userngo#examples for documentation and usage examples.

> **Note**: this Docker image runs [sshset](https://github.com/dmotte/misc/tree/main/scripts/sshset) to handle SSH configuration, keys, and other files. See https://github.com/dmotte/misc/tree/main/scripts/sshset#examples for documentation and usage examples.

It's recommended to use **SSH public key authentication**. Please note that the private key file should be **unencrypted**, as otherwise the SSH client would ask for the passphrase at startup.

Then you'll need an SSH "**known hosts**" file containing the **public key(s)** of your server. To create it, you can use the following command (replace the server address and port with yours):

```bash
ssh-keyscan -p2222 10.0.2.15 > data/known-hosts/10-0-2-15-p2222.txt
```

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
