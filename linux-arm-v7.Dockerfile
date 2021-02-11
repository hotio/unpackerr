FROM golang:latest as builder

RUN apt update && apt install -y upx

ARG VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout ${VERSION} -b hotio && \
    CGO_ENABLED=0 make unpackerr.armhf.linux

FROM hotio/base@sha256:d467e7bab4178ba8a2a635b510ccc76cf73fef193c3e86026c334071eaca2886
COPY --from=builder /unpackerr/unpackerr.armhf.linux ${APP_DIR}/unpackerr
COPY --from=builder /unpackerr/examples/unpackerr.conf.example ${APP_DIR}/unpackerr.conf.example
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
