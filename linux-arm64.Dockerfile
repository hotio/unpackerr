FROM golang:stretch as builder

ARG VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout ${VERSION} -b hotio && \
    COMMIT_DATE=$(date -u --date=@$(git show -s --format=%ct ${VERSION}) +'%Y-%m-%dT%H:%M:%SZ') && sed -i "s/DATE=.*/DATE=${COMMIT_DATE}/g" .metadata.sh && \
    CGO_ENABLED=0 make unpackerr.arm64.linux

FROM hotio/base@sha256:395d6ccb23727ce89b8551e31f98b71a6012596cf0736e4e30ed55a045818815
COPY --from=builder /unpackerr/unpackerr.arm64.linux ${APP_DIR}/unpackerr
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
