FROM golang:stretch as builder

ARG VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout v${VERSION} -b hotio && \
    COMMIT_DATE=$(date -u --date=@$(git show -s --format=%ct v${VERSION}) +'%Y-%m-%dT%H:%M:%SZ') && sed -i "s/DATE=.*/DATE=${COMMIT_DATE}/g" .metadata.sh && \
    CGO_ENABLED=0 make unpackerr.armhf.linux

FROM hotio/base@sha256:da1df0b31b7ce8db14acc08a2a3cc60699e5270752c4aac9a5497f955606aea5
COPY --from=builder /unpackerr/unpackerr.armhf.linux ${APP_DIR}/unpackerr
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
