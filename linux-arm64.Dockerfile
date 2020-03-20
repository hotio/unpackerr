FROM golang:stretch as builder
ARG BINARY=unpackerr

RUN mkdir -p $GOPATH/pkg/mod $GOPATH/bin $GOPATH/src /${BINARY}
WORKDIR /${BINARY}

ARG UNPACKERR_VERSION=de11d983c278a68b60011d3925f9fdea1e694ab5

RUN git clone -n https://github.com/davidnewhall/unpackerr.git . && \
    git checkout ${UNPACKERR_VERSION} -b hotio && \
    COMMIT_DATE=$(date -u --date=@$(git show -s --format=%ct ${UNPACKERR_VERSION}) +'%Y-%m-%dT%H:%M:%SZ') && sed -i "s/DATE=.*/DATE=${COMMIT_DATE}/g" .metadata.sh && \
    CGO_ENABLED=0 make ${BINARY}.arm64.linux

FROM hotio/base@sha256:4a7639467e698caaf379f8edb84b226ffccb6f4643372e09a0cca0bba037966b

ARG DEBIAN_FRONTEND="noninteractive"

# install app
COPY --from=builder /unpackerr/unpackerr.arm64.linux /${APP_DIR}/unpackerr

COPY root/ /
