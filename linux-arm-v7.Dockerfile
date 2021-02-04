FROM golang:stretch as builder

ARG VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout ${VERSION} -b hotio && \
    COMMIT_DATE=$(date -u --date=@$(git show -s --format=%ct ${VERSION}) +'%Y-%m-%dT%H:%M:%SZ') && sed -i -e "s/DATE=.*/DATE=${COMMIT_DATE}/g" -e "s/COMPRESS=true/COMPRESS=false/g" .metadata.sh && \
    CGO_ENABLED=0 make unpackerr.armhf.linux

FROM hotio/base@sha256:d467e7bab4178ba8a2a635b510ccc76cf73fef193c3e86026c334071eaca2886
RUN mkdir /etc/unpackerr && ln -s "${CONFIG_DIR}/app/unpackerr.conf" /etc/unpackerr/unpackerr.conf
COPY --from=builder /unpackerr/unpackerr.armhf.linux ${APP_DIR}/unpackerr
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
