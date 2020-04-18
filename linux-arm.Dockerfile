FROM hotio/base@sha256:9c7833cc31199260454fff82e03c29eea7211ae2bb128b3ba4b620c0d5c2b018

ARG DEBIAN_FRONTEND="noninteractive"

ARG UNPACKERR_VERSION

# install app
RUN gzfile="/tmp/unpackerr.gz" && curl -fsSL -o "${gzfile}" "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.armhf.linux.gz" && gunzip -c "${gzfile}" | dd of="${APP_DIR}/unpackerr" && chmod 755 "${APP_DIR}/unpackerr" && rm "${gzfile}"

COPY root/ /
