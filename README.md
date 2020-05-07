# hugo-build-docker

This is a simple, lightweight docker image to aid in building Hugo static sites.

## About

This image was meant to be used as the initial step in a [multi-stage build](https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds), so it does not expose any volumes or ports by default.

When run, it will run Hugo on the `/src` directory, and put the finished files into the `/output` directory.

## Tags

So far there is only `latest`. It will be updated as Hugo versions are released.

## Usage

1. In a new directory, create a file called `dockerfile` with the contents below
2. Create a `src/` directory, and copy your Hugo site contents there
3. Run `docker build -t website .` to build an image for your website
4. Run `docker run --name my-website -d website`

dockerfile:

```text
FROM kuzimoto/hugo-build-docker AS builder
COPY ./src /src
RUN /run.sh

FROM nginx:stable-alpine
RUN rm -r /usr/share/nginx/html/*
COPY --from=builder "/output" "/usr/share/nginx/html"
```
