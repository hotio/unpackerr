FROM hotio/base@sha256:4a7639467e698caaf379f8edb84b226ffccb6f4643372e09a0cca0bba037966b

ARG DEBIAN_FRONTEND="noninteractive"

ARG UNPACKERR_VERSION=0.7.0

# install app
RUN gzfile="/tmp/unpackerr.gz" && curl -fsSL -o "${gzfile}" "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.arm64.linux.gz" && gunzip -c "${gzfile}" | dd of="${APP_DIR}/unpackerr" && chmod 755 "${APP_DIR}/unpackerr" && rm "${gzfile}"

COPY root/ /
