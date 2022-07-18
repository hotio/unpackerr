FROM golang:alpine as builder

ARG VERSION
RUN apk add --no-cache git build-base bash && \
    git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout v${VERSION} -b hotio && \
    CGO_ENABLED=0 make unpackerr.amd64.linux

FROM cr.hotio.dev/hotio/base@sha256:51b4032b5584538d5987a759e74201ef2626502750efe77d4f7124eb56284c4e
COPY --from=builder /unpackerr/unpackerr.amd64.linux ${APP_DIR}/unpackerr
COPY --from=builder /unpackerr/examples/unpackerr.conf.example ${APP_DIR}/unpackerr.conf.example
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
