FROM golang:stretch as builder

ARG VERSION

RUN git clone -n https://github.com/davidnewhall/unpackerr.git /unpackerr && cd /unpackerr && \
    git checkout v${VERSION} -b hotio && \
    COMMIT_DATE=$(date -u --date=@$(git show -s --format=%ct v${VERSION}) +'%Y-%m-%dT%H:%M:%SZ') && sed -i -e "s/DATE=.*/DATE=${COMMIT_DATE}/g" -e "s/COMPRESS=true/COMPRESS=false/g" .metadata.sh && \
    CGO_ENABLED=0 make unpackerr.arm64.linux

FROM hotio/base@sha256:b3293df11d364305a12e1df4a09304d01589036c8380387d32089ab395b18cc8
RUN mkdir /etc/unpackerr && ln -s "${CONFIG_DIR}/app/unpackerr.conf" /etc/unpackerr/unpackerr.conf
COPY --from=builder /unpackerr/unpackerr.arm64.linux ${APP_DIR}/unpackerr
RUN chmod 755 "${APP_DIR}/unpackerr"
COPY root/ /
