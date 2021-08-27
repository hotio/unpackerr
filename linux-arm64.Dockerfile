FROM golang:alpine as builder

ARG VERSION
RUN apk add --no-cache git build-base bash && \
    git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout v${VERSION} -b hotio && \
    CGO_ENABLED=0 make unpackerr.arm64.linux

FROM ghcr.io/hotio/base@sha256:a137f6d930ea033c4ae938d27c5a5da5da3f940a5b3cfdac5579985e03f41d63
COPY --from=builder /unpackerr/unpackerr.arm64.linux ${APP_DIR}/unpackerr
COPY --from=builder /unpackerr/examples/unpackerr.conf.example ${APP_DIR}/unpackerr.conf.example
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
