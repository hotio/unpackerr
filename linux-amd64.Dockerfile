FROM golang:stretch as builder

ARG VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout v${VERSION} -b hotio && \
    COMMIT_DATE=$(date -u --date=@$(git show -s --format=%ct v${VERSION}) +'%Y-%m-%dT%H:%M:%SZ') && sed -i "s/DATE=.*/DATE=${COMMIT_DATE}/g" .metadata.sh && \
    CGO_ENABLED=0 make unpackerr.amd64.linux

FROM hotio/base@sha256:8dab11de6a8e64fbbdef2b1ef1b6c64ff8ada8401589d0b4d384ad20300fb24e
COPY --from=builder /unpackerr/unpackerr.amd64.linux ${APP_DIR}/unpackerr
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
