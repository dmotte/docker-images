# docker-images

[![GitHub main workflow](https://img.shields.io/github/actions/workflow/status/dmotte/docker-images/main.yml?branch=main&logo=github&label=main&style=flat-square)](https://github.com/dmotte/docker-images/actions)

:whale: **Docker images** that don't deserve a separate repo.

These Docker images have almost no custom code (e.g. they are specific to an included software).

> :package: These images are also [on Docker Hub](https://hub.docker.com/u/dmotte) and run on **several architectures** (e.g. amd64, arm64, ...). To see the full list of supported platforms, please refer to the [`.github/workflows/main.yml`](.github/workflows/main.yml) file. If you need an architecture which is currently unsupported, feel free to open an issue.

## Development

If you want to contribute to this project, you can use the following one-liner to **rebuild an image** and bring up the **Docker-Compose stack** every time you make a change to the code:

```bash
docker-compose down && docker-compose up --build
```
