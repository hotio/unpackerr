FROM golang:stretch as builder

ARG VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout v${VERSION} -b hotio && \
    CGO_ENABLED=0 make unpackerr.amd64.linux

FROM hotio/base@sha256:8b88c1eca2ef3df526f109a37bea2e6148e45e4b7cd7517be1cb8dde8a1e4594
RUN mkdir /etc/unpackerr && ln -s "${CONFIG_DIR}/app/unpackerr.conf" /etc/unpackerr/unpackerr.conf
COPY --from=builder /unpackerr/unpackerr.amd64.linux ${APP_DIR}/unpackerr
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
