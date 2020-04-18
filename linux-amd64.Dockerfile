FROM golang:stretch as builder

ARG UNPACKERR_VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout ${UNPACKERR_VERSION} -b hotio && \
    COMMIT_DATE=$(date -u --date=@$(git show -s --format=%ct ${UNPACKERR_VERSION}) +'%Y-%m-%dT%H:%M:%SZ') && sed -i "s/DATE=.*/DATE=${COMMIT_DATE}/g" .metadata.sh && \
    CGO_ENABLED=0 make unpackerr.amd64.linux

FROM hotio/base@sha256:29d40ed2eecd505d6f6c2c460f732ee5fa2a20d87d17aacdd50a9d6e098b0afe

ARG DEBIAN_FRONTEND="noninteractive"

# install app
COPY --from=builder /unpackerr/unpackerr.amd64.linux ${APP_DIR}/unpackerr
RUN chmod 755 "${APP_DIR}/unpackerr"

COPY root/ /
