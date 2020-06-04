FROM alpine:3.12 as builder
RUN apk add --no-cache gzip
ARG UNPACKERR_VERSION
RUN gzfile="/tmp/unpackerr.gz" && wget -O "${gzfile}" "https://github.com/davidnewhall/unpackerr/releases/download/v${UNPACKERR_VERSION}/unpackerr.amd64.linux.gz" && gunzip -c "${gzfile}" | dd of="/tmp/unpackerr" && chmod 755 "/tmp/unpackerr"

FROM hotio/base@sha256:ad79f26c53e2c7e1ed36dba0a0686990c503835134c63d9ed5aa7951e1b45c23
COPY --from=builder /tmp/unpackerr ${APP_DIR}/unpackerr
COPY root/ /
