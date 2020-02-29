FROM hotio/base@sha256:8598d7707dd3e8471cf80df6a471a1f100f207ca5f1e33b08e6b0a64d961e3dd

ARG DEBIAN_FRONTEND="noninteractive"

ARG UNPACKERR_VERSION=0.7.0

# install app
RUN gzfile="/tmp/unpackerr.gz" && curl -fsSL -o "${gzfile}" "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.armhf.linux.gz" && gunzip -c "${gzfile}" | dd of="${APP_DIR}/unpackerr" && chmod 755 "${APP_DIR}/unpackerr" && rm "${gzfile}"

COPY root/ /
