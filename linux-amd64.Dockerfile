FROM hotio/base@sha256:0c08ec65409a84cc6cc0110faf6cb6fdd1bcfbe1620d029189b34300f7bdf3ae

ARG DEBIAN_FRONTEND="noninteractive"

ARG UNPACKERR_VERSION

# install app
RUN gzfile="/tmp/unpackerr.gz" && curl -fsSL -o "${gzfile}" "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.amd64.linux.gz" && gunzip -c "${gzfile}" | dd of="${APP_DIR}/unpackerr" && chmod 755 "${APP_DIR}/unpackerr" && rm "${gzfile}"

COPY root/ /
