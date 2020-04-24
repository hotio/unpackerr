FROM golang:stretch as builder

ARG UNPACKERR_VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout ${UNPACKERR_VERSION} -b hotio && \
    COMMIT_DATE=$(date -u --date=@$(git show -s --format=%ct ${UNPACKERR_VERSION}) +'%Y-%m-%dT%H:%M:%SZ') && sed -i "s/DATE=.*/DATE=${COMMIT_DATE}/g" .metadata.sh && \
    CGO_ENABLED=0 make unpackerr.armhf.linux

FROM hotio/base@sha256:303b7670596f63e071bc6cbad20d2d5ae7e75933477f1f7e648ff63eab80a053

ARG DEBIAN_FRONTEND="noninteractive"

# install app
COPY --from=builder /unpackerr/unpackerr.armhf.linux ${APP_DIR}/unpackerr
RUN chmod 755 "${APP_DIR}/unpackerr"

COPY root/ /
