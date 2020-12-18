FROM golang:stretch as builder

ARG VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout ${VERSION} -b hotio && \
    COMMIT_DATE=$(date -u --date=@$(git show -s --format=%ct ${VERSION}) +'%Y-%m-%dT%H:%M:%SZ') && sed -i "s/DATE=.*/DATE=${COMMIT_DATE}/g" .metadata.sh && \
    CGO_ENABLED=0 make unpackerr.armhf.linux

FROM hotio/base@sha256:82a916191ff569cb247ee6895beac151cb867e518b932f7105c0ef9c560dfbae
COPY --from=builder /unpackerr/unpackerr.armhf.linux ${APP_DIR}/unpackerr
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
