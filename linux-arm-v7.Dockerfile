FROM golang:alpine as builder

ARG VERSION
RUN apk add --no-cache git build-base bash && \
    git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout ${VERSION} -b hotio && \
    CGO_ENABLED=0 make unpackerr.armhf.linux

FROM hotio/base@sha256:ed5052300d2e5b6ce7e1cda9ae91707f5ad6562941023d440ce8f909368224fa
COPY --from=builder /unpackerr/unpackerr.armhf.linux ${APP_DIR}/unpackerr
COPY --from=builder /unpackerr/examples/unpackerr.conf.example ${APP_DIR}/unpackerr.conf.example
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
