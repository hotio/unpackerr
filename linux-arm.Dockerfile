FROM hotio/base@sha256:5193797b5db238405f64036a60a0f59d425050bc10cfc708eccd91cf5f38c18a

ARG DEBIAN_FRONTEND="noninteractive"

ARG UNPACKERR_VERSION=0.7.0-beta1

# install unpackerr
RUN curl -fsSL "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.armhf.linux.gz" | gunzip | dd of="${APP_DIR}/unpackerr" && chmod 755 "${APP_DIR}/unpackerr"

COPY root/ /
