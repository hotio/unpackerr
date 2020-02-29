FROM hotio/base@sha256:0f5f319c48b975be04c4c420bf8adaf187129179c21e9f3d6cd623794982d169

ARG DEBIAN_FRONTEND="noninteractive"

ARG UNPACKERR_VERSION=0.7.0

# install app
RUN gzfile="/tmp/unpackerr.gz" && curl -fsSL -o "${gzfile}" "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.arm64.linux.gz" && gunzip -c "${gzfile}" | dd of="${APP_DIR}/unpackerr" && chmod 755 "${APP_DIR}/unpackerr" && rm "${gzfile}"

COPY root/ /
