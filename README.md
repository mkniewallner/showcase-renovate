# Getting started

## Slim Docker image (with Docker in Docker)

Run Docker image:
```shell
$ docker run --rm \
    -e RENOVATE_TOKEN=$GITHUB_TOKEN \
    -e GITLAB_PYPI_SECRET_NAME=$GITLAB_PYPI_SECRET_NAME \
    -e GITLAB_PYPI_SECRET=$GITLAB_PYPI_SECRET \
    -v $(pwd)/.renovate/config.js:/usr/src/app/config.js \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /tmp:/tmp \
    renovate/renovate:slim
```

## Custom Docker slim image

Build Docker image:
```shell
docker buildx build -t renovate -f Dockerfile.renovate .
```

Run Docker image:
```shell
docker run --rm \
    -e RENOVATE_TOKEN=$GITHUB_TOKEN \
    -e GITLAB_PYPI_SECRET_NAME=$GITLAB_PYPI_SECRET_NAME \
    -e GITLAB_PYPI_SECRET=$GITLAB_PYPI_SECRET \
    -v $(pwd)/.renovate/config.js:/usr/src/app/config.js \
    renovate
```

# Interesting doc

- https://docs.renovatebot.com/docker/#google-container-registry
- https://docs.renovatebot.com/examples/self-hosting/#docker
- https://docs.renovatebot.com/getting-started/running/#docker-image
- https://github.com/renovatebot/renovate/issues/6488
