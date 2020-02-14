FROM hotio/base@sha256:73ecba782cae2d4d6a1b229ef5301220d58638aed30e261358ac09eb49ff3391

ARG DEBIAN_FRONTEND="noninteractive"

ARG UNPACKERR_VERSION=0.7.0-beta1

# install app
RUN gzfile="/tmp/unpackerr.gz" && curl -fsSL -o "${gzfile}" "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.arm64.linux.gz" && gunzip -c "${gzfile}" | dd of="${APP_DIR}/unpackerr" && chmod 755 "${APP_DIR}/unpackerr" && rm "${gzfile}"

COPY root/ /
