FROM golang:alpine as builder

ARG VERSION
RUN apk add --no-cache git build-base bash && \
    git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout v${VERSION} -b hotio && \
    CGO_ENABLED=0 make unpackerr.arm64.linux

FROM ghcr.io/hotio/base@sha256:05ed569c200448e11b1fb72bbd9609abef36f9d64f3174a61d908a89fe44c75c
COPY --from=builder /unpackerr/unpackerr.arm64.linux ${APP_DIR}/unpackerr
COPY --from=builder /unpackerr/examples/unpackerr.conf.example ${APP_DIR}/unpackerr.conf.example
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
