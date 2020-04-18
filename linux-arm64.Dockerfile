FROM hotio/base@sha256:e0a32794663c42ab2b15dcbaadc560dd8c4d6b8f90b61a49d8d11048189fbeb1

ARG DEBIAN_FRONTEND="noninteractive"

ARG UNPACKERR_VERSION

# install app
RUN gzfile="/tmp/unpackerr.gz" && curl -fsSL -o "${gzfile}" "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.arm64.linux.gz" && gunzip -c "${gzfile}" | dd of="${APP_DIR}/unpackerr" && chmod 755 "${APP_DIR}/unpackerr" && rm "${gzfile}"

COPY root/ /
