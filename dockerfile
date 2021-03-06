# Build Hugo
FROM golang:alpine AS builder
RUN mkdir /go/src/hugo
WORKDIR /go/src/hugo
RUN apk add git
RUN git clone https://github.com/gohugoio/hugo.git .
RUN go install

# Build lightweight image
FROM alpine

LABEL maintainer="Kuzma Fesenko <kuzimoto@gmail.com>"

COPY ./run.sh /run.sh
COPY --from=builder "/go/bin/hugo" "/usr/local/bin"

RUN chmod +x /run.sh \
    && mkdir /src /output

CMD ["/run.sh"]
