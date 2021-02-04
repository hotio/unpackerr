FROM golang:stretch as builder

ARG VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout ${VERSION} -b hotio && \
    COMMIT_DATE=$(date -u --date=@$(git show -s --format=%ct ${VERSION}) +'%Y-%m-%dT%H:%M:%SZ') && sed -i -e "s/DATE=.*/DATE=${COMMIT_DATE}/g" -e "s/COMPRESS=true/COMPRESS=false/g" .metadata.sh && \
    CGO_ENABLED=0 make unpackerr.armhf.linux

FROM hotio/base@sha256:c564bcaf3fcbe846e5d85a9aca3c3c6812d23d0bbcda62ef573e1c47ad5700ac
RUN mkdir /etc/unpackerr && ln -s "${CONFIG_DIR}/app/unpackerr.conf" /etc/unpackerr/unpackerr.conf
COPY --from=builder /unpackerr/unpackerr.armhf.linux ${APP_DIR}/unpackerr
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
