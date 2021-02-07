FROM golang:stretch as builder

ARG VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout ${VERSION} -b hotio && \
    CGO_ENABLED=0 make unpackerr.arm64.linux

FROM hotio/base@sha256:8332ef574312f79be79393f6cda4cafcb9ab4e1a016944cb523d149b6f7f7ef3
RUN mkdir /etc/unpackerr && ln -s "${CONFIG_DIR}/app/unpackerr.conf" /etc/unpackerr/unpackerr.conf
COPY --from=builder /unpackerr/unpackerr.arm64.linux ${APP_DIR}/unpackerr
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
