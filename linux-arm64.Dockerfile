FROM hotio/base@sha256:c2d33b2a7cff2d5fa904dbf66708b62bb53c2cefe542fb02d53eea2d29be68f1

ARG DEBIAN_FRONTEND="noninteractive"

ARG UNPACKERR_VERSION

# install app
RUN gzfile="/tmp/unpackerr.gz" && curl -fsSL -o "${gzfile}" "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.arm64.linux.gz" && gunzip -c "${gzfile}" | dd of="${APP_DIR}/unpackerr" && chmod 755 "${APP_DIR}/unpackerr" && rm "${gzfile}"

COPY root/ /
