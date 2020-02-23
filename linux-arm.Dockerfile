FROM golang:stretch as builder
ARG BINARY=unpackerr

RUN mkdir -p $GOPATH/pkg/mod $GOPATH/bin $GOPATH/src /${BINARY}
WORKDIR /${BINARY}

ARG UNPACKERR_VERSION=2d45aadb709b954b6f9a5cb294286a86c5b2b8bc

RUN git clone -n https://github.com/davidnewhall/unpackerr.git . && \
    git checkout ${UNPACKERR_VERSION} && \
    CGO_ENABLED=0 make ${BINARY}.armhf.linux

FROM hotio/base@sha256:8598d7707dd3e8471cf80df6a471a1f100f207ca5f1e33b08e6b0a64d961e3dd

ARG DEBIAN_FRONTEND="noninteractive"

# install app
COPY --from=builder /unpackerr/unpackerr.armhf.linux /${APP_DIR}/unpackerr

COPY root/ /
