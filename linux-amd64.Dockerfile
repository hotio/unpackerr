FROM golang:stretch as builder

ARG UNPACKERR_VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout ${UNPACKERR_VERSION} -b hotio && \
    COMMIT_DATE=$(date -u --date=@$(git show -s --format=%ct ${UNPACKERR_VERSION}) +'%Y-%m-%dT%H:%M:%SZ') && sed -i "s/DATE=.*/DATE=${COMMIT_DATE}/g" .metadata.sh && \
    CGO_ENABLED=0 make unpackerr.amd64.linux

FROM hotio/base@sha256:4bb9d047e0d0493e3d76d922014507dea1b61d0d1bd7df8927c504fbe0400a9f
COPY --from=builder /unpackerr/unpackerr.amd64.linux ${APP_DIR}/unpackerr
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
