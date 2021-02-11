FROM golang:alpine as builder

ARG VERSION
RUN apk add --no-cache git build-base bash && \
    git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout ${VERSION} -b hotio && \
    CGO_ENABLED=0 make unpackerr.arm64.linux

FROM hotio/base@sha256:8332ef574312f79be79393f6cda4cafcb9ab4e1a016944cb523d149b6f7f7ef3
COPY --from=builder /unpackerr/unpackerr.arm64.linux ${APP_DIR}/unpackerr
COPY --from=builder /unpackerr/examples/unpackerr.conf.example ${APP_DIR}/unpackerr.conf.example
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
